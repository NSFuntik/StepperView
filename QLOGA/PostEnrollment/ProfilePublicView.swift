//
//  AccountSettingsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProfilePublicView: View {
    @State var actorType: ActorsEnum
    @Binding var customer: Customer
    @Binding var provider: Provider
    @State var image: Image = .init("ReviewAvatar")
    @State var showImageViewer = false


    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack(alignment: .bottom) {
                VStack(alignment: .center, spacing: 5) {
                    Spacer()
                    Image(actorType == .CUSTOMER ? $customer.avatar.wrappedValue : $provider.avatar.wrappedValue)
                        .resizable()
                        .aspectRatio(actorType == .CUSTOMER ? 1 : 0.9, contentMode: .fit)
                        .frame(height: 110, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: actorType == .CUSTOMER ? 130 : 10))
                        .overlay(RoundedRectangle(cornerRadius: actorType == .CUSTOMER ? 110 : 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray))
                        .padding(1)
                        .onTapGesture {
                            showImageViewer.toggle()
                        }
                    Text(actorType == .CUSTOMER ? $customer.wrappedValue.familyRole.rawValue : $provider.wrappedValue.employment.rawValue)
                        .foregroundColor(Color.secondary)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 15, weight: .regular, design: .rounded))

                }.frame(height: 150, alignment: .top).offset(y: -4)
                Spacer()
                VStack(alignment: .leading, spacing: 11) {
                    if actorType == .CUSTOMER {
                        Spacer()
                    }
                    HStack(alignment: .center) {
                        Text(actorType == .CUSTOMER ? $customer.wrappedValue.name  + " " +  $customer.wrappedValue.middleMame + " " +  $customer.wrappedValue.surname : $provider.wrappedValue.name)
                            .font(.system(size: 150, weight: .medium, design: .rounded))
                            .minimumScaleFactor(0.05)
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: 35, alignment: .leading)
                            .scaledToFit()
                            .lineLimit(1)
                            .foregroundColor(Color.black.opacity(0.8))
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Button {
                            $provider.isActive.wrappedValue.toggle()
                        } label: {
                            Image(systemName: provider.isActive ? "heart" : "heart.fill").foregroundColor(.red)
                                .font(.system(size: 17, weight: .regular, design: .default))

                        }
                    }
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
                        .disabled(!provider.isActive)
                    if actorType == .CUSTOMER {
                        HStack(alignment: .center) {
                            Text("Completed orders:")
                                .foregroundColor(Color.lightGray)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            Spacer()
                            Text($customer.reviews.wrappedValue.count.description)
                                .foregroundColor(Color.black.opacity(0.8))
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15,
                                                  weight: .medium,
                                                  design: .rounded))
                        }
                        Spacer(minLength: 30)

                    } else {
                        HStack(alignment: .center) {
                            Text("Callout charge:")
                                .foregroundColor(Color.lightGray)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                            Spacer()
                            Image(systemName: $provider.wrappedValue.calloutCharge ? "checkmark" : "minus")
                                .font(Font.system(size: 17, weight: .medium, design: .rounded))
                                .foregroundColor(.accentColor)
                        }
                        HStack(alignment: .center) {
                            Text("Cancellation:")
                                .foregroundColor(Color.lightGray)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                            Spacer()
                            Text($provider.wrappedValue.cancellation.description)
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
                            Text($provider.wrappedValue.distance.description)
                                .foregroundColor(Color.black.opacity(0.8))
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15,
                                                  weight: .medium,
                                                  design: .rounded))
                        }
                        Spacer()
                    }
                }.frame(height: 150, alignment: .top)
            }

            //			Divider().background(Color.lightGray).padding(.horizontal, -50)
            ScrollView(showsIndicators: false) {
                if actorType == .CUSTOMER {
                    customerRating
                } else {
                    providerRating
                }

                Group {
                    VStack {
                        if actorType != .CUSTOMER {
                            VStack {
                                NavigationLink(destination: ProviderRatingView()) {
                                    Label {
                                        Text("Rating")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text("\(String(format: "%g", $provider.wrappedValue.rating))/5")
                                            .foregroundColor(Color.secondary)
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
                                        Text(String($provider.wrappedValue.portfolio.images.count))
                                            .foregroundColor(Color.secondary)
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
                            }
                        }
                        NavigationLink(destination: ProviderVerificationsView()) {
                            Label {
                                Text("Verifications")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Spacer()
                                Text(getVerifications(verifications: $customer.verifications.wrappedValue))
                                    .lineLimit(2)
                                    .foregroundColor(Color.secondary)
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
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            }.padding(7)
                        }.padding(.top, actorType == .CUSTOMER ? 7 : 0).frame(height: actorType == .CUSTOMER ? 45 : 40)
                        Divider().background(Color.secondary).padding(.leading, 50)
                        NavigationLink(destination: ProviderPreviewsView(reviews: $customer.reviews.wrappedValue).tint(Color.accentColor)) {
                            Label {
                                Text("Reviews")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Spacer()
                                Text("\($provider.reviews.wrappedValue.count)")
                                    .foregroundColor(Color.secondary)
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
                                    .scaledToFit().frame(width: 25, height: 25, alignment: .center)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            }.padding(7)
                        }.frame(height: actorType == .CUSTOMER ? 45 : 40)
                        Divider().background(Color.secondary).padding(.leading, 50)
                        NavigationLink(destination: ProviderPreviewsView(reviews: $customer.reviews.wrappedValue).tint(Color.accentColor)) {
                            Label {
                                Text("Contacts")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Spacer()
                                Text("\($provider.wrappedValue.address.total)")
                                    .foregroundColor(Color.lightGray)
                                    .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                    .padding(5)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.accentColor)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                            } icon: {
                                Image("ContactInfoIcon")
                                    .resizable()
                                    .scaledToFit().frame(width: 25, height: 25, alignment: .center)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            }
                        }.padding(7).padding(.top, -7).frame(height: 45)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray)
                ).padding(1)
                Spacer()
            }.padding(.top, -7)
                .overlay(ImageViewer(image: $image,
                                     viewerShown: self.$showImageViewer))
                .onAppear {
                    $image.wrappedValue = Image($customer.avatar.wrappedValue)
                    if actorType == .PROVIDER {
                        typealias Provider = Customer
                    } else {
                        typealias Customer = Provider
                    }
                }
                .navigationBarTitle(actorType == .CUSTOMER ? "Customer" : "Provider")
                .navigationBarTitleDisplayMode(.inline)
        }.padding(.horizontal, 20).padding(.top, 10)
        //			.toolbar {
        //				Button {
        //					$provider.isActive.wrappedValue.toggle()
        //				} label: {
        //					Image(systemName: provider.isActive ? "heart" : "heart.fill").foregroundColor(.red)
        //				}
        //			}
    }

    var customerRating: some View {
        VStack(alignment: .center, spacing: 20) {
            Label {
                Text("Rating")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                Text("\(String(format: "%g", $customer.rating.wrappedValue))/5")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 15, weight: .medium, design: .monospaced))
            } icon: {
                Image("RatingIcon")
                    .resizable().scaledToFit().aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25, alignment: .center)
            }.padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
                .padding(1)

            HStack {
                Text("Comminications")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                StarsView(rating: 4.0)
            }.padding(.horizontal, 5)
            HStack {
                Text("Prompt payment")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                StarsView(rating: 3.0)
            }.padding(.horizontal, 5)
            HStack {
                Text("Sufficient enough chemicals and materials")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                StarsView(rating: 4.0)
            }.padding(.horizontal, 5)
            HStack {
                Text("Appriciative")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                StarsView(rating: 2.5)
            }.padding(.horizontal, 5)
        }.padding(.vertical, 20)
    }

    var providerRating: some View {
        VStack(alignment: .center, spacing: 0) {
            Label {
                Text("Cleaning")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                Text("\($provider.wrappedValue.services.count.description)")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
            } icon: {
                Image("Cleaning")
                    .resizable().scaledToFit().aspectRatio(contentMode: .fit)
                    .frame(height: 30, alignment: .center)
            }.padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray)
                ).frame(height: 50).padding(1)
            ScrollView {
                ForEach($provider.services, id: \.self) { service in
                    HStack(alignment: .center, spacing: 15) {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color.accentColor)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 7, weight: .regular, design: .rounded))
                        Text(service.name.wrappedValue ?? "")
                            .foregroundColor(Color.secondary)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .light, design: .rounded))
                        Spacer()
                    }.padding(2)
                }.padding(.top, 10)
                VStack {
                    Label {
                        Text("Rating")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        Spacer()
                        Text("\(String(format: "%g", $provider.rating.wrappedValue))/5")
                            .foregroundColor(Color.secondary)
                            .font(Font.system(size: 15, weight: .medium, design: .monospaced))
                    } icon: {
                        Image("RatingIcon")
                            .resizable().scaledToFit().aspectRatio( contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                    }.padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray))
                        .padding(1)

                    HStack {
                        Text("Comminications")
                            .foregroundColor(Color.secondary)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        Spacer()
                        StarsView(rating: 4.0)
                    }.padding(5)
                    HStack {
                        Text("Friendlyness")
                            .foregroundColor(Color.secondary)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        Spacer()
                        StarsView(rating: 4.0)
                    }.padding(5)
                    HStack {
                        Text("Timely arrival")
                            .foregroundColor(Color.secondary)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        Spacer()
                        StarsView(rating: 2.5)
                    }.padding(5)
                }.padding(.vertical, 10)
            }
        }.padding(.vertical, 20)
    }
}

