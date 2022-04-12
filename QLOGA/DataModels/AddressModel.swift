//
//  AddressModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Foundation


struct CstAddress: Codable, Hashable {
    init(id: Int = 0, familyId: Int? = 0, country: String = "GB", line1: String = "", line2: String = "", town: String = "", postcode: String = "", lat: Double? = 0.0, lng: Double? = 0.0, timeOffset: Int? = 0, vrfs: [CstVrf]? = [], businessOnly: Bool = false, line3: String? = "")
    {
        self.id = id
        self.familyId = familyId
        self.country = country
        self.line1 = line1
        self.line2 = line2
        self.town = town
        self.postcode = postcode
        self.lat = lat
        self.lng = lng
        self.timeOffset = timeOffset
        self.vrfs = vrfs
        self.businessOnly = businessOnly
        self.line3 = line3
        self.total = "\(self.line3 ?? "") \(self.line2) \(self.line1) \(self.town) \(self.country) \(self.postcode)".replacingOccurrences(of: "  ", with: "")

    }

    var id: Int
    var familyId: Int?
    var country: String
    var line1: String
    var line2: String
    var town: String
    var postcode: String
    var lat: Double?
    var lng: Double?
    var timeOffset: Int?
    var vrfs: [CstVrf]?
    var businessOnly: Bool = false
    var line3: String? = ""
    var total: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case familyId = "familyId"
        case country = "country"
        case line1 = "line1"
        case line2 = "line2"
        case town = "town"
        case postcode = "postcode"
        case lat = "lat"
        case lng = "lng"
        case timeOffset = "timeOffset"
        case vrfs = "vrfs"
        case businessOnly = "businessOnly"
        case line3 = "line3"
    }


    var defaultAddress: Address {
        get {

            return Address(isBussinessOnly: self.businessOnly, postcode: self.postcode, town: self.town, street: self.line1, building: self.line2, apt: self.line3 ?? "", self.lat ?? 55.95204500604529, self.lng ??  -3.1981850325268777)
        }
        set { newValue
            _ =  CstAddress.init(id: newValue.hashValue, familyId: 0, line1: newValue.street, line2: newValue.building, town: newValue.town, postcode: newValue.postcode, lat: newValue.latitude, lng: newValue.latitude, vrfs: [], businessOnly: newValue.isBussinessOnly, line3: newValue.apt)
        }

    }
//    func getFrom(string: String) -> CstAddress {
//        var cstAddress = CstAddress(country: <#T##String#>, line1: <#T##String#>, line2: <#T##String#>, town: <#T##String#>, postcode: <#T##String#>)
//        var line3: String
//        string.compactMap { i in
//            if i.isNumber {
//                return Int(i)
//            } else if i.isPunctuation {
//                return Character(i)
//            } esle return nil
//        }
//        if string.first?.isNumber {
//            line3 =  string.prefix { char in
//                char.isNumber
//            }
//        } else {
//
//        }
//        string = string.trimmingCharacters(in: <#T##CharacterSet#>)
//        if string.replacingOccurrences(of: ", ", with: ",").replacingOccurrences(of: " ", with: "").components(separatedBy: ",").count
//    }
}







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
        self.total = "\(self.apt) \(self.building) \(self.street) \(self.town) \(self.postcode)".replacingOccurrences(of: "  ", with: "")
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


    var defaultAddress: CstAddress {
        set { newValue
            var defAddress = Address(isBussinessOnly: newValue.businessOnly, postcode: newValue.postcode, town: newValue.town, street: newValue.line1, building: newValue.line2, apt: newValue.line3 ?? "", newValue.lat ?? 55.95204500604529, newValue.lng ??  -3.1981850325268777)
        }
        get {
            return  CstAddress.init(id: self.hashValue, familyId: 0, line1: self.street, line2: self.building, town: self.town, postcode: self.postcode, lat: self.latitude, lng: self.latitude, vrfs: [], businessOnly: self.isBussinessOnly, line3: self.apt)
        }

    }
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


let CstAddresses: [CstAddress] = [
    CstAddress(line1: "Princes Street", line2: "09", town: "Edinburgh", postcode: "EH2 2ER"),
    CstAddress(line1: "Lupus St", line2: "3", town: "London", postcode: "EH2 2ER"),
    CstAddress(line1: "Merchant House, Cloth Market", line2: "30", town: "Newcastle upon Tyne", postcode: "EH2 2ER"),
    CstAddress(line1: "Fountain Street", line2: "53", town: "Manchester", postcode: "EH2 2ER"),
    CstAddress(line1: "West George Street", line2: "05", town: "Glasgow", postcode: "EH2 2ER"),
    CstAddress(line1: "George Street", line2: "54", town: "Edinburgh", postcode: "EH2 2ER"),
    CstAddress(line1: "St Mary's Pl", line2: "14", town: "Newcastle upon Tyne", postcode: "EH2 2ER"),
    CstAddress(line1: "St Martin-in-the-Fields Trafalgar Square", line2: "0", town: "London", postcode: "EH2 2ER")
]
