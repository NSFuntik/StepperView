//
//  Snooze.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/29/22.
//

import Foundation
public class Snooze {
    public func start() {
        let interval = TimeInterval(arc4random_uniform(100))
        Thread.sleep(forTimeInterval: interval)
    }
}
