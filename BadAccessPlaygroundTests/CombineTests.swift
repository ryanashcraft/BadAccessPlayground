import XCTest
import Combine

private class Item {}

private class Store {
    static let shared = Store()
    private let item: Item = Item()
    private let queue = DispatchQueue(label: "Store.queue")
    
    func fetchItem(completion: @escaping (Item) -> Void) {
        queue.async {
            completion(self.item)
        }
    }
}

final class CombineTests: XCTestCase {
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
                }, receiveValue: { _ in }
            )
        
        wait(for: [expectation])
        task?.cancel()
    }
    
    /// Simplified test case: doesn't even use Store and still leads to an `EXC_BAD_ACCESS` with enough test iterations
    func testBadAccessSimplified() async {
        let item = await Future<Item, Never> { promise in
            DispatchQueue.global().async {
                promise(.success(Item()))
            }
        }
        .value
    }
}
