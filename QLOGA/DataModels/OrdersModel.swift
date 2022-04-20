//
//  OrdersModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/17/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let orders = try? newJSONDecoder().decode(Orders.self, from: jsonData)

import Foundation

// MARK: - Orders
struct OrdersRoot: Codable {
    var content: [OrderContent]
    var pageable: OrderPageable
    var totalPages, totalElements: Int
    var last: Bool
    var size, number: Int
    var sort: OrderSort
    var numberOfElements: Int
    var first, empty: Bool
}

// MARK: - OrderContent
struct OrderContent: Codable {
//    static func == (lhs: OrderContent, rhs: OrderContent) -> Bool {
//        return lhs.id == rhs.id ? true : false
//    }

    var statusRecord: OrderStatusRecord
    var id: Int
    var addr: CstAddress
    var amount: Int
    var calloutAmount: Int?
    var callout: Bool
    var serviceDate: Date
    var services: [OrderService]
    var provider: OrderProvider
    var providerOrg: OrderProviderOrg
    var cancelHrs: Int?
    var cstPerson: OrderCstPerson
    var dayPlans: [OrderDayPlan]
    var cstActions, prvActions, payments, assigns: [JSONAny]
}

//// MARK: - OrderAddr
//struct OrderAddr: Codable {
//    var id, familyId: Int
//    var country, line1, line2, town: String
//    var postcode: String
//    var lat, lng: Double
//    var timeOffset: Int
//    var vrfs: [OrderVrf]
//    var businessOnly: Bool
//    var line3: String?
//}

// MARK: - OrderVrf
struct OrderVrf: Codable {
    var id: Int
    var type: String
    var subjId, holderId: Int
    var date: Date
    var notes: String
}

// MARK: - OrderCstPerson
struct OrderCstPerson: Codable {
    var verifications: [JSONAny]
    var settings: OrderSettings
    var payMethods: [JSONAny]
}

// MARK: - OrderSettings
struct OrderSettings: Codable {
}

// MARK: - OrderDayPlan
struct OrderDayPlan: Codable {
    var id: Int
    var day: String
    var visit1, visit2, visit3: OrderVisit
}

// MARK: - OrderVisit
struct OrderVisit: Codable {
    var time: String?
    var status: OrderStatusRecord?
    var tracks: [OrderStatusRecord]
    var prvActions, cstActions: [JSONAny]
}

// MARK: - OrderStatusRecord
struct OrderStatusRecord: Codable {
    var date: String
    var actor: ActorsEnum.RawValue
    var actorId: Int
    var action, note: String
    var status: StatusesEnum
    var display: String
    var actionDisplay, actionPast: String
}

// MARK: - OrderProvider
struct OrderProvider: Codable {
    var id: Int
    var calloutCharge: Bool
    var services, resourceIds, favs, ratings: [JSONAny]
    var portfolio: [JSONAny]
}

// MARK: - OrderProviderOrg
struct OrderProviderOrg: Codable {
    var name: String
    var offTime, workingHours, verifications: [JSONAny]
    var settings: OrderSettings
}

// MARK: - OrderService
struct OrderService: Codable {
    var id: Int
    var conditions: [Int]
    var qty, cost, timeNorm, qserviceId: Int
}

// MARK: - OrderPageable
struct OrderPageable: Codable {
    var sort: OrderSort
    var offset, pageSize, pageNumber: Int
    var paged, unpaged: Bool
}

// MARK: - OrderSort
struct OrderSort: Codable {
    var empty, unsorted, sorted: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}



