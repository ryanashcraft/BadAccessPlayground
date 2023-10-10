import XCTest
import Promises

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

/// Port of `CombineTests.swift` to Google's Promises library
/// Does not seem to yield a `EXC_BAD_ACCESS`
final class PromisesTests: XCTestCase {
    func testNoBadAccess() {
        let expectation = expectation(description: "expectation")
        
        Promise<Item> { resolve, _ in
            Store.shared.fetchItem() { result in
                resolve(result)
            }
        }
            .then { _ in
                expectation.fulfill()
            }
        
        wait(for: [expectation])
    }
}
