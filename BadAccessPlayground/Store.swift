import Foundation

struct Item {
    let value: Int
}

private enum CacheEntry {
    case inProgress(Task<[Item], Error>)
    case ready([Item])
}

private final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) { self.entry = entry }
}

private func randomStructs(_ n: Int) -> [Item] {
    return (0 ..< n).map { Item(value: $0) }
}

actor Store {
    private var cache: NSCache<NSString, CacheEntryObject> = NSCache()

    func fetchItems(count: Int) async throws -> [Item] {
        if let cacheEntry = cache[String(count)] {
            switch cacheEntry {
            case let .inProgress(task):
                return try await task.value
            case let .ready(result):
                return result
            }
        }

        let task = Task<[Item], any Error> {
            try await Task.sleep(nanoseconds: UInt64(10))
            return randomStructs(count)
        }

        cache[String(count)] = .inProgress(task)

        do {
            let result = try await task.value
            cache[String(count)] = .ready(result)

            return result
        } catch {
            cache[String(count)] = nil
            throw error
        }
    }
}

extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject {
    subscript(_ key: String) -> CacheEntry? {
        get {
            let value = object(forKey: key as NSString)
            return value?.entry
        }

        set {
            if let entry = newValue {
                let value = CacheEntryObject(entry: entry)
                setObject(value, forKey: key as NSString)
            } else {
                removeObject(forKey: key as NSString)
            }
        }
    }
}
