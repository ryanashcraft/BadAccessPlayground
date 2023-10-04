import XCTest
import Combine

class Item {
    deinit {
        // Randomly called by Future.deinit
        // How does this instance's retain count go to zero?
        // Shouldn't the Store retain this, preventing it from being freed?
        // The Store itself is never deinitialized
        print("item deinit")
    }
}

class Store {
    static let shared = Store()
    private let item: Item = Item()
    private let queue = DispatchQueue(label: "Store.queue")
    
    deinit {
        // Let's rule out the Store instance being deinitialized
        fatalError("store deinit")
    }
    
    func fetchItem(completion: @escaping (Item) -> Void) {
        queue.async {
            completion(self.item)
        }
    }
}

final class BadAccessPlaygroundTests: XCTestCase {
    func testBadAccess() {
        let expectation = expectation(description: "expectation")
        var task: AnyCancellable?
        
        task = Future<Item, Never> { promise in
            Store.shared.fetchItem() { result in
                promise(.success(result))
            }
        }
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                    task?.cancel()
                }, receiveValue: { _ in }
            )
        
        wait(for: [expectation])
    }
}
