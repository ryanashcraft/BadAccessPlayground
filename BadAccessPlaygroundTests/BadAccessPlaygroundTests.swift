import XCTest
import Combine

class Item {}

class Store {
    private let item: Item = Item()
    private let queue = DispatchQueue(label: "Store.queue")
    
    func fetchItem(completion: @escaping (Item) -> Void) {
        queue.async {
            completion(self.item)
        }
    }
}

final class BadAccessPlaygroundTests: XCTestCase {
    var tasks = Set<AnyCancellable>()
    
    func testBadAccess() {
        let store = Store()
        let expectation = expectation(description: "expectation")
        
        Future<Item, Never> { promise in
            store.fetchItem() { result in
                promise(.success(result))
            }
        }
            .sink(
                receiveCompletion: { _ in
                    expectation.fulfill()
                }, receiveValue: { _ in }
            )
            .store(in: &tasks)
        
        wait(for: [expectation])
    }
}