//var PrvOrders: [OrderContent] = []
//[
//    OrderContent(statusRecord:
//                    OrderStatusRecord(date: "2022-03-04T01:08:35.500828Z", actor: "QLOGA", actorId: 1002, action: "CLOSE_DISPUTE_WINDOW", note: "After 7 days Order dispute opportunity window is now closed.", status: .VISIT_CALLOUT_2PAY, display: "Visit Callout Charge requested", actionDisplay: "Close dispute period", actionPast: "QLOGA closed dispute opportunity window for the order"),
//                 id: 1122,
//                 addr: CstAddress(id: 1004, familyId: 1000, country: "GB", line1: "30", line2: "Cloth Market", town: "Newcastle upon Tyne", postcode: "NE1 1EE", lat: 54.9783, lng: -1.612255, timeOffset: 3600000, vrfs: [], businessOnly: false, line3: "Merchant House"),
//                 amount: 35000, calloutAmount: nil, callout: false,
//                 serviceDate: getDate(from: "2022-06-22 10:00:00", "YYYY-MM-DD HH:mm:ss"),
//                 services: [
//                    OrderService(id: 1178, conditions: [10], qty: 2, cost: 15000, timeNorm: 60, qserviceId: 140),
//                    OrderService(id: 1179, conditions: [10], qty: 1, cost: 5000, timeNorm: 60, qserviceId: 130)
//                 ],
//                 provider:
//                    OrderProvider(id: 1002, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
//                 providerOrg:
//                    OrderProviderOrg(name: "Kai\'s Elderly care business (London)", offTime: [], workingHours: [], verifications: [],                                  settings: OrderSettings()),
//                 cancelHrs: nil, cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []), dayPlans: [], cstActions: [], prvActions: [], payments: [], assigns: []),
//    OrderContent(
//        statusRecord:
//            OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .ACCEPTED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//        id: 20218000753074,
//        addr:
//                    CstAddress(id: 1001, familyId: 1000, country: "GB", line1: "01", line2: "Princes Street", town: "Edinburgh", postcode: "EH2 2ER", lat: 55.953188, lng: -3.189556, timeOffset: 3600000, vrfs: [
//                        CstVrf(id: 10000, type: "ADDRESS", subjId: 1001, holderId: 1001, date: getDate(from: "2018-10-10 00:00:00", "YYYY-MM-DD HH:mm:ss") , notes: "Address verification for managing Kai\'s Org")], businessOnly: false, line3: nil), amount: 150000, calloutAmount: 1500, callout: true, serviceDate: getDate(from: "2022-03-27 09:00:00", "YYYY-MM-DD HH:mm:ss"),
//        services: [
//            OrderService(id: 1177, conditions: [10], qty: 1, cost: 150000, timeNorm: 60, qserviceId: 40)
//        ],
//        provider:
//            OrderProvider(id: 1001, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
//        providerOrg: OrderProviderOrg(name: "Kai\'s Cleaning agency (Edinburgh)", offTime: [], workingHours: [], verifications: [], settings: OrderSettings()),
//        cancelHrs: 4,
//        cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []),
//        dayPlans: [
//                    OrderDayPlan(id: 1033, day: "2022-03-27",
//                                 visit1:
//                                    OrderVisit(time: "09:00", status:
//                                                OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_APPROVED", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//                                               tracks: [
//                                                OrderStatusRecord(date: "2022-03-28T09:04:17.082419Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//                                                OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")
//                                               ], prvActions: [], cstActions: []),
//                                 visit2: OrderVisit(time: "11:00", status:
//                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"), tracks: [
//                                                            OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")], prvActions: [], cstActions: []),
//                                 visit3: OrderVisit(time: nil, status: nil, tracks: [], prvActions: [], cstActions: []))
//        ], cstActions: [], prvActions: [], payments: [], assigns: [])
//]

//var CstQuotes: [OrderContent] = []
//[
//    OrderContent(
//        statusRecord:
//            OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .QUOTE, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//        id: 20218000753074,
//        addr:
//            CstAddress(id: 1001, familyId: 1000, country: "GB", line1: "01", line2: "Princes Street", town: "Edinburgh", postcode: "EH2 2ER", lat: 55.953188, lng: -3.189556, timeOffset: 3600000, vrfs: [
//                CstVrf(id: 10000, type: "ADDRESS", subjId: 1001, holderId: 1001, date: getDate(from: "2018-10-10 00:00:00", "YYYY-MM-DD HH:mm:ss") , notes: "Address verification for managing Kai\'s Org")], businessOnly: false, line3: nil), amount: 150000, calloutAmount: 1500, callout: true, serviceDate: getDate(from: "2022-03-27 09:00:00", "YYYY-MM-DD HH:mm:ss"),
//        services: [
//            OrderService(id: 1177, conditions: [10], qty: 1, cost: 150000, timeNorm: 60, qserviceId: 40)
//        ],
//        provider:
//            OrderProvider(id: 1001, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
//        providerOrg: OrderProviderOrg(name: "Kai\'s Cleaning agency (Edinburgh)", offTime: [], workingHours: [], verifications: [], settings: OrderSettings()),
//        cancelHrs: 4,
//        cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []),
//        dayPlans: [], cstActions: [], prvActions: [], payments: [], assigns: []),
//    OrderContent(statusRecord:
//                    OrderStatusRecord(date: "2022-03-04T01:08:35.500828Z", actor: "QLOGA", actorId: 1002, action: "CLOSE_DISPUTE_WINDOW", note: "After 7 days Order dispute opportunity window is now closed.", status: .CST_DECLINED, display: "Visit Callout Charge requested", actionDisplay: "Close dispute period", actionPast: "QLOGA closed dispute opportunity window for the order"),
//                 id: 1122,
//                 addr: CstAddress(id: 1004, familyId: 1000, country: "GB", line1: "30", line2: "Cloth Market", town: "Newcastle upon Tyne", postcode: "NE1 1EE", lat: 54.9783, lng: -1.612255, timeOffset: 3600000, vrfs: [], businessOnly: false, line3: "Merchant House"),
//                 amount: 35000, calloutAmount: nil, callout: false,
//                 serviceDate: getDate(from: "2022-06-22 10:00:00", "YYYY-MM-DD HH:mm:ss"),
//                 services: [
//                    OrderService(id: 1178, conditions: [10], qty: 2, cost: 15000, timeNorm: 60, qserviceId: 140),
//                    OrderService(id: 1179, conditions: [10], qty: 1, cost: 5000, timeNorm: 60, qserviceId: 130)
//                 ],
//                 provider:
//                    OrderProvider(id: 1002, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
//                 providerOrg:
//                    OrderProviderOrg(name: "Kai\'s Elderly care business (London)", offTime: [], workingHours: [], verifications: [],                                  settings: OrderSettings()),
//                 cancelHrs: nil, cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []), dayPlans: [
//                    OrderDayPlan(id: 1033, day: "2022-03-27",
//                                 visit1:
//                                    OrderVisit(time: "09:00", status:
//                                                OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_APPROVED", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//                                               tracks: [
//                                                OrderStatusRecord(date: "2022-03-28T09:04:17.082419Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//                                                OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")
//                                               ], prvActions: [], cstActions: []),
//                                 visit2: OrderVisit(time: "11:00", status:
//                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"), tracks: [
//                                                            OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")], prvActions: [], cstActions: []),
//                                 visit3: OrderVisit(time: nil, status: nil, tracks: [], prvActions: [], cstActions: []))
//                 ], cstActions: [], prvActions: [], payments: [], assigns: [])
//]

