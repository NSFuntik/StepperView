//
//  CleaningService.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/7/22.
//

import Foundation

struct CleaningService {
    var title: String
    var unit: String
    var price: Double
    var subject: String
    var description: String
    var conditions: String
    var works: String
    var notIncluded: String

    init(title: String, unit: String, price: Double, subject: String, description: String, conditions: String, works: String, notIncluded: String) {
        self.title = title
        self.unit = unit
        self.price = price
        self.subject = subject
        self.description = description
        self.conditions = conditions
        self.works = works
        self.notIncluded = notIncluded
    }
}
