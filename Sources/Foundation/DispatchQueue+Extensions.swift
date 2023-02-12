//
//  DispatchQueue+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension DispatchQueue {
    /// `DispatchQueue.oy_isMainQueue`→ output → true
    public static var oy_isMainQueue: Bool {
        self === DispatchQueue.main && Thread.isMainThread
    }

    /// `DispatchQueue.oy_asyncOnMain { }`
    public static func oy_asyncOnMain(_ execute: @escaping @convention(block) () -> Void) {
        if pthread_main_np() != 0 {
            execute()
        } else {
            DispatchQueue.main.async(execute: execute)
        }
    }

    /// `DispatchQueue.oy_syncOnMain { }`
    public static func oy_syncOnMain(_ execute: @escaping @convention(block) () -> Void) {
        if pthread_main_np() != 0 {
            execute()
        } else {
            DispatchQueue.main.sync(execute: execute)
        }
    }

    /// `DispatchQueue.oy_asyncOnBackground { }`
    public static func oy_asyncOnBackground(_ execute: @escaping @convention(block) () -> Void) {
        DispatchQueue.global(qos: .background).async(execute: execute)
    }

    /// `DispatchQueue.oy_syncOnBackground { }`
    public static func oy_syncOnBackground(_ execute: @escaping @convention(block) () -> Void) {
        DispatchQueue.global(qos: .background).sync(execute: execute)
    }

    /// `DispatchQueue.oy_asyncAfter(delay: 5) { }`
    public static func oy_asyncAfter(delay: Double, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], _ execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, qos: qos, flags: flags, execute: execute)
    }
}
