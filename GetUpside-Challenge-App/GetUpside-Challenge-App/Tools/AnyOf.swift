import Foundation

func any<T: Equatable>(lhs: T, rhs: T...) -> Bool {
  return rhs.contains(lhs)
}
