//
//  ReviewModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/10/22.
//

import Foundation

struct Review: Hashable, Identifiable {
    var id: Self { self }
    let image: String?
    let rate: Float
    let description: String?

    init(image: String = "Avatar", rate: Float, description: String = "") {
        self.image = image
        self.rate = rate
        self.description = description
    }
}
