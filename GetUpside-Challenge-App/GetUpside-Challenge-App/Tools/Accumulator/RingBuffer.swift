import Foundation

struct RingBuffer<Element> {
    private var array: ContiguousArray<Element?>
    
    private let capacity: Int
    private var currIndex = 0
    
    init(_ capacity: Int) {
        self.capacity = capacity
        self.array = ContiguousArray<Element?>(repeating: nil, count: capacity)
    }
    
    mutating func write(_ element: Element) {
        defer {
            currIndex += 1
        }
        array[wrapped: currIndex] = element
    }
}

extension RingBuffer: Sequence {
  func makeIterator() -> AnyIterator<Element> {
      var index = 0
      return AnyIterator {
          guard index < Swift.min(currIndex + 1, array.count) else { return nil }
          defer {
              index += 1
          }
          return array[wrapped: index]
      }
  }
}

private extension ContiguousArray {
  subscript(wrapped index: Int) -> Element {
    get {
        return self[index % count]
    }
    set {
        self[index % count] = newValue
    }
  }
}
