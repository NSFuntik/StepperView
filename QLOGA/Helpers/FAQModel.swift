//
//  FAQfromJSON.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/7/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let fAQModel = try? newJSONDecoder().decode(FAQModel.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.fAQModelElementTask(with: url) { fAQModelElement, response, error in
//     if let fAQModelElement = fAQModelElement {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

enum FAQEnum: String, CaseIterable, Identifiable, Codable {
case general //= "General questions"
case p4p //= "General services questions"
case customer_quickstart// = "Customer Quickstart"
case customer //= "Customer F.A.Q."
case provider_quickstart //= "Provider Quickstart"
case provider //= //"Provider F.A.Q."

    var id: String { self.rawValue }
}

// MARK: - FAQModelElement
struct FAQItem: Codable, Hashable {
    var name: FAQEnum
    var icon: String
    var title: String
    var questions: [Question]


    enum CodingKeys: String, CodingKey {
        case name, icon, title
        case questions
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.questionTask(with: url) { question, response, error in
//     if let question = question {
//       ...
//     }
//   }
//   task.resume()
//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

// MARK: - Question
struct Question: Codable, Hashable {
    var q, a: String
    enum CodingKeys: String, CodingKey {
        case q, a
    }
}

typealias FAQModel = [FAQItem]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

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

    func fAQModelTask(with url: URL, completionHandler: @escaping (FAQModel?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

