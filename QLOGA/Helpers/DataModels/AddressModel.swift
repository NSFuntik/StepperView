//
//  AddressModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Foundation

struct Address: Hashable {
    // MARK: Lifecycle

    init(isBussinessOnly: Bool = false, postcode: String, town: String, street: String, building: String = "",
         apt: String = "", _ latitude: Double = 55.95204500604529, _ longitude: Double = -3.1981850325268777)
    {
        self.isBussinessOnly = isBussinessOnly
        self.postcode = postcode
        self.town = town
        self.street = street
        self.building = building
        self.apt = apt
        self.total = "\(self.apt)\(self.building) \(self.street) \(self.town) \(self.postcode)".replacingOccurrences(of: "  ", with: "")
        self.latitude = latitude
        self.longitude = longitude
    }

    // MARK: Internal

    var isBussinessOnly: Bool
    var postcode: String
    var town: String
    var street: String
    var building: String
    var apt: String
    var latitude: Double
    var longitude: Double
    var total: String
}

enum ParkingType: String, CaseIterable, Identifiable {
    case Free
    case Paid
    case Unspecified

    // MARK: Internal

    var id: String { self.rawValue }
}

let Addresses: [Address] = [
    Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "09"),
    Address(postcode: "EH2 2ER", town: "London", street: "Lupus St", building: "3"),
    Address(postcode: "EH2 2ER", town: "Newcastle upon Tyne", street: "Merchant House, Cloth Market", building: "30"),
    Address(postcode: "EH2 2ER", town: "Manchester", street: "Fountain Street", building: "53"),
    Address(postcode: "EH2 2ER", town: "Glasgow", street: "West George Street", building: "05"),
    Address(postcode: "EH2 2ER", town: "Edinburgh", street: "George Street", building: "54"),
    Address(postcode: "EH2 2ER", town: "Newcastle upon Tyne", street: "St Mary's Pl", building: "14"),
    Address(postcode: "EH2 2ER", town: "London", street: "St Martin-in-the-Fields Trafalgar Square", building: "0")
]
