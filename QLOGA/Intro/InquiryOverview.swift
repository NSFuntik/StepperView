//
//  InquiryOverview.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct InquiryOverview: View {
    @State var address = "5 Miles Street, London, GB"

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20)  {
                    VStack {
                        Group  {
                            NavigationLink(destination: SelectedServiceDetailView(serviceType: .Kitchen)) {
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("Windows cleaning")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Text("Rate (£ / hour): 21.00")
                                            .foregroundColor(Color.lightGray)
                                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                    }
                                    Spacer()

                                    Text("4")
                                        .foregroundColor(Color.lightGray)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.Green)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.trailing, 10)
                                }
                            }.padding(.top, 10)
                            Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -10)

                            NavigationLink(destination: SelectedServiceDetailView(serviceType: .Kitchen)) {
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("Kitchen cleaning")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Text("Rate (£ / hour): 21.00")
                                            .foregroundColor(Color.lightGray)
                                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                    }
                                    Spacer()

                                    Text("1")
                                        .foregroundColor(Color.lightGray)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.Green)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.trailing, 10)
                                }
                            }
                            Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -10)

                            NavigationLink(destination: SelectedServiceDetailView(serviceType: .Kitchen)) {
                                HStack(alignment: .center) {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("Bedroom or living room cleaning")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Text("Rate (£ / hour): 21.00")
                                            .foregroundColor(Color.lightGray)
                                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                    }
                                    Spacer()

                                    Text("1")
                                        .foregroundColor(Color.lightGray)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.Green)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.trailing, 10)
                                }
                            }.padding(.bottom, 10)
                        }
                    }.padding(.horizontal, 10)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray))

                    VStack(alignment: .center) {
                        NavigationLink(destination: InquiryServicesView()) {
                            HStack{
                                Text("Add services")
                                    .lineLimit(1)
                                    .ignoresSafeArea(.all)
                                    .font(.system(size: 20, weight: .regular, design: .default))
                                    .foregroundColor(.Green)
                                    .frame(width: UIScreen.main.bounds.width - 42, height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.Green, lineWidth: 4)
                                            .clipShape(RoundedRectangle(cornerRadius: 25))
                                            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white)))
                            }
                        }.padding(.bottom, 5)

                        VStack(alignment: .center, spacing: 20) {
                            HStack(alignment: .center) {
                                Text("Total sum:")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 19, weight: .regular, design: .default))
                                Spacer()
                                Text("£84.00")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 19, weight: .bold, design: .default))
                            }
                            HStack(alignment: .center) {
                                Text("Cancellation period:")
                                    .foregroundColor(Color.lightGray)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .default))
                                Spacer()
                                Text("0 hours")
                                    .foregroundColor(Color.lightGray)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .default))
                            }
                            HStack(alignment: .center) {
                                Text("Callout charge:")
                                    .foregroundColor(Color.lightGray)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .default))
                                Spacer()
                                Text("£84.00")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .bold, design: .default))
                            }
                        }
                        VStack {
                            Group  {
                                NavigationLink(destination: AddressSearchView(address: $address)) {
                                    HStack(alignment: .center) {
                                        Text("Address")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text(address)
                                            .foregroundColor(Color.lightGray)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.Green)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                            .padding(.trailing, 10)
                                    }
                                }.padding(.top, 15)
                                Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -15)

                                NavigationLink(destination: CalendarPickerView().navigationBarTitle("Date & Time").ignoresSafeArea(.all, edges: .bottom)) {
                                    HStack(alignment: .center) {
                                        Text("Date & Time")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text("22/06/2022 22:00")
                                            .foregroundColor(Color.lightGray)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.Green)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                            .padding(.trailing, 10)
                                    }
                                }
                                Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -15)

                                NavigationLink(destination: VisitsScedulerView()) {
                                    HStack(alignment: .center) {
                                        Text("Visits")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text("8")
                                            .foregroundColor(Color.lightGray)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.Green)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                            .padding(.trailing, 10)
                                    }
                                }
                                Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -15)

                                NavigationLink(destination: SelectedServiceDetailView(serviceType: .Kitchen)) {
                                    HStack(alignment: .center) {
                                        Text("Tracking")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text("")
                                            .foregroundColor(Color.lightGray)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.Green)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                            .padding(.trailing, 10)
                                    }
                                }
                                Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -15)

                                NavigationLink(destination: ProviderOverview(isButtonShows: false)) {
                                    HStack(alignment: .center) {
                                        Text("Provider details")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text("1")
                                            .foregroundColor(Color.lightGray)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.Green)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                            .padding(.trailing, 10)
                                    }
                                }.padding(.bottom, 15)
                            }.padding(5)
                        }.padding(.horizontal, 10)
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(Color.lightGray))
                    }
                }.padding(.horizontal, 20)
                Spacer(minLength: 100)
            }

            VStack(alignment: .center) {
                Spacer()
                NavigationLink(destination: EnrollmentInfoView(actorType: .CUSTOMER)) {
                    HStack{
                        Text("Send a Direct Inquiry")
                            .lineLimit(1)
                            .ignoresSafeArea(.all)
                            .shadow(color: Color.secondary, radius: 1, x: 1, y: 1)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 42, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 25).fill(Color.accentColor))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: Color.lightGray, radius: 4, x: -4.5, y: -4.5)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay(RoundedRectangle(cornerRadius: 25)
                                .stroke(lineWidth: 2.0)
                                .foregroundColor(Color.white)
                                .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3))
                    }
                }.padding(.bottom, 5)
            }
        }.navigationTitle("Inquiry (incomplete)").navigationBarTitleDisplayMode(.inline)
    }
}

struct InquiryOverview_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InquiryOverview()
        }.previewDevice("iPhone 6s")
    }
}

