//
//  RingBuffer.swift
//  analogPhotography
//
//  Created by Andrej Hurynovič on 2.10.24.
//

class RingBuffer<T> {
    var buffer: [T?]
    private var writeIndex = 0
    private var count = 0
    private let size: Int
    
    init(size: Int) {
        self.size = size
        self.buffer = Array(repeating: nil, count: size)
    }
    
    func add(_ element: T?) {
        buffer[writeIndex] = element
        writeIndex = (writeIndex + 1) % size
        if count < size {
            count += 1
        }
    }
}
