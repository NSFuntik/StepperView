//
//  MarkdownDocs.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/26/22.
//

import Foundation
import MarkdownUI

public var TsCsMarkdown: Document {
    do {
        guard let path = Bundle.main.path(forResource: "qloga_ts_and_cs", ofType: "md"),
              let data = try? String(contentsOfFile: path, encoding: .utf8),
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
        else {
            return try! Document(markdown: termsText)
        }
        return mark
    }
}
