//
//  Array+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Array {
    /// `Array.oy_init(item: "A", repeatCount: 3)` → output → ["A", "A", "A"]
    public static func oy_init(item: Element, `repeat`: Int) -> Self {
        [Element](repeating: item, count: `repeat`)
    }
    
    /// `[1, 2, 3, 4, 1].oy_item(at: 2)` → output → 3
    /// `[1, 2, 3, 4, 1].oy_item(at: 9)` → output → nil
    public func oy_item(at index: Int) -> Element? {
        guard count > index else {
            return nil
        }
        return self[index]
    }
    
    /// `[1, 2, 3].oy_item(at: 4, default: 0)` → output → 0
    public func oy_item(at index: Int, `default`: Element) -> Element {
        if Int(index) >= count {
            return `default`
        }
        return self[index]
    }

    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.oy_item(keyPath: \.name, equals: "Steve")`
    public func oy_item<Value: Comparable>(keyPath: KeyPath<Element, Value>, equals: Value) -> Element? {
        first { $0[keyPath: keyPath] == equals }
    }
    
    /// `["a", "b", "c", "d"].oy_items(indexes: [0, 2, 8])` → output → ["a", "c"]
    public func oy_items(indexes: [Int]) -> [Element] {
        enumerated().filter { indexes.contains($0.offset) }.map(\.element)
    }
    
    /// let set = IndexSet(arrayLiteral: 0, 2, 8)
    /// `["a", "b", "c", "d"].oy_items(indexSet: set)` → output → ["a", "c"]
    public func oy_items(indexSet: IndexSet) -> [Element] {
        enumerated().filter { indexSet.contains($0.offset) }.map(\.element)
    }

    /// `["a", "b", "c", "d"].oy_items(from: 2)` → output → ["c", "d"]`
    public func oy_items(from: Int) -> SubSequence {
        let partialRangeFrom = from...
        return self[partialRangeFrom]
    }
    
    /// `["a", "b", "c", "d"].oy_items(through: 2)` → output → ["a", "b", "c"]`
    public func oy_items(through: Int) -> SubSequence {
        let partialRangeThrough = ...through
        return self[partialRangeThrough]
    }
    
    /// `["a", "b", "c", "d"].oy_items(upTo: 2)` → output → ["a", "b"]`
    public func oy_items(upTo: Int) -> SubSequence {
        let partialRangeUpTo = ..<upTo
        return self[partialRangeUpTo]
    }
    
    /// `["a", "b", "c", "d", "e"].oy_items(from: 1, to: 3)` → output → ["b", "c", "d"]`
    public func oy_items(from: Int, to: Int) -> SubSequence {
        let closedRange = from...to
        return self[closedRange]
    }
    
    /// `["a", "b", "c", "d"].oy_items(prefix: 2)` → output → ["a", "b"]
    public func oy_items(prefix: Int) -> [Element] {
        Array(self.prefix(prefix))
    }
    
    /// `["a", "b", "c", "d"].oy_items(suffix: 2)` → output → ["c", "d"]
    public func oy_items(suffix: Int) -> [Element] {
        Array(self.suffix(suffix))
    }

    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.oy_items(keyPath: \.name, equals: "Steve")`
    public func oy_items<Value: Comparable>(keyPath: KeyPath<Element, Value>, equals: Value) -> [Element] {
        var result = [Element]()

        for item in self where item[keyPath: keyPath] == equals {
            result.append(item)
        }
        return result
    }

    /// `[1, 2, 3, 4].oy_first` → output → 1
    public var oy_first: Element? {
        if isEmpty {
            return .none
        } else {
            return self[0]
        }
    }

    /// `[1, 2, 3, 4].oy_last` → output → 4
    public var oy_last: Element? {
        if isEmpty {
            return .none
        } else {
            return self[count - 1]
        }
    }

    /// `[1, 2, 3, 4, 5].oy_remove(at: 1, 4)` → output → [1,  3,  4]
    public mutating func oy_remove(at indexes: Int...) {
        let indexes = indexes.filter({ $0 < count }).oy_sortDescending()
        indexes.forEach { remove(at: $0) }
    }

    /// `[1, 2, 2, 3, 4, 5].oy_remove(item: 3)` → output → [1,  2,  4,  5]
    public mutating func oy_remove(item: Element) where Element: Equatable {
        removeAll(where: { $0 == item })
    }

    /// `[1, 2, 2, 3, 4, 5].oy_remove(items: [2,5])` → output → [1,  3,  4]
    public mutating func oy_remove(items: [Element]) where Element: Equatable {
        guard !items.isEmpty else { return }
        removeAll(where: { items.contains($0) })
    }
    
    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.oy_remove(keyPath: \.name, equals: "Steve")`
    public mutating func oy_remove<Value: Comparable>(keyPath: KeyPath<Element, Value>, equals: Value) where Element: Equatable {
        let item = first { $0[keyPath: keyPath] == equals }
        removeAll(where: { $0 == item })
    }

    /// `[1, 2, 2, 3, 4, 5, 5].oy_indexOf(item: 2)` → output → 1
    public func oy_indexOf(item: Element) -> Int? where Element: Equatable {
        firstIndex(of: item)
    }

    /// `[1, 2, 2, 3, 4, 5, 5].oy_indexesOf(item: 2)` → output → [1, 2]
    public func oy_indexesOf(item: Element) -> [Int] where Element: Equatable {
        enumerated().compactMap { ($0.element == item) ? $0.offset: nil }
    }

    /// `["a", "b", "c", "d"].oy_indexesOf(items: ["b", "c"])` → output → [1, 2]
    public func oy_indexesOf(items: [Element]) -> [Int] where Element: Equatable {
        enumerated().compactMap { (items.oy_contains($0.element)) ? $0.offset: nil }
    }
    
    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.oy_indexOf(keyPath: \.name, equals: "Steve")`
    public func oy_indexOf<Value: Comparable>(keyPath: KeyPath<Element, Value>, equals: Value) -> Int? where Element: Equatable {
        for item in self where item[keyPath: keyPath] == equals {
            return firstIndex(of: item)
        }
        return nil
    }

    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.indexesOf(keyPath: \.name, equals: "Steve")`
    public func indexesOf<Value: Comparable>(keyPath: KeyPath<Element, Value>, equals: Value) -> [Int] where Element: Equatable {
        for item in self where item[keyPath: keyPath] == equals {
            return enumerated().compactMap { ($0.element == item) ? $0.offset: nil }
        }
        return []
    }

    /// `[1, 2, 2, 3, 4, 5, 5].oy_lastIndexOf(item: 2)` → output → 2
    public func oy_lastIndexOf(item: Element) -> Int? where Element: Equatable {
        lastIndex(of: item)
    }

    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.oy_lastIndexOf(keyPath: \.name, equals: "Steve")`
    public func oy_lastIndexOf<Value: Comparable>(keyPath: KeyPath<Element, Value>, equals: Value) -> Int? where Element: Equatable {
        for item in self where item[keyPath: keyPath] == equals {
            return lastIndex(of: item)
        }
        return nil
    }

    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.oy_sort(keyPath: \.familyName,  by: >)`
    public func oy_sort<Value: Comparable>(keyPath: KeyPath<Element, Value>, by: (Value, Value) -> Bool) -> [Element] {
        sorted { lhs, rhs -> Bool in
            by(lhs[keyPath: keyPath], rhs[keyPath: keyPath])
        }
    }
    
    /// `[3, 1, 2].oy_sortAscending()`→ output → [1, ,2 , 3]
    public func oy_sortAscending() -> Self where Element: Comparable {
        sorted { lhs, rhs in lhs < rhs }
    }

    /// `[3, 1, 2].oy_sortDescending()`→ output → [3, ,2 , 1]
    public func oy_sortDescending() -> Self where Element: Comparable {
        sorted { lhs, rhs in lhs > rhs }
    }
    
    /// `[1, 2, 3, 4, 5, 6, 7].oy_split(by: 3)`→ output → [[1, 2, 3], [4, 5, 6], [7]]
    public func oy_split(by itemCount: Int) -> [[Element]] {
        stride(from: 0, to: count, by: itemCount).map {
            Array(self[$0..<Swift.min($0 + itemCount, count)])
        }
    }
    
    /// `[1, 2, 2, 3, 4, 5, 5].oy_nonDuplicates()` → output → [1, 2, 3, 4, 5]
    public func oy_nonDuplicates() -> [Element] where Iterator.Element: Hashable {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
    
    /// let students = [1, 2, 2, 3, 3, 3].map({ Student(id: $0) })
    /// `students.oy_nonDuplicates(keyPath: \.id)` → output → [Student(id: 1), Student(id: 2), Student(id: 3)]
    public func oy_nonDuplicates<T: Hashable>(keyPath: KeyPath<Element, T>) -> Self {
        var unique = Set<T>()
        return filter { unique.insert($0[keyPath: keyPath]).inserted }
    }

    /// `[1, 2, 2, 3, 4, 5, 5].oy_nonDuplicated()` → output → [1, 2, 3, 4, 5]
    public mutating func oy_nonDuplicated() where Iterator.Element: Hashable {
        self = oy_nonDuplicates()
    }
    
    /// let students = [1, 2, 2, 3, 3, 3].map({ Student(id: $0) })
    /// `students.oy_nonDuplicated(keyPath: \.id)` → output → [Student(id: 1), Student(id: 2), Student(id: 3)]
    public mutating func oy_nonDuplicated<T: Hashable>(keyPath: KeyPath<Element, T>) {
        self = oy_nonDuplicates(keyPath: keyPath)
    }

    /// var array = [1, 2, 2, 3, 4, 5, 5]
    /// `array.oy_clearAllDuplicatedItems()` → output → [1, 3, 4]
    public mutating func oy_clearAllDuplicatedItems() where Element: Equatable {
        self = reduce(into: [Element]()) { result, item in
            if filter({ $0 == item }).count <= 1 {
                result.append(item)
            }
        }
    }

    /// let students = [1, 2, 2, 3, 3, 3].map({ Student(id: $0) })
    /// `students.oy_clearAllDuplicatedItems(keyPath: \.id)` → output → [Student(id: 1)]
    public mutating func oy_clearAllDuplicatedItems<T: Hashable>(keyPath: KeyPath<Element, T>) where Element: Equatable {
        self = reduce(into: [Element]()) { result, item in
            if filter({ $0 == item }).count <= 1 {
                result.append(item)
            }
        }
    }

    /// `[1, 1, 2, 2, 3, 3, 3, 4, 5].oy_duplicatedItems()` → output → [1, 2, 3]
    public func oy_duplicatedItems() -> [Element] where Element: Hashable {
        var set = Set<Element>()
        var duplicates = Set<Element>()
        forEach {
            if !set.insert($0).inserted {
                duplicates.insert($0)
            }
        }
        return Array(duplicates)
    }

    /// `[1, 2, 3].oy_isSameArray(as: [1, 2, 3])` → output → true
    public func oy_isSameArray(as items: [Element]) -> Bool where Element: Comparable {
        count == items.count && sorted() == items.sorted()
    }
    
    /// var array: [Any?] = [1, 2, 3, nil]
    /// `array.oy_clearNilValues()` → output → [1, 2, 3]]
    public mutating func oy_clearNilValues() where Element == Any? {
        let compacted = compactMap({ $0 })
        self = compacted
    }

    /// Split array of elements into chunks of a size  specify
    /// `[1, 2, 3, 4, 5, 6, 7].oy_chunk(size: 3)` → output →  [[1,2,3], [4,5,6], [7]]
    public func oy_chunk(size: Int) -> [[Element]] {
        stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }

    /// `[1, 2, 3, 4, 1].oy_count(where: { $0 == 1 })` → output → 2
    public func oy_count(where isIncluded: (Element) -> Bool) -> Int {
        filter(isIncluded).count
    }

    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.oy_count(keyPath: \.name, equals: "Steve")` → output → 2
    public func oy_count<Value: Comparable>(keyPath: KeyPath<Element, Value>, equals: Value) -> Int where Element: Equatable {
        filter({ $0[keyPath: keyPath] == equals }).count
    }

    /// `[1, 2, 3, 4, 5].oy_swap(from: 3, to: 0)` → output → [4, 2, 3, 1, 5]
    public mutating func oy_swap(from: Index, to: Index) {
        guard from != to else { return }
        guard startIndex..<endIndex ~= from else { return }
        guard startIndex..<endIndex ~= to else { return }
        swapAt(from, to)
    }

    /// `[1, 2, 3, 4, 5].oy_random` → output → 3
    public var oy_random: Element? {
        guard count > 0 else { return nil }
        let index = Int.random(in: 0..<count)
        return self[index]
    }
    
    /// `[1, 2, 3, 4, 5].oy_shuffle()` → output → [3, 4, 1, 5, 2]
    public mutating func oy_shuffle() {
        self.shuffle()
    }
    
    /// `[1, 2, 3, 4, 5].oy_shuffled` → output → [3, 4, 1, 5, 2]
    public var oy_shuffled: Self {
        return shuffled()
    }

    /// struct Person {
    ///    var id: Int
    /// }
    /// `[Person(id: 1), Person(id: 2), Person(id: 3)].oy_sum(for: \.id)` → output → 6
    public func oy_sum<T: AdditiveArithmetic>(for keyPath: KeyPath<Element, T>) -> T {
        reduce(.zero) { $0 + $1[keyPath: keyPath] }
    }

    /// `[1, 2, 3, 4, 5].contains([1, 2])` → output → true
    public func oy_contains(_ items: [Element]) -> Bool where Element: Equatable {
        items.allSatisfy { contains($0) }
    }
    
    /// `[1, 2, 3, 4, 5].contains(1)` → output → true
    public func oy_contains(_ item: Element) -> Bool where Element: Equatable {
        contains(item)
    }

    /// `["Ash", "Brock", "Misty"].oy_joined(separator: ", ")` → output → "Ash, Brock, Misty"
    public func oy_joined(separator: String) -> String where Element == String {
        joined(separator: separator)
    }

    /// `["Ash", "Brock", "Misty"].oy_localizedJoined()` → output → "Ash, Brock and Misty"
    public func oy_localizedJoined(localeIdentifier: String = Locale.current.identifier) -> String where Element == String {
        if #available(iOS 13.0, *) {
            let formatter = ListFormatter()
            formatter.locale = Locale(identifier: localeIdentifier)
            return formatter.string(from: self) ?? ""
        } else {
            return oy_joined(separator: ", ")
        }
    }
}

extension Array where Element: Numeric {
    /// `[1, 2, 3, 4, 5].oy_sum` → output → 15
    public var oy_sum: Element {
        reduce(0, { $0 + $1 })
    }
}

extension Array where Element: Codable {
    /// struct Person {
    ///    var name: String
    /// }
    /// `peoples.oy_data` → output → (Foundation.Data?) 19 bytes
    public var oy_data: Data? {
        try? JSONEncoder().encode(self)
    }
}

extension Collection {
    /// `["a", "b", "c"].oy_indexed` → output → { [0] = (offset = 0, element = "a")
    ///                                           [1] = (offset = 1, element = "b")
    ///                                           [2] = (offset = 2, element = "c")
    /// }
    public var oy_indexed: [(offset: Int, element: Element)] {
        Array(enumerated())
    }
}

extension MutableCollection {
    /// Mutating all elements of a mutable collection
    /// ` personArray.oy_mutateEach { element in
    /// `     element.name = "Jane"
    /// ` }
    public mutating func oy_mutateEach(_ body: (inout Element) throws -> Void) rethrows {
        for index in indices {
            try body(&self[index])
        }
    }
}
