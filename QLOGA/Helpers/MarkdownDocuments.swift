//
//  MarkdownDocs.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/26/22.
//
import SwiftUI
import Foundation


//public var TsCsMarkdown = NSAttributedString(data: Bundle.main.path(forResource: "qloga_ts_and_cs", ofType: "md")?.data(using: .utf8),
//                                             options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.utf8.rawValue], documentAttributes: nil)
enum MarkdownFile: String  {
    case QlogaTermsConditions = "qloga_ts_and_cs"
    case DataProtection = "qloga_data_protection"
    case Provider = "Provider"
    case Customer = ""
    
    var html: AttributedString? {
        switch self {
            case .QlogaTermsConditions:
                return try! String(contentsOfFile: Bundle.main.path(forResource: "qloga_ts_and_cs", ofType: "html")!, encoding: .utf8).htmlAttributedString()
            case .DataProtection:
                return try! String(contentsOfFile: Bundle.main.path(forResource: "qloga_ts_and_cs", ofType: "html")!, encoding: .utf8).htmlAttributedString()
            case .Provider:
                return try! String(contentsOfFile: Bundle.main.path(forResource: "qloga_ts_and_cs", ofType: "html")!, encoding: .utf8).htmlAttributedString()
            case .Customer:
                return try! String(contentsOfFile: Bundle.main.path(forResource: "qloga_ts_and_cs", ofType: "html")!, encoding: .utf8).htmlAttributedString()

        }
    }
}
extension String {

    func htmlAttributedString() -> AttributedString? {
        do {
            let html =  self
            guard let data = html.data(using: String.Encoding.utf8) else {  return nil }
            return try AttributedString(NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                                 .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil))
        } catch {
            return nil
        }
    }
}


//    var getAttributedFromHTML: NSAttributedString {
//        return try! NSAttributedString(
//            data: self.data(using: .utf8) ?? Data(),
//            options: [.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil
//        )
//    }


let cssPrefix =
"""
<style>* </style>
"""






//    do {
//        guard let path = Bundle.main.path(forResource: "qloga_ts_and_cs", ofType: "md"),
//              let data = try? String(contentsOfFile: path, encoding: .utf8),
////              let mark = try? AttributedString(markdown: data)//
//                let mark = try? Document(markdown: data, options: .smart)
//        else {
//            return try! Document(markdown: termsText)
//        }
//        return mark
//    }
//}
//
//public var ServiceMarkdown: Document {
//    do {
//        guard let path = Bundle.main.path(forResource: "qloga_data_protection", ofType: "md"),
//              let data = try? String(contentsOfFile: path, encoding: .utf8),
//              let mark = try? Document(markdown: data, options: .smart)
//
////              let mark = try? AttributedString(markdown: data)//(markdown: , options: .smart)
//        else {
//            return try! Document(markdown: termsText)
//        }
//        return mark
//    }
//}
