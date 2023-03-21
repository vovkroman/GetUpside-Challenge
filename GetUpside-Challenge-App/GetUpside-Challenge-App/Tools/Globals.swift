import Foundation

func combine<A>(
    with closure: @escaping () -> A) -> () -> A {
    return { closure() }
}

func combine<A, B>(
    _ value: A,
    with closure: @escaping (A) -> B) -> () -> B {
    return { closure(value) }
}

func combine<A, B, C>(
    _ value1: A,
    _ value2: B,
    with closure: @escaping (A, B) -> C) -> () -> C {
    return { closure(value1, value2) }
}

func combine<A, B, C, D>(
    _ value1: A,
    _ value2: B,
    _ value3: C,
    with closure: @escaping (A, B, C) -> D) -> () -> D {
    return { closure(value1, value2, value3) }
}

func combine<A, B>(
    _ value: A,
    with closure: @escaping (A) throws -> B) -> () throws -> B {
    return { try closure(value) }
}