//var PrvInquires: [OrderContent] = []
//[
//    OrderContent(
//        statusRecord:
//            OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .INQUIRY, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//        id: 20218000753074,
//        addr:
//            CstAddress(id: 1001, familyId: 1000, country: "GB", line1: "01", line2: "Princes Street", town: "Edinburgh", postcode: "EH2 2ER", lat: 55.953188, lng: -3.189556, timeOffset: 3600000, vrfs: [
//                CstVrf(id: 10000, type: "ADDRESS", subjId: 1001, holderId: 1001, date: getDate(from: "2018-10-10 00:00:00", "YYYY-MM-DD HH:mm:ss") , notes: "Address verification for managing Kai\'s Org")], businessOnly: false, line3: nil), amount: 150000, calloutAmount: 1500, callout: true, serviceDate: getDate(from: "2022-03-27 09:00:00", "YYYY-MM-DD HH:mm:ss"),
//        services: [
//            OrderService(id: 1177, conditions: [10], qty: 1, cost: 150000, timeNorm: 60, qserviceId: 40)
//        ],
//        provider:
//            OrderProvider(id: 1001, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
//        providerOrg: OrderProviderOrg(name: "Kai\'s Cleaning agency (Edinburgh)", offTime: [], workingHours: [], verifications: [], settings: OrderSettings()),
//        cancelHrs: 4,
//        cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []),
//        dayPlans: [], cstActions: [], prvActions: [], payments: [], assigns: []),
//    OrderContent(statusRecord:
//                    OrderStatusRecord(date: "2022-03-04T01:08:35.500828Z", actor: "QLOGA", actorId: 1002, action: "CLOSE_DISPUTE_WINDOW", note: "After 7 days Order dispute opportunity window is now closed.", status: .CST_DECLINED, display: "Visit Callout Charge requested", actionDisplay: "Close dispute period", actionPast: "QLOGA closed dispute opportunity window for the order"),
//                 id: 1122,
//                 addr: CstAddress(id: 1004, familyId: 1000, country: "GB", line1: "30", line2: "Cloth Market", town: "Newcastle upon Tyne", postcode: "NE1 1EE", lat: 54.9783, lng: -1.612255, timeOffset: 3600000, vrfs: [], businessOnly: false, line3: "Merchant House"),
//                 amount: 35000, calloutAmount: nil, callout: false,
//                 serviceDate: getDate(from: "2022-06-22 10:00:00", "YYYY-MM-DD HH:mm:ss"),
//                 services: [
//                    OrderService(id: 1178, conditions: [10], qty: 2, cost: 15000, timeNorm: 60, qserviceId: 140),
//                    OrderService(id: 1179, conditions: [10], qty: 1, cost: 5000, timeNorm: 60, qserviceId: 130)
//                 ],
//                 provider:
//                    OrderProvider(id: 1002, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
//                 providerOrg:
//                    OrderProviderOrg(name: "Kai\'s Elderly care business (London)", offTime: [], workingHours: [], verifications: [],                                  settings: OrderSettings()),
//                 cancelHrs: nil, cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []), dayPlans: [
//                    OrderDayPlan(id: 1033, day: "2022-03-27",
//                                 visit1:
//                                    OrderVisit(time: "09:00", status:
//                                                OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_APPROVED", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//                                               tracks: [
//                                                OrderStatusRecord(date: "2022-03-28T09:04:17.082419Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
//                                                OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")
//                                               ], prvActions: [], cstActions: []),
//                                 visit2: OrderVisit(time: "11:00", status:
//                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"), tracks: [
//                                                            OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")], prvActions: [], cstActions: []),
//                                 visit3: OrderVisit(time: nil, status: nil, tracks: [], prvActions: [], cstActions: []))
//                 ], cstActions: [], prvActions: [], payments: [], assigns: [])
//]
