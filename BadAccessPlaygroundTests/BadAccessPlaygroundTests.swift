import XCTest
import Combine

@testable import BadAccessPlayground

final class BadAccessPlaygroundTests: XCTestCase {
    let loopCount = 5000
    let maxItemCount = 1000
    
    func testBadAccess() {
        let store = Store()

        for i in 0 ..< loopCount {
            let expectation = expectation(description: "expectation \(i)")
            
            var task: AnyCancellable?

            task = (0 ..< maxItemCount)
                .publisher
                .flatMap { x in
                    Future<[Item], Never> { promise in
                        Task {
                            let result = try! await store.fetchItems(count: x)
                            promise(.success(result))
                        }
                    }
                }
                .assertNoFailure()
                .collect()
                .sink { _ in
                    expectation.fulfill()
                    task?.cancel()
                }
            
            wait(for: [expectation], timeout: 100)
        }
    }
}
