//
//  PrividerDetailView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
//import ImageViewer
struct ProviderOverview: View {
    @State var image = Image(testProvider.avatar!)
    @State var  showImageViewer = false
    let skills = ["Complete home cleaning","Bathroom and toilet cleaning","Kitchen cleaning","Bedroom or living room cleaning","Clothes laundry and ironing","Garrage cleaning","Swimming pool cleaning","Owen cleaning"]
    init() {
//        UINavigationBar.appearance().backgroundColor = UIColor(named: "AccentColor")
    }
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .center, spacing: 5) {
                        Image(testProvider.avatar!).resizable().aspectRatio(0.9, contentMode: .fit).frame(height: 100, alignment: .center).overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray))
                        .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3)
                        .onTapGesture {
                            showImageViewer.toggle()
                        }
                        Text(testProvider.employment.rawValue)
                            .foregroundColor(Color.lightGray)
                            .multilineTextAlignment(.center)
                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                    }.padding(10)
                    VStack(alignment: .leading, spacing: 10) {
                        Text(testProvider.greetings ?? "")
                            .foregroundColor(Color.black.opacity(0.8))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17,
                                              weight: .medium,
                                              design: .rounded))
                        HStack(alignment: .center) {
                            Text("Callout charge:")
                                .foregroundColor(Color.lightGray)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                            Spacer()
                            Image(systemName: testProvider.calloutCharge ? "checkmark" : "minus").font(Font.system(size: 17, weight: .medium,
                                                                                                                   design: .rounded)).foregroundColor(.accentColor)
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
                                                  design: .rounded))    }
                        HStack(alignment: .center) {
                            Text("Distance (miles):")
                                .foregroundColor(Color.lightGray)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                            Spacer()
                            Text(String(describing: testProvider.distance!))
                                .foregroundColor(Color.black.opacity(0.8))
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15,
                                                  weight: .medium,
                                                  design: .rounded))
                        }
                    }.padding(10)

                }.padding(-20).padding(.horizontal, 10).fixedSize(horizontal: false, vertical: true).padding()
                Divider()
                ScrollView {
                    Label {
                        Text("Cleaning")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        Spacer()
                        Image(systemName: "\(skills.count).circle")
                            .foregroundColor(Color.accentColor)
                            .font(Font.system(size: 25, weight: .regular, design: .rounded)).padding(5)
                    } icon: {
                        Image("Cleaning")
                            .resizable().aspectRatio( contentMode: .fit).frame(height: 30, alignment: .center)
                            .padding(5)
                    }.padding(10)

                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray)
                            .shadow(color: .secondary.opacity(0.5), radius: 3)).padding()
                    ForEach(skills, id: \.self) { skill in
                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color.accentColor)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 7, weight: .regular, design: .rounded))
                            Text(skill).foregroundColor(Color.secondary)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                            Spacer()
                        }.padding(2)
                    }.padding(.horizontal)

                    Group {
                        VStack {
                            NavigationLink(destination: ProviderRatingView()) {

                                Label {
                                    Text("Rating") .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("\(String(format: "%g", testProvider.rating))/5")
                                        .foregroundColor(Color.accentColor)
                                        .font(Font.system(size: 15, weight: .regular, design: .monospaced)).padding(5)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded)).padding(.leading, 10)
                                } icon: {
                                    Image("RatingIcon")
                                        .resizable().aspectRatio( contentMode: .fit).frame(height: 30, alignment: .center)
                                        .padding(5)
                                }
                            }.padding(7)
                            Divider().background(Color.black).padding(.leading, 50).padding(.vertical, -5)
                            NavigationLink(destination: ProviderPortfolioView()) {

                                Label {
                                    Text("Portfolio") .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(String(testProvider.portfolio?.images?.count ?? 0))
                                        .foregroundColor(Color.accentColor)
                                        .font(Font.system(size: 15, weight: .regular, design: .monospaced)).padding(5)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded)).padding(.leading, 10)
                                } icon: {
                                    Image("PortfolioIcon")
                                        .resizable().aspectRatio( contentMode: .fit).frame(height: 30, alignment: .center)
                                        .padding(5)
                                }.padding(7)
                            }
                            Divider().background(Color.black).padding(.leading, 50).padding(.vertical, -5)
                            NavigationLink(destination: ProviderVerificationsView()) {

                                Label {
                                    Text("Verifications") .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(getVerifications(verifications: testProvider.verifications ?? []))
                                        .foregroundColor(Color.accentColor)
                                        .font(Font.system(size: 13, weight: .regular, design: .rounded)).padding(5).padding(.top,-10)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded)).padding(.leading, 10)
                                } icon: {
                                    Image("VerificationsIcon")
                                        .resizable().aspectRatio( contentMode: .fit).frame(height: 30, alignment: .center)
                                        .padding(5)
                                }.padding(7)
                            }
                            Divider().background(Color.black).padding(.leading, 50).padding(.vertical, -5)
                            NavigationLink(destination: ProviderPreviewsView(reviews: testProvider.reviews ?? []).tint(Color.accentColor)) {
                                Label {
                                    Text("Reviews") .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("\(testProvider.reviews?.count ?? 0)")
                                        .foregroundColor(Color.accentColor)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded)).padding(5)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded)).padding(.leading, 10)
                                } icon: {
                                    Image("ReviewsIcon")
                                        .resizable().aspectRatio( contentMode: .fit).frame(height: 30, alignment: .center)
                                        .padding(5)
                                }
                            }.padding(7).padding(.bottom, 10)

                        }.overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray)
                            .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3)).padding()
                    }
                    Spacer(minLength: 100)
                }.padding(.top, -20).padding()
            }

            
            VStack(alignment: .center) {
                Spacer()
                NavigationLink(destination: InquiryServicesView()) {
                    HStack {
                        Text("Direct Inquiry")

                        .font(.system(size: 20, weight: .regular, design: .rounded)).foregroundColor(.white).padding(.horizontal, 100).frame(height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.accentColor, lineWidth: 4)
                                .shadow(color: Color.secondary, radius: 4, x: 4.5, y: 4.5)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: Color.lightGray, radius: 4, x: -4.5, y: -4.5)
                                .clipShape(RoundedRectangle(cornerRadius: 20))

                        .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 2.0)
                            .foregroundColor(Color.white)
                            .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3))
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.accentColor)))

                    }
                }//.padding(-20)


            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer))
        }.navigationTitle("\(testProvider.name)")


    }
}
func getVerifications(verifications: [VerificationTypes]) -> String {
    var verifics = "\0"
    print(testProvider.verifications)
    for verification in verifications {
        if verification == .ProfessionalInsurance {
            verifics = verifics +  "• Professional\n   Insurance\n"
            //                break
        } else if verification == .RegistrationCertificate {
            verifics = verifics +  "• Registration\n   Certificate\n"
            //                break
        } else  if verification != verifications.last {
            verifics = verifics +  "• " + verification.rawValue + "\n"
        } else {
            verifics = verifics + "• " + verification.rawValue + "\n"
        }
    }

    //        enum VerificationTypes: String, CaseIterable, Identifiable, Hashable {
    //            case IDs
    //            case Address
    //            case Avatar
    //            case RegistrationCertificate
    //            case ProfessionalInsurance
    //            case Email
    //            case Phone
    //            case Passport
    //            var id: String { self.rawValue }
    //
    //        }

    return verifics
}


struct PrividerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderOverview()
        }
    }
}