struct ProfilePublicView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfilePublicView(actorType: .PROVIDER, customer: .constant(testCustomer), provider: .constant(testProvider))
        }.previewDevice("iPhone 6s")
    }
}

// {
// Label {
// Text("Rating")
// .foregroundColor(Color.black)
// .multilineTextAlignment(.leading)
// .font(Font.system(size: 17, weight: .regular, design: .rounded))
// Spacer()
// Text("\(String(format: "%g", $provider.rating.wrappedValue))/5")
// .foregroundColor(Color.secondary)
// .font(Font.system(size: 15, weight: .medium, design: .monospaced))
// } icon: {
// Image("RatingIcon")
// .resizable().scaledToFit().aspectRatio( contentMode: .fit)
// .frame(width: 25, height: 25, alignment: .center)
// }.padding(10)
// .overlay(RoundedRectangle(cornerRadius: 10)
// .stroke(lineWidth: 1.0)
// .foregroundColor(Color.lightGray))
// .padding(1)
//
// HStack {
// Text("Comminications")
// .foregroundColor(Color.secondary)
// .font(Font.system(size: 17, weight: .regular, design: .rounded))
// Spacer()
// StarsView(rating: 4.0)
// }.padding(.horizontal, 5)
// HStack {
// Text("Friendlyness")
// .foregroundColor(Color.secondary)
// .font(Font.system(size: 17, weight: .regular, design: .rounded))
// Spacer()
// StarsView(rating: 4.0)
// }.padding(.horizontal, 5)
// HStack {
// Text("Timely arrival")
// .foregroundColor(Color.secondary)
// .font(Font.system(size: 17, weight: .regular, design: .rounded))
// Spacer()
// StarsView(rating: 2.5)
// }.padding(.horizontal, 5)
// }
