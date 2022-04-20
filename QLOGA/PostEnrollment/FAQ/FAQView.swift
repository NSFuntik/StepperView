//
//  FAQView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/7/22.
//

import SwiftUI
//let fAQModel =

class FAQViewModel: ObservableObject {
    @Published var data: FAQModel = []
    init() {
        self.data = try! newJSONDecoder().decode(FAQModel.self, from: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "faq", ofType: "json")!)))
    }
}

struct FAQView: View {
    @Binding var provider: Provider
    @Binding var customer: Customer
    @State var actorType: ActorsEnum
    @ObservedObject var faqVM = FAQViewModel()

    var body: some View {
        VStack {
            Group  {
                VStack {
                    ForEach($faqVM.data, id: \.name) { (item) in
                        NavigationLink(destination: GeneralQuestionsView(FAQItem: item)) {
                            Label {
                                Text(item.title.wrappedValue)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.accentColor)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                            } icon: {
                                Image(item.icon.wrappedValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            }.padding(7)
                        }.frame(height: 40)
                        Divider().background(Color.secondary).padding(.leading, 50)
                    }
                }
            }.padding(.top, 7).overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundColor(Color.lightGray)
            ).padding(1)
            Spacer()
        }
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Frequently Asked Questions")
    }
}
