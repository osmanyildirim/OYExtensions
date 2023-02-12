//
//  Publisher+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Combine

@available(iOS 13.0, *)
extension Publisher where Failure == Never {
    /// Assigns each element from a Publisher to a property on an object with a weak reference
    /// - Parameters:
    ///   - keyPath: the key path of the property to assign
    ///   - object: the object on which to assign the value
    /// - Returns: a cancellable instance; used when you end assignment of the received value
    ///
    /// Usage:
    ///
    ///         URLSession.shared.dataTaskPublisher(for: url)
    ///             .map { $0.data }
    ///             .replaceError(with: Data())
    ///             .compactMap { UIImage(data: $0) }
    ///             .receive(on: DispatchQueue.main)
    ///             .oy_assign(to: \.image, on: iv)
    ///             .store(in: &cancellables)
    ///
    public func oy_assign<T: AnyObject>(to keyPath: ReferenceWritableKeyPath<T, Output>, on object: T) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }

    /// Sing value from a Publisher with a weak reference
    /// - Parameters:
    ///   - on: strong reference
    ///   - receiveValue: value from publisher
    /// - Returns: a cancellable instance; used when you end assignment of the received value
    ///
    /// Usage:
    ///
    ///         let future = Future<Int, Never> { promise in
    ///             promise(.success(1))
    ///         }
    ///         future.oy_sink(on: self) { value in
    ///
    ///         }
    ///
    public func oy_sink<T: AnyObject>(on: T, receiveValue: @escaping (Output) -> Void) -> AnyCancellable {
        sink { [weak on] value in
            guard on != nil else { return }
            receiveValue(value)
        }
    }
}
