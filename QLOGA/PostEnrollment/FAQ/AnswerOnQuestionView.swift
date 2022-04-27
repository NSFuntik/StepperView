//
//  AnswerOnQuestionView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/7/22.
//

import SwiftUI

struct AnswerOnQuestionView: View {
    @Binding var question: Question
    @State var answer: AttributedString = AttributedString("")
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            HStack {
                Text(question.q)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
            } .padding(.leading, 10).padding(7).frame(minHeight: 50)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
                .padding(1)
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Text(answer)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    Spacer()
                }
                .padding(10)
            }
            Spacer()
        }.padding(.horizontal, 20).padding(.vertical, 10)
            .onAppear {
               answer = try! AttributedString(markdown: question.a,  options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
            }
    }
}
