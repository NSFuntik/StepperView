//
//  CategoriesModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/9/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categories = try? newJSONDecoder().decode(Categories.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.categoryTask(with: url) { category, response, error in
//     if let category = category {
//       ...
//     }
//   }
//   task.resume()

import Foundation
import SwiftUI

enum ServiceType: Int, CaseIterable, Identifiable  {
    case Gas = 0
    case Cleaning = 1
    case Pets = 2
    case Plumbing = 3
    case Handyman = 4
    case Education = 5
    case Computing = 6
    case Gardening = 7
    case Hair = 8
    case Care = 9
    case Joinery = 10
    case Electrical = 11
    case Locksmith = 12
    case Nails = 13

    var title: String {
        switch self {
            case .Cleaning:
                return "Cleaning"
            case .Pets:
                return "Pets"
            case .Gas:
                return  "Gas"
            case .Education:
                return  "Education"
            case .Computing:
                return  "Computing"
            case .Gardening:
                return  "Gardening"
            case .Care:
                return "Care"
            case .Handyman:
                return  "Handyman"
            case .Plumbing:
                return  "Plumbing"
            case .Electrical:
                return  "Electrical"
            case .Hair:
                return  "Hair"
            case .Nails:
                return "Nails"
            case .Locksmith:
                return  "Locksmith"
            case .Joinery:
                return  "Joinery"
        }
    }
    //    private static var idSequence = sequence(first: 0, next: {$0 + 1})

    var id: Int { self.rawValue }

}

// MARK: - Category
struct Category: Codable, Hashable, Identifiable {
    var id: ServiceType.ID
    var sortOrder: Int?
    var name, descr: String?
    var avatarURL, mapURL: String?
    var services: [CategoryService]
    var totalPrice: NSNumber? = NSNumber.init(value: 30.0)
    typealias ID = ServiceType.ID
    enum CodingKeys: String, CodingKey {
        case id, sortOrder, name, descr
        case avatarURL
        case mapURL
        case services
    }
}

// MARK: - Service
struct CategoryService: Codable, Hashable, Identifiable {
    internal init(id: Int? = 0, sortOrder: Int? = nil, name: String? = "nil", descr: String? = "nil", unit: String? = "nil", unitDescr: String? = "nil", subject: String? = "nil", works: String? = "nil", exclusions: String? = "nil", timeNorm: Int? = 0, avatarID: Int? = 0, avatarURL: String? = "nil") {
        self.id = 0
        self.sortOrder = sortOrder ??  self.id
//        self.unitsCount = unitsCount
        self.name = name
        self.descr = descr
        self.unit = unit
        self.unitDescr = unitDescr
        self.subject = subject
        self.works = works
        self.exclusions = exclusions
        self.timeNorm = timeNorm
        self.avatarID = avatarID
        self.avatarURL = avatarURL
    }
    typealias ID = Int
    
    var id: Int
    var sortOrder: Int
    var unitsCount: Int = 0
    var name, descr, unit, unitDescr: String?
    var subject, works, exclusions: String?
    var timeNorm, avatarID: Int?
    var avatarURL: String?
    var isEditable: Bool = false
    var price: Double = 30.0

    enum CodingKeys: String, CodingKey {
        case id, sortOrder, name, descr, unit, unitDescr, subject, works, exclusions, timeNorm
        case avatarID
        case avatarURL
    }



}

extension Int {
    var double: Double {
        return  Double.init(self)
//         self.Double(Self)
    }
}

typealias Categories = [Category]

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func categoriesTask(with url: URL, completionHandler: @escaping (Categories?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
