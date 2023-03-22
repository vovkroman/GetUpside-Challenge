import Foundation

extension DispatchQueue {
    
    public func syncExecute<T>(work: () throws -> T) rethrows -> T {
        return try autoreleasepool {
            try sync(execute: work)
        }
    }

    public func asyncExecute(flags: DispatchWorkItemFlags = [], work: @escaping @convention(block) () -> Void) {
        autoreleasepool {
            async(flags: flags, execute: work)
        }
    }
}
