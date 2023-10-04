import XCTest
import Combine

@testable import BadAccessPlayground

final class BadAccessPlaygroundTests: XCTestCase {
    func testBadAccess() {
        let expectation = expectation(description: "expectation")
        
        badAccess {
            expectation.fulfill()
        }
        
        wait(for: [expectation])
    }
}
