//
//  ContentView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import Combine

struct IntroView: View {
    @State var address: String = "Enter new address"
    @State var selectedButton: Int = 0
    @State var isSearchEnabled = false

//    @Binding var addressSearchView: AddressSearchView
    var body: some View {
        NavigationView {
                VStack(alignment: .center, spacing: 10) {
                    AddressSearchBarView
                    HStack(alignment: .center, spacing: 15) {
                        ServicesScrollView.padding([.vertical])
                            .ignoresSafeArea(.all, edges: .bottom).zIndex(1.0)
//                        Divider().padding(.top).padding(.top, 5)
                        Spacer()
                        ProfileChooserView
                    }
                }
                .padding([.top])
                .padding(.horizontal, 30)
                .navigationBarTitle("").navigationBarHidden(true)
        }.environment(\.colorScheme, .light)
            .sheet(isPresented: $isSearchEnabled) {
                AddressSearchView(address: $address)
            }
           
    }
}

extension IntroView {
    private var AddressSearchBarView: some View {
        NavigationLink(destination: AddressSearchView(address: $address)) {


                HStack(alignment: .center, spacing: 15, content: {
                    Image("SearchIcon").resizable().aspectRatio(contentMode: .fit).frame(width: 24.0, height: 24.0, alignment: .center)
                        .padding(.horizontal, 5)
                    ZStack {

                        Text(address == "" || address == "Enter new address" ? "Enter new address" : "").foregroundColor( .lightGray.opacity(0.6)).font(.system(size: 16, weight: .regular, design: .rounded))
                    Text(address).foregroundColor(address == "Enter new address" ? .lightGray.opacity(0.6) : Color.init("Orange").opacity(1)).font(.system(size: 16, weight: .regular, design: .rounded))
                    }

                    Spacer()
                }).padding(10)//.frame(width: UIScreen.main.bounds.width - 46)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(address == "Enter new address" || address == "" ? Color.lightGray.opacity(0.6) : Color.init("Orange").opacity(0.8), lineWidth: 1)
                            .shadow(color: .secondary.opacity(0.6), radius: 3, y: 3)
                    )
            }

    }


    private var ServicesScrollView: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(Services) { service in
                Button {
                    selectedButton = service.id
                } label: {

                    VStack {
                        Image(service.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedButton == service.id ? Color.accentColor : Color.lightGray.opacity(0.6), lineWidth: selectedButton == service.id ? 2.0 : 1.5)
                                    .shadow(color: .secondary.opacity(0.6), radius: 3, y: 3)).padding(.bottom, -3).padding(.top,2)
                        Text(service.name).foregroundColor(Color.black)
                            .font(.system(size: 10.0, weight: .light, design: .rounded))
                    }.padding([.bottom, .horizontal], 3)
                        .frame(maxWidth: 70)

                }
            }
        }
    }

    private var ProfileChooserView: some View {
        VStack(alignment: .center, spacing: 15) {
            NavigationLink(destination: EnrollmentInfoView()) {
                VStack(alignment: .center, spacing: 10) {
                    Image("CustomerIntro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .shadow(color: .lightGray.opacity(0.5), radius: 3)
                    Text("Request")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .medium,
                                      design: .rounded))
                }.padding(.horizontal).padding().overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.lightGray.opacity(0.5), lineWidth: 1)
                        .frame(maxWidth: .infinity).shadow(color: .secondary.opacity(0.6), radius: 3, y: 3)
                )
            }
            NavigationLink(destination: ProviderSearchView()) {
                VStack(alignment: .center, spacing: 10) {
                    Image("ProviderSearchIntro")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(10)
                        .shadow(color: .lightGray.opacity(0.5), radius: 3)
                    Text("Provider search").foregroundColor(.black).font(.system(size: 16, weight: .medium, design: .rounded))

                }.padding(.horizontal).padding()
                    .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(address == "Enter new address" ? Color.lightGray.opacity(0.5) : Color.accentColor.opacity(0.6), lineWidth: 1)
                                .frame(maxWidth: .infinity) .shadow(color: .secondary.opacity(0.6), radius: 3, y: 3)
                    )
            }
            NavigationLink(destination: EnrollmentInfoView()) {
                VStack(alignment: .center, spacing: 10) {
                    Image("BecomeProviderIntro").resizable().aspectRatio(contentMode: .fit)
                        .padding(10)
                        .shadow(color: .lightGray.opacity(0.5), radius: 3)
                    Text("Become to provider").foregroundColor(.black).font(.system(size: 15, weight: .medium, design: .rounded))
                }.padding(.horizontal).padding().overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.lightGray.opacity(0.5), lineWidth: 1)
                        .frame(maxWidth: .infinity).shadow(color: .secondary.opacity(0.6), radius: 3, y: 3)

                )
            }

        }.padding([.vertical]).padding([.bottom])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}




