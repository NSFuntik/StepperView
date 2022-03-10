//
//  ServiceModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Foundation
import SwiftUI

enum ServiceType: String, CaseIterable, Identifiable  {
    case Windows
    case Kitchen
    case BedroomLivingroom
    case CompleteHome

    var id: String { self.rawValue }
}

struct Service: Identifiable {
    let id: Int
    let image: String
    let name: String
    let description: String?
    let types: [String]?

    init(id: Int, image: String, name: String, description: String?, types: [String]?) {
        self.id = id
        self.image = image
        self.name = name
        self.description = description
        self.types = types
    }
}

let Services: [Service] = [
    Service(id: 0, image: "Cleaning", name: "Cleaning", description: "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types: ["Complete home cleaning","Bathroom and toilet cleaning","Kitchen cleaning","Bedroom or living room cleaning","Clothes laundry and ironing","Garrage cleaning","Swimming pool cleaning","Owen cleaning"]),
    Service(id: 1, image: "Pets", name: "Pets", description: "", types: []),
    Service(id: 2, image: "Care", name: "Care", description: "", types: []),
    Service(id: 3, image: "Handyman", name: "Handyman", description: "", types: []),
    Service(id: 4, image: "Plumbing", name: "Plumbing", description: "", types: []),
    Service(id: 5, image: "Electrical", name: "Electrical", description: "", types: []),
    Service(id: 6, image: "Cargo", name: "Cargo", description: "", types: []),
    Service(id: 7, image: "Hair", name: "Hair", description: "", types: []),
    Service(id: 8, image: "Nails", name: "Nails", description: "", types: []),
    Service(id: 9, image: "Care-1", name: "Care", description: "", types: []),
    Service(id: 10, image: "Gas", name: "Gas",  description: "", types: []),
    Service(id: 11, image: "Education", name: "Education", description: "", types: []),
    Service(id: 12, image: "Computing", name: "Computing",  description: "", types: []),
    Service(id: 13, image: "Gardening", name: "Gardening",  description: "", types: [])
]
