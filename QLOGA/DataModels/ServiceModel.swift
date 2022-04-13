//
//  ServiceModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Foundation
import SwiftUI


struct Service: Identifiable, Hashable {
    // MARK: Lifecycle

    init(id: CategoryType, image: String = "Computing", name: String = "", description: String = "", types: [ServiceCleaningType] = [], timeNorm: Int = 30) {
        self.id = id.id
        self.image = image
        self.name = name
        self.description = description
        self.services = types
        self.timeNorm = timeNorm
    }

    var id: CategoryType.ID
    var image: String
    var name: String
    var description: String?
    var services: [ServiceCleaningType]
    var timeNorm: Int
}






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

    static var allCases: Set<ServiceCleaningType.RawValue> = [ServiceCleaningType.CompleteHome.id, ServiceCleaningType.SwimmingPoolCleaning.id, ServiceCleaningType.GarrageCleaning.id, ServiceCleaningType.OvenCleaning.id, ServiceCleaningType.Kitchen.id, ServiceCleaningType.Bathroom.id, ServiceCleaningType.BedroomLivingroom.id, ServiceCleaningType.ClothesLaundryIroning.id, ServiceCleaningType.Windows.id]

    // MARK: Internal

    var id: String { self.rawValue }
    //    var code: ServiceType.ID { ServiceType.init(rawValue: <#T##Int#>) }
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

let providerServices: [Service] = [
    Service(id : .Cleaning, image : "Cleaning", name : "Cleaning", description :
                "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.",
            types: [.ClothesLaundryIroning, .Windows, .Kitchen]),
    Service(id : .Pets, image : "Pets", name : "Pets", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Gas, image : "Gas", name : "Gas", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.Bathroom]),
    Service(id : .Education, image : "Education", name : "Education", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Computing, image : "Computing", name : "Computing", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Gardening, image : "Gardening", name : "Gardening", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.Windows, .BedroomLivingroom]),
    Service(id : .Care, image : "Care", name : "Care", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Handyman, image : "Handyman", name : "Handyman", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Plumbing, image : "Plumbing", name : "Plumbing", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Electrical, image : "Electrical", name : "Electrical", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Joinery, image : "Joinery", name : "Joinery", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Hair, image : "Hair", name : "Hair", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Nails, image : "Nails", name : "Nails", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : []),
    Service(id : .Locksmith, image : "Locksmith", name : "Locksmith", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [])
]


let Services: [Service] = [
    Service(id : .Gas, image : "Gas", name : "Gas", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Cleaning, image : "Cleaning", name : "Cleaning", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.",
        types: [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Pets, image : "Pets", name : "Pets", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Plumbing, image : "Plumbing", name : "Plumbing", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Handyman, image : "Handyman", name : "Handyman", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Education, image : "Education", name : "Education", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Computing, image : "Computing", name : "Computing", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Gardening, image : "Gardening", name : "Gardening", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Hair, image : "Hair", name : "Hair", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Care, image : "Care", name : "Care", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Joinery, image : "Joinery", name : "Joinery", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Electrical, image : "Electrical", name : "Electrical", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Locksmith, image : "Locksmith", name : "Locksmith", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
    Service(id : .Nails, image : "Nails", name : "Nails", description : "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.", types : [.CompleteHome, .SwimmingPoolCleaning, .GarrageCleaning, .OvenCleaning, .Kitchen, .Bathroom, .BedroomLivingroom, .ClothesLaundryIroning, .Windows]),
]
