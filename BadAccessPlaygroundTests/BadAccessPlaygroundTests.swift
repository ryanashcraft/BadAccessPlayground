import XCTest
import Combine

class Item {
    deinit {
        // Shouldn't ever be called due to Store being a global singleton, but can get called randomly by Future.deinit
        // If it ever should be called, shouldn't it only be called by Store.deinit?
        print("item deinit")
    }
}

class Store {
    static let shared = Store()
    private let item: Item = Item()
    private let queue = DispatchQueue(label: "Store.queue")
    
    func fetchItem(completion: @escaping (Item) -> Void) {
        queue.async {
            completion(self.item)
        }
    }
}

final class BadAccessPlaygroundTests: XCTestCase {
    var store = Store()
    
    func testBadAccess() {
        let expectation = expectation(description: "expectation")
        var task: AnyCancellable?
        
        task = Future<Item, Never> { promise in
            self.store.fetchItem() { result in
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
