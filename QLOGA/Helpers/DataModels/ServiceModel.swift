//
//  ServiceModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Foundation
import SwiftUI

enum ServiceCleaningType: String, CaseIterable, Identifiable {
    case Windows
    case Bathroom
    case Kitchen
    case BedroomLivingroom
    case CompleteHome
    case ClothesLaundryIroning
    case GarrageCleaning
    case SwimmingPoolCleaning
    case OvenCleaning

    // MARK: Internal

    var id: String { self.rawValue }

    var title: String {
        switch self {
            case .Windows:
                return "Windows cleaning"
            case .Bathroom:
                return "Bathroom and toilet cleaning"
            case .Kitchen:
                return "Kitchen cleaning"
            case .BedroomLivingroom:
                return "Bedroom or living room cleaning"
            case .CompleteHome:
                return "Complete home cleaning"
            case .ClothesLaundryIroning:
                return "Clothes laundry and ironing"
            case .GarrageCleaning:
                return "Garrage cleaning"
            case .SwimmingPoolCleaning:
                return "Swimming pool cleaning"
            case .OvenCleaning:
                return "Oven cleaning"
        }
    }

    var timeNorm: Int {
        switch self {
            case .Windows:
                return 30
            case .Bathroom:
                return 30
            case .Kitchen:
                return 30
            case .BedroomLivingroom:
                return 30
            case .CompleteHome:
                return 30
            case .ClothesLaundryIroning:
                return 30
            case .GarrageCleaning:
                return 30
            case .SwimmingPoolCleaning:
                return 30
            case .OvenCleaning:
                return 30
        }
    }
}

struct Service: Identifiable {
    // MARK: Lifecycle

    init(id: Int, image: String, name: String, description: String?, types: [ServiceCleaningType] = [], timeNorm: Int = 30) {
        self.id = id
        self.image = image
        self.name = name
        self.description = description
        self.types = types
        self.timeNorm = timeNorm
    }

    // MARK: Internal

    var id: Int
    var image: String
    var name: String
    var description: String?
    var types: [ServiceCleaningType]
    var timeNorm: Int
}

let Services: [Service] = [
    Service(id : 0, image : "Cleaning", name : "Cleaning", description :
                "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.",
            types: [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : 1, image : "Pets", name : "Pets", description : "", types : []),
    Service(id : 10, image : "Gas", name : "Gas", description : "", types : []),
    Service(id : 11, image : "Education", name : "Education", description : "", types : []),
    Service(id : 12, image : "Computing", name : "Computing", description : "", types : []),
    Service(id : 13, image : "Gardening", name : "Gardening", description : "", types : []),
    Service(id : 2, image : "Care", name : "Care", description : "", types : []),
    Service(id : 3, image : "Handyman", name : "Handyman", description : "", types : []),
    Service(id : 4, image : "Plumbing", name : "Plumbing", description : "", types : []),
    Service(id : 5, image : "Electrical", name : "Electrical", description : "", types : []),
    Service(id : 6, image : "Cargo", name : "Cargo", description : "", types : []),
    Service(id : 7, image : "Hair", name : "Hair", description : "", types : []),
    Service(id : 8, image : "Nails", name : "Nails", description : "", types : []),
    Service(id : 9, image : "Care-1", name : "Care", description : "", types : [])
]
