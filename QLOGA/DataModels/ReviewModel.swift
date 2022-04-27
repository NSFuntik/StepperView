//
//  ReviewModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/10/22.
//

import Foundation

struct Review: Hashable, Identifiable {
    var id: Self { self }
    let image: String
    let rate: Float
    let description: String

    init(image: String = "Avatar", rate: Float = 5.0, description: String = "") {
        self.image = image
        self.rate = rate
        self.description = description
    }
}

let testReviews = [Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "Avatar", rate: 3.9, description: "Prompt payment, polite and respectful"),
                  Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "WomanCleaner", rate: 4.6, description: "Prompt payment, polite and respectful"),
                  Review(image: "Avatar", rate: 1.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "WomanCleaner", rate: 3.7, description: "Prompt payment, polite and respectful"),
                  Review(image: "Avatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "Avatar", rate: 2.2, description: "Prompt payment, polite and respectful"),
                  Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "Avatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                  Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful")]
