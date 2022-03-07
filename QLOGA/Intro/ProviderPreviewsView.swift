//
//  ProviderRatingView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProviderPreviewsView: View {
    var reviews: [Review]
    init(reviews: [Review]) {
        self.reviews = reviews
        UITableView.appearance().separatorColor = UIColor(named: "AccentColor")
        UITableView.appearance().tintColor = UIColor(named: "AccentColor")
    }
    var body: some View {
        List {
            ForEach(reviews, id: \.self) { review in
                HStack(alignment: .center, spacing: 10) {
                    Image(review.image ?? "Avatar")
                        .resizable()
                        .clipShape(Circle()).tint(Color("AccentColor"))
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: 85, alignment: .center)
                        .overlay(Circle().stroke(Color.accentColor, lineWidth: 1.5)
                        .shadow(color: .lightGray.opacity(0.5), radius: 3, y: 3))
                        .padding(5).padding(.leading,-13)
                        .foregroundColor(.accentColor)
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            StarsView(rating: review.rate).shadow(color: .lightGray.opacity(0.5), radius: 3, y: 3).tint(.accentColor).foregroundColor(.accentColor)
                            Text("(\(review.rate.formatted()))").foregroundColor(Color.secondary)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                        }.scaleEffect(1.2)

                        Text(review.description ?? "")
                            .foregroundColor(Color.secondary.opacity(0.8)).multilineTextAlignment(.leading).font(Font.system(size: 15, weight: .light, design: .rounded)).lineLimit(4).padding(.leading, -15)
                    }.padding()
//                    Text(review.rate.formatted())
                }                      //  Spacer()

            }
        }
        .foregroundColor(.accentColor)
        .listStyle(InsetListStyle())
        .navigationTitle("Previews: \(reviews.count)")
    }
}

struct ProviderPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProviderPreviewsView(reviews: [Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 3.9, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 4.6, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 1.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 3.7, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 2.2, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 4.1, description: "Prompt payment, polite and respectful")])
            ProviderPreviewsView(reviews: [Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 3.9, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 4.6, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 1.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 3.7, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 2.2, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 4.1, description: "Prompt payment, polite and respectful")])
        }
    }
}

struct Previews_ProviderPreviewsView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
