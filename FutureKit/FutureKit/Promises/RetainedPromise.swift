import Foundation

public final class RetainedPromise<Value>: Future<Value> {
    
    @inlinable
    public init(value: Value? = nil) {
        super.init()

        // If the value was already known at the time the promise
        // was constructed, we can report it directly:
        result = value.map(Result.success)
    }
    
    @inlinable
    public func resolve(with value: Value) {
        result = .success(value)
    }

    @inlinable
    public func reject(with error: Error) {
        result = .failure(error)
    }
    
    @usableFromInline
    override func report(result: Result) {
        callbacks.forEach { $0(result) }
    }
    
    deinit {
        callbacks.removeAll()
    }
}
