//
//  AddressModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Foundation

struct Address: Hashable {
    var postcode: String
    var town: String
    var street: String
    var building: String
    var apt: String
    var latitude:Double
    var longitude :Double
    var total: String
    init(postcode: String, town: String, street: String, building: String = "", apt: String = "", _ latitude: Double = 55.95204500604529, _ longitude: Double = -3.1981850325268777) {
        self.postcode = postcode
        self.town = town
        self.street = street
        self.building = building
        self.apt = apt
        self.total = "\(self.apt)\(self.building) \(self.street) \(self.town) \(self.postcode)".replacingOccurrences(of: "  ", with: "")
        self.latitude = latitude
        self.longitude = longitude
    }
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
//                Postcode
//                Town
//                Street
//                Building
//                Apartments
//09 Princes Street, Edinburgh, GB
//3 Lupus St, Pimlico, London, GB
//Barnett House 53, Fountain Street, Manchester, GB
//30 Cloth Market, Merchant House, Newcastle upon Tyne, GB
//05 West George Street, Glasgow, GB
//54 George Street, Edinburgh, GB
//St Martin-in-the-Fields Trafalgar Square, London, GB
//14 St Mary's Pl, Newcastle upon Tyne, GB
