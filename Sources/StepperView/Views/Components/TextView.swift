//
//  TextView.swift
//  StepperView
//
//  Created by Venkatnarayansetty, Badarinath on 4/16/20.
//

import SwiftUI

/// A `View` for hostign text with proper `frame`  `alignment` , `lineLimit` modifiers
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
public struct TextView: View {
    /// placeholder for text
    public var text:String
    /// variable to hold font type
    public var font:Font
    public var color:Color
    public var subtitle: String
    public var date: String

    /// initilzes `text` and  `font`
    public init(text:String, font:Font = .caption, color: Color = .accentColor,  subtitle: String = "",  date: String = "") {
        self.text = text
        self.font = font
        self.color = color
        self.subtitle = subtitle
        self.date = date

    }

    /// provides the content and behavior of this view.
    public var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 5) {
                Spacer()
                HStack(alignment: .top) {
                    Text(text)
                        .font(font)
                        .foregroundColor(color)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, Utils.halfSpacing)
                    if date != "" {
                        Spacer()
                        Text(date)
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                            .frame(maxWidth: 120, alignment: .trailing)
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(1)
                            .padding(.leading, Utils.halfSpacing)
                            .ignoresSafeArea(.container, edges: .trailing)
                            .offset(y: 3)
                    }
                }.ignoresSafeArea(.container, edges: .trailing)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text(subtitle)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(Color("LightGray"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(1)
                    .padding(.leading, Utils.halfSpacing)
                Spacer()
            }
        }.frame(maxWidth: .infinity, maxHeight: 75)
    }
}
