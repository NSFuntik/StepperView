//
//  RequestModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/10/22.
//

import Foundation



//   let CstRequest = try? newJSONDecoder().decode(CstRequest.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.CstRequestTask(with: url) { CstRequest, response, error in
//     if let CstRequest = CstRequest {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - CstRequest
struct CstRequestMeta: Codable, Hashable {
    var requests: [CstRequest]
    var pageable: CstPageable
    var totalPages: Int
    var totalElements: Int
    var last: Bool
    var size: Int
    var number: Int
    var sort: CstSort
    var numberOfElements: Int
    var first: Bool
    var empty: Bool

    enum CodingKeys: String, CodingKey {
        case requests = "content"
        case pageable = "pageable"
        case totalPages = "totalPages"
        case totalElements = "totalElements"
        case last = "last"
        case size = "size"
        case number = "number"
        case sort = "sort"
        case numberOfElements = "numberOfElements"
        case first = "first"
        case empty = "empty"
    }
}

typealias CstRequests = [CstRequest]

//
// To read values from URLs:
//
//   let task = URLSession.shared.CstContentTask(with: url) { CstContent, response, error in
//     if let CstContent = CstContent {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CstContent
struct CstRequest: Codable, Hashable {
    var statusRecord: CstStatusRecord
    var id: Int
    var offeredSum: Int
    var placedDate: Date
    var orderedDate: Date
    var validDate: Date
    var visits: Int
    var address: CstAddress
    var services: [CstService]
    var cstActions: [CstCstAction]
    var notes: String
    enum CodingKeys: String, CodingKey {
        case statusRecord = "statusRecord"
        case id = "id"
        case offeredSum = "offeredSum"
        case placedDate = "placedDate"
        case orderedDate = "orderedDate"
        case validDate = "validDate"
        case visits = "visits"
        case address = "address"
        case services = "services"
        case cstActions = "cstActions"
        case notes = "notes"
    }



}

//
// To read values from URLs:
//
//   let task = URLSession.shared.CstAddressTask(with: url) { CstAddress, response, error in
//     if let CstAddress = CstAddress {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CstAddress

// MARK: - CstVrf
struct CstVrf: Codable, Hashable {
    var id: Int
    var type: String
    var subjId: Int
    var holderId: Int
    var date: Date
    var notes: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case subjId = "subjId"
        case holderId = "holderId"
        case date = "date"
        case notes = "notes"
    }
}

enum CstCstAction: String, Codable, Hashable {
    case cancel = "CANCEL"
    case stop = "STOP"
    case update = "UPDATE"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.CstServiceTask(with: url) { CstService, response, error in
//     if let CstService = CstService {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CstService
struct CstService: Codable, Hashable {
    var id: Int?
    var quantity: Int?
    var qserviceId: Int
    var name, descr, unit, unitDescr: String?
    var subject, works, exclusions: String?
    var timeNorm, avatarID: Int?
    var avatarURL: String?
    var isEditable: Bool = false

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case quantity = "qty"
        case qserviceId = "qserviceId"
    }

    var toCategoryService: CategoryService {
        var CategoryService =  CategoryService(id: self.qserviceId,  sortOrder: self.id!, name: self.name, descr: self.descr, unit: self.unit, unitDescr: self.unitDescr, subject: self.subject, works: self.works, exclusions: self.exclusions, timeNorm: self.timeNorm, avatarID: self.avatarID, avatarURL: self.avatarURL)
        CategoryService.unitsCount = self.quantity ?? 0
        return CategoryService
    }
}



//
// To read values from URLs:
//
//   let task = URLSession.shared.CstStatusRecordTask(with: url) { CstStatusRecord, response, error in
//     if let CstStatusRecord = CstStatusRecord {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CstStatusRecord
struct CstStatusRecord: Codable, Hashable {
    var date: String
    var actor: String
    var actorId: Int
    var action: String
    var status: String
    var display: String

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case actor = "actor"
        case actorId = "actorId"
        case action = "action"
        case status = "status"
        case display = "display"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.CstPageableTask(with: url) { CstPageable, response, error in
//     if let CstPageable = CstPageable {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CstPageable
struct CstPageable: Codable, Hashable {
    var sort: CstSort
    var offset: Int
    var pageSize: Int
    var pageNumber: Int
    var paged: Bool
    var unpaged: Bool

    enum CodingKeys: String, CodingKey {
        case sort = "sort"
        case offset = "offset"
        case pageSize = "pageSize"
        case pageNumber = "pageNumber"
        case paged = "paged"
        case unpaged = "unpaged"
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.CstSortTask(with: url) { CstSort, response, error in
//     if let CstSort = CstSort {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - CstSort
struct CstSort: Codable, Hashable {
    var empty: Bool
    var unsorted: Bool
    var sorted: Bool

    enum CodingKeys: String, CodingKey {
        case empty = "empty"
        case unsorted = "unsorted"
        case sorted = "sorted"
    }
}
