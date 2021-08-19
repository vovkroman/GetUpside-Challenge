import Foundation

func any<T: Equatable>(
    value: T, items: T...
) -> Bool {
  return items.contains(value)
}
