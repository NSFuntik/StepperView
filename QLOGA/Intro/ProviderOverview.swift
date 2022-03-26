//
//  PrividerDetailView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
// import ImageViewer
struct ProviderOverview: View {
    // MARK: Lifecycle

    init(isButtonShows: Bool) {
        self.isButtonShows = isButtonShows
        UINavigationBar.appearance().prefersLargeTitles = true
    }

    // MARK: Internal

    let skills = ["Complete home cleaning",
                  "Bathroom and toilet cleaning",
                  "Kitchen cleaning",
                  "Bedroom or living room cleaning",
                  "Clothes laundry and ironing",
                  "Garrage cleaning",
                  "Swimming pool cleaning",
                  "Owen cleaning"]
    @State var image = Image(testProvider.avatar)
    @State var showImageViewer = false
    @State var isButtonShows: Bool

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack(alignment: .bottom, spacing: 10) {
                    VStack(alignment: .center, spacing: 5) {
                        Spacer()
                        Image(testProvider.avatar)
                            .resizable()
                            .aspectRatio(0.9, contentMode: .fit)
                            .frame(height: 110, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(Color.lightGray))
                            .padding(1)
                            .onTapGesture {
                                showImageViewer.toggle()
                            }
                        Text(testProvider.employment.rawValue)
                            .foregroundColor(Color.secondary)
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 15, weight: .regular, design: .rounded))

                    }.frame(height: 150, alignment: .top).offset(y: -4)
                    VStack(alignment: .leading, spacing: 11) {
                        Text(testProvider.name)
                            .font(.system(size: 250, weight: .regular, design: .rounded))
                            .minimumScaleFactor(0.01)
                            .frame(width: UIScreen.main.bounds.width * 0.6, height: 35, alignment: .leading)
                            .scaledToFit()
                            .lineLimit(1)
                            .foregroundColor(Color.black.opacity(0.8))
                            .multilineTextAlignment(.leading)
                        Text("Active")
                            .lineLimit(1)
                            .font(.system(size: 17, weight: .regular, design: .default))
                            .foregroundColor(.accentColor)
                            .frame(width: 80, height: 20)
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(Color.accentColor, lineWidth: 2)
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                    .background(RoundedRectangle(cornerRadius: 7).fill(Color.white)))
                            .padding(1)
                            .frame(width: 80, height: 20, alignment: .center).padding(.top, -7.5)
                            .disabled(!testProvider.isActive)

                        HStack(alignment: .center) {
                            Text("Callout charge:")
                                .foregroundColor(Color.lightGray)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                            Spacer()
                            Image(systemName: testProvider.calloutCharge ? "checkmark" : "minus")
                                .font(Font.system(size: 17, weight: .medium, design: .rounded))
                                .foregroundColor(.accentColor)
                        }
                        HStack(alignment: .center) {
                            Text("Cancellation:")
                                .foregroundColor(Color.lightGray)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                            Spacer()
                            Text(testProvider.cancellation.description)
                                .foregroundColor(Color.black.opacity(0.8))
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15,
                                                  weight: .medium,
                                                  design: .rounded))
                        }
                        HStack(alignment: .center) {
                            Text("Distance (miles):")
                                .foregroundColor(Color.lightGray)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                            Spacer()
                            Text(testProvider.distance.description)
                                .foregroundColor(Color.black.opacity(0.8))
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15,
                                                  weight: .medium,
                                                  design: .rounded))
                        }
                        Spacer()

                    }.frame(height: 150, alignment: .top)
                }.padding(.top, 10).padding(.horizontal, 10)
                //                Divider().padding(.horizontal, -20)
                ScrollView(showsIndicators: false) {
                    Label {
                        Text("Cleaning")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        Spacer()
                        Text("\(skills.count)")
                            .foregroundColor(Color.lightGray)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    } icon: {
                        Image("Cleaning")
                            .resizable().aspectRatio(contentMode: .fit)
                            .frame(height: 30, alignment: .center)
                    }.padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray)
                        ).frame(height: 50).padding(1)
                    ForEach(skills, id: \.self) { skill in
                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color.accentColor)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 7, weight: .regular, design: .rounded))
                            Text(skill)
                                .foregroundColor(Color.secondary)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                            Spacer()
                        }.padding(2)
                    }
                    Group {
                        VStack {
                            NavigationLink(destination: ProviderRatingView()) {
                                Label {
                                    Text("Rating")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("\(String(format: "%g", testProvider.rating))/5")
                                        .foregroundColor(Color.lightGray)
                                        .font(Font.system(size: 15, weight: .regular, design: .monospaced))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                } icon: {
                                    Image("RatingIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                }.padding(7)
                            }.padding(.bottom, -7).frame(height: 50)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            NavigationLink(destination: ProviderPortfolioView()) {
                                Label {
                                    Text("Portfolio")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(String(testProvider.portfolio.images.count))
                                        .foregroundColor(Color.lightGray)
                                        .font(Font.system(size: 15, weight: .regular, design: .monospaced))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                } icon: {
                                    Image("PortfolioIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .aspectRatio(1.3, contentMode: .fit)
                                        .padding(5)
                                }.padding(7)
                            }.frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            NavigationLink(destination: ProviderVerificationsView()) {
                                Label {
                                    Text("Verifications")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(getVerifications(verifications: testProvider.verifications))
                                        .lineLimit(2)
                                        .foregroundColor(Color.lightGray)
                                        .font(Font.system(size: 13, weight: .regular, design: .rounded))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                } icon: {
                                    Image("VerificationsIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                }.padding(7)
                            }.frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            NavigationLink(destination: ProviderPreviewsView(reviews: testProvider.reviews).tint(Color.accentColor)) {
                                Label {
                                    Text("Reviews")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("\(testProvider.reviews.count)")
                                        .foregroundColor(Color.lightGray)
                                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                        .padding(5)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                } icon: {
                                    Image("ReviewsIcon")
                                        .resizable()
                                        .scaledToFit().frame(width: 30, height: 30, alignment: .center)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                }
                            }.padding(7)
                                .padding(.top, -7).frame(height: 50)
                        }.overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray)
                        ).padding(1)
                    }.padding(.top, 10)
                    Spacer(minLength: 100)
                }
            }.padding(.horizontal, 20)

            if isButtonShows {
                VStack(alignment: .center) {
                    Spacer()
                    NavigationLink(destination: InquiryServicesView()) {
                        HStack {
                            Text("Direct Inquiry")
                                .withDoneButtonStyles(backColor: .accentColor, accentColor: .white)
                        }
                    }.padding(.bottom, 10)
                }
            }
        }.navigationBarTitleDisplayMode(.inline).navigationTitle("Provider")
    }
}

struct PrividerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderOverview(isButtonShows: true)
        }.previewDevice("iPhone 6s")
    }
}
