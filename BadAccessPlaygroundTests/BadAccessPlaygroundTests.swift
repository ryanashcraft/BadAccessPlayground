import XCTest
import Combine

class Item {}

final class BadAccessPlaygroundTests: XCTestCase {
    func testBadAccess() async {
        let item = await Future<Item, Never> { promise in
            DispatchQueue.global().async {
                promise(.success(Item()))
            }
        }
        .value
    }
}
