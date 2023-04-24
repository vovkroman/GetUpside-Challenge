import Foundation

class Accmulator<Element> {
    
    private var buffer: RingBuffer<Element>
    private let capacity: Int
    
    var elements: [Element] {
        var elemens: [Element] = []
        for item in buffer {
            elemens.append(item)
        }
        return elemens
    }
    
    func write(_ elements: [Element]) {
        let count = elements.count
        for element in elements[Swift.max(0, count - capacity)..<count] {
            buffer.write(element)
        }
    }
        
    init(_ capacity: Int) {
        self.capacity = capacity
        self.buffer = RingBuffer(capacity)
    }
}
