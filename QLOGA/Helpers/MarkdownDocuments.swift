//
//  MarkdownDocs.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/26/22.
//

import Foundation
import CommonMark
import MarkdownUI

public var TsCsMarkdown: Document {
    do {
        guard let path = Bundle.main.path(forResource: "qloga_ts_and_cs", ofType: "md"),
              let data = try? String(contentsOfFile: path, encoding: .utf8),
//              let mark = try? AttributedString(markdown: data)//
                let mark = try? Document(markdown: data, options: .smart)
        else {
            return try! Document(markdown: termsText)
        }
        return mark
    }
}

public var ServiceMarkdown: Document {
    do {
        guard let path = Bundle.main.path(forResource: "qloga_data_protection", ofType: "md"),
              let data = try? String(contentsOfFile: path, encoding: .utf8),
              let mark = try? Document(markdown: data, options: .smart)

//              let mark = try? AttributedString(markdown: data)//(markdown: , options: .smart)
        else {
            return try! Document(markdown: termsText)
        }
        return mark
    }
}
