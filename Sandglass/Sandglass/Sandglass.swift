//
// Created by Bruce Jackson on 2017/9/30.
// Copyright (c) 2017 zysios. All rights reserved.
//

import Foundation

class Sandglass {

    private(set) var running = false

    private let timerSource: DispatchSourceTimer

    class func scheduleOneshot(interval: TimeInterval,
                               queue: DispatchQueue = .main,
                               action: @escaping () -> ()) -> Sandglass {
        let timer = Sandglass(interval: interval, queue: queue, action: action)
        timer.start()

        return timer
    }

    class func scheduleRepeating(interval: TimeInterval,
                                 queue: DispatchQueue = .main,
                                 action: @escaping () -> ()) -> Sandglass {
        let timer = Sandglass(interval: interval, repeats: true, queue: queue, action: action)
        timer.start()

        return timer
    }

    init(interval: TimeInterval, repeats: Bool = false, queue: DispatchQueue = .main, action: @escaping () -> ()) {
        timerSource = DispatchSource.makeTimerSource(queue: queue)
        timerSource.setEventHandler(handler: action)

        if !repeats {
            timerSource.schedule(deadline: .now() + interval, repeating: .never)
        } else {
            timerSource.schedule(deadline: .now() + interval, repeating: interval)
        }
    }

    func start() {
        guard !running else {
            return
        }

        if #available(iOS 10.0, *) {
            timerSource.activate()
        } else {
            timerSource.resume()
        }

        running = true
    }

    func suspend() {
        timerSource.suspend()
        running = false
    }

    func resume() {
        guard !running else {
            return
        }

        timerSource.resume()
        running = true
    }

    func cancel() {
        timerSource.cancel()
        running = false
    }

}
