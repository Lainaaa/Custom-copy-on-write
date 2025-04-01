# Custom Copy-on-Write (COW) in Swift

This project demonstrates a manual implementation of **Copy-on-Write (COW)** behavior in Swift using a combination of `struct` and an internal `final class`. This approach allows maintaining value semantics while optimizing performance by avoiding unnecessary copies.

## 🔍 Problem

By default, value types in Swift (like `struct`) are copied on every mutation. This can be inefficient if the internal data is large or expensive to copy. COW helps avoid these copies when it's safe to reuse the existing storage.

## 🧠 How It Works

- `Car` is a value type (`struct`) that wraps a reference to a private `CarStorage` class.
- The `CarStorage` class holds the actual data (`model`, `year`, `topSpeed`).
- Before mutation, the struct checks whether it uniquely owns the storage using `isKnownUniquelyReferenced`.
- If not, it makes a copy of the storage — classic COW pattern.

## ✅ Example

```swift
var bmw = Car(model: "BMW", year: 2020, topSpeed: 250)
let bmw2 = bmw

print(bmw.compare(with: bmw2)) // true

bmw.year = 2021

print(bmw.compare(with: bmw2)) // false
