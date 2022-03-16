//
//  SuccessEnrollmenrModalView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct EnrolledProfileView: View {
    @ObservedObject var locationManager = LocationManager()
    @State var actorType: ActorsEnum
    @State var isFiltersPresented = false
    @State private var selectedTab = 0
    @State var isNotShowAgain = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    TabBarView(tabs: .constant(["Orders", "Quotes", "Inquires", actorType != .CUSTOMER ? "Requests" : "Today"]),
                               selection: $selectedTab,
                               underlineColor: .accentColor) { title, isSelected in
                        Text(title)
                            .font(.system(size: 19, weight: .regular, design: .rounded))
                            .ignoresSafeArea(.all, edges: .horizontal)
                            .foregroundColor(isSelected ? .black : .lightGray)
                    }
                    VStack {
                        Text("Selected tab is at index \(selectedTab)")
                            .padding(.top, 20)
                        Spacer()

                    }.frame(width: UIScreen.main.bounds.width)
                        .background(Color.lightGray.opacity(0.2))


                }
                VStack(alignment: .center) {
                    Spacer()
                    RoundedRectangle(cornerRadius: 15).fill(Color.white)
                        .overlay {
                            VStack(alignment: .center, spacing: 15) {
                                Image(actorType != .CUSTOMER ? "ProviderImage" : "CustomerImage")
                                    .resizable()
                                    .frame(width: 144, height: 144, alignment: .center)
                                    .aspectRatio(contentMode: .fit)
                                HStack(alignment: .center, spacing: 0) {
                                    Text("You entered to QLOGA as ")
                                        .foregroundColor(.secondary)
                                    Text(actorType != .CUSTOMER ? "Provider" : "Customer")
                                        .foregroundColor(actorType != .CUSTOMER ? .providerColor : .accentColor)
                                }
                                .font(.system(size: 19, weight: .regular, design: .rounded))
                                HStack(alignment: .center) {
                                    Text("To update your profile in the future click on icon")
                                        .foregroundColor(.secondary.opacity(0.8))
                                        .font(.system(size: 18, weight: .regular, design: .rounded))
                                    Spacer()
                                    Image(actorType != .CUSTOMER ? "ProviderProfileIcon" : "CustomerProfileIcon")
                                        .resizable()
                                        .frame(width: 30, height: 36, alignment: .bottom)
                                        .scaledToFit()
                                        .foregroundColor(actorType != .CUSTOMER ? .providerColor : .accentColor)
                                }.padding(.horizontal, 15)
                                HStack(alignment: .center, spacing: 15) {
                                    Image(systemName: isNotShowAgain ? "checkmark.square.fill" : "square")
                                        .foregroundColor(isNotShowAgain ? Color.accentColor : Color.lightGray)
                                        .font(.system(size: 18, weight: .medium, design: .rounded))
                                        .onTapGesture {
                                            isNotShowAgain.toggle()
                                        }
                                    Text("Do not show me again")
                                        .foregroundColor(.lightGray).lineLimit(1)
                                        .font(.system(size: 17, weight: .regular, design: .rounded))
                                }
                                NavigationLink(destination: ProfileSetupView(actorType: actorType)) {
                                    RoundedRectangle(cornerRadius: 10).fill(Color.accentColor)
                                        .frame(width: 172, height: 40, alignment: .center)
                                        .overlay {
                                            Text("Go to profile")
                                                .foregroundColor(.white).lineLimit(1)
                                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                        }
                                }
                            }.padding(.horizontal, 20)
                        }.frame(width: UIScreen.main.bounds.width - 40, height: 350, alignment: .center)
                    Spacer()
                }
            }
        }.padding(.horizontal, 20).padding(.top, 10)
        .toolbar {
            HStack {
                Spacer()
                if actorType != .CUSTOMER {
                    NavigationLink(destination: GoogleMapView(providers: .constant(
                        [Address(postcode: "", town: "", street: "", -33.86, 151.20),
                         Address(postcode: "", town: "", street: "", -33.26, 151.24),
                         Address(postcode: "", town: "", street: "", -32.26, 151.34)]),
                                                              pickedAddress: .constant(Address(postcode: "", town: "", street: "",
                                                                                               locationManager.latitude, locationManager.longitude)))) {
                        Image("MapIcon")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .padding(5)
                    }
                }
                Button {
                    isFiltersPresented.toggle()
                } label: {
                    Image("FilterIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .center)
                        .accentColor(Color.accentColor)
                        .foregroundColor(.accentColor)
                        .padding(5)
                }
                NavigationLink(destination: ProfileSetupView(actorType: actorType)) {

                    Image(actorType != .CUSTOMER ? "ProviderProfileIcon" : "CustomerProfileIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30, alignment: .center)
                        .accentColor(Color.accentColor)
                        .foregroundColor(.accentColor)
                        .padding(5)
                }
            }
        }
        .sheet(isPresented: $isFiltersPresented) { ProvidersFilterView().cornerRadius(35) }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SuccessEnrollmenrModalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EnrolledProfileView(actorType: .PROVIDER)
        }
    }
}
