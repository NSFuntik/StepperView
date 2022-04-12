//
//  ProviderRatingView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProviderPreviewsView: View {

    init(reviews: [Review]) {
        self.reviews = reviews
        UITableView.appearance().separatorColor = UIColor.clear
        UITableView.appearance().tintColor = UIColor.clear
        UITableView.appearance().sectionIndexColor = UIColor.clear

    }
    var reviews: [Review]

    var body: some View {
        List {
            ForEach(reviews, id: \.self) { review in
                HStack(alignment: .center, spacing: 15) {
                    Image(review.image)
                        .resizable()
                        .clipShape(Circle())
                        .tint(Color("AccentColor"))
                        .aspectRatio(1, contentMode: .fit)
                        .frame(height: 85, alignment: .center)
                        .foregroundColor(.accentColor)

                    VStack(alignment: .leading, spacing: 10) {
                        Spacer()
                        HStack(alignment: .top, spacing: 0) {
                            StarsView(rating: review.rate)
                                .tint(.accentColor)
                                .foregroundColor(.accentColor)
                                .frame(width: 120)
                            Spacer()
                            Text("(\(review.rate.formatted()))")
                                .foregroundColor(Color.secondary)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .light, design: .rounded))
                        }
                        Spacer()
                        Text(review.description)
                            .foregroundColor(Color.secondary.opacity(0.8))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 15, weight: .light, design: .rounded))

                            .lineLimit(4)
                            .padding(.leading, -15)
                        Spacer()
                    }.padding(.horizontal)
                }.padding(.vertical, -20)
                Divider().foregroundColor(.lightGray.opacity(0.5)).padding(.horizontal, 40)
            }
        }.padding(.top, 10)
            .foregroundColor(.accentColor)
//            .listStyle(InsetListStyle())
            .navigationTitle("Previews: \(reviews.count)")
    }
}

struct ProviderPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Group {
                ProviderPreviewsView(reviews: [
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 3.9, description: "Prompt payment, polite and respectful"),
                    Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "Avatar", rate: 4.6, description: "Prompt payment, polite and respectful"),
                    Review(image: "Avatar", rate: 1.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 3.7, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 2.2, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "Avatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                ])
                ProviderPreviewsView(reviews: [
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 3.9, description: "Prompt payment, polite and respectful"),
                    Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "Avatar", rate: 4.6, description: "Prompt payment, polite and respectful"),
                    Review(image: "Avatar", rate: 1.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 3.7, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 2.2, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                    Review(image: "Avatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                ])
            }
        }
    }
}
