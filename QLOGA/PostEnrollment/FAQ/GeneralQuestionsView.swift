//
//  GeneralQuestionsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/7/22.
//

import SwiftUI

struct GeneralQuestionsView: View {
    @Binding var FAQItem: FAQItem
    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            Label {
                Text(FAQItem.title)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
//                Image(systemName: "chevron.right")
//                    .foregroundColor(Color.accentColor)
//                    .multilineTextAlignment(.leading)
//                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
//                    .padding(.leading, 10)
            } icon: {
                Image(FAQItem.icon)
                    .resizable().scaledToFit().aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
            }.padding(10).frame(minHeight: 50)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
                .padding(1)
            Group  {
                VStack {
                    ForEach($FAQItem.questions, id: \.self) { question in
                        VStack {
                            NavigationLink(destination: AnswerOnQuestionView(question: question)) {
                                Text(question.q.wrappedValue)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                    .lineLimit(2)
                                    .padding(.leading, 10)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.accentColor)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)

                            }.padding(7).frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                        }
                    }
                }
            }.padding(.top, 7).overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundColor(Color.lightGray)
            ).padding(1)
            Spacer()
        }.padding(.horizontal, 20).padding(.top, 10)
    }
}

//struct GeneralQuestionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GeneralQuestionsView(.constant(<#T##value: FAQItem##FAQItem#>))
//    }
//}
