//
//  Timer+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension Timer {
    public static func oy_countdown(seconds: Int,
                                    timeInterval: TimeInterval = 1,
                                    runLoopMode: RunLoop.Mode = .common,
                                    tolerance: TimeInterval = 0,
                                    handler: @escaping ((_ remaining: Int) -> Void)) {
        var seconds = seconds

        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            seconds -= 1
            if seconds == 0 {
                timer.invalidate()
            }
            handler(seconds)
        }
        timer.tolerance = tolerance
        RunLoop.main.add(timer, forMode: runLoopMode)
    }

    public static func oy_repeat(timeInterval: TimeInterval,
                                 runLoopMode: RunLoop.Mode = .common,
                                 tolerance: TimeInterval = 0,
                                 handler: @escaping ((_ counter: Int, _ timer: Timer) -> Void)) {
        var seconds = 0

        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
            seconds += 1
            if seconds == 0 {
                timer.invalidate()
            }
            handler(seconds, timer)
        }
        timer.tolerance = tolerance
        RunLoop.main.add(timer, forMode: runLoopMode)
    }
}
