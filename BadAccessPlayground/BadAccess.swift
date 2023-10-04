import Combine
import Foundation

class BAPItem {
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

    let item: BAPItem = BAPItem()
    let queue = DispatchQueue(label: "Store.queue")
    
    deinit {
        // Let's rule out the Store instance being deinitialized
        fatalError("store deinit")
    }
    
    func fetchItem(completion: @escaping ([BAPItem]) -> Void) {
        queue.async {
            completion([self.item])
        }
    }
}

func badAccess(completion: @escaping () -> Void) {
    var task: AnyCancellable?

    task = Future<[BAPItem], Never> { promise in
        Store.shared.fetchItem() { result in
            promise(.success(result))
        }
    }
        .sink(
            receiveCompletion: { _ in
                completion()
                task?.cancel()
            }, receiveValue: { _ in }
        )
}
