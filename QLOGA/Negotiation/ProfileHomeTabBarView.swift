//
//  EntryProfileView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI

struct ProfileHomeTabBarView: View {
    @State var provider: Provider = testProvider
    @Binding var actorType: ActorsEnum
    @State var customer: Customer = testCustomer
    enum HomeTab: Int {
        case orders, requests, search, favourites
        var title: String {
            switch self {
                case .orders:
                    return   "Orders"
                case .requests:
                    return  "Open Requests"
                case .search:
                    return "Provider Search"
                case .favourites:
                    return "Favourite providers"
            }
        }
    }
    @State var isFiltersPresented = false
    @State var tab: HomeTab = .orders
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        NavigationView {

            TabView(selection: $tab) {
                EnrolledProfileView(actorType: $actorType)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationViewStyle(.stack)
                    .tabItem {
                        Label("Orders", systemImage: "list.bullet.rectangle.portrait")
                    }
                    .navigationTitle("Orders")
                    .tag(HomeTab.orders)
                    .navigationTitle("\($tab.wrappedValue.title)")

                PrvRequestsTabView(provider: $provider, customer: $customer) .navigationTitle("Open Requests")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationViewStyle(.stack)
                    .tabItem {
                        Label("Requests", systemImage: "hand.raised")
                    }
                    .navigationTitle("Requests")
                    .tag(HomeTab.requests)
                    .navigationTitle("\($tab.wrappedValue.title)")
                ProviderSearchView()
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationViewStyle(.stack)
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass").navigationTitle("Provider Search")
                    }
                    .tag(HomeTab.search)
                    .navigationTitle("\($tab.wrappedValue.title)")
                FavoritesTabView(provider: $provider).navigationBarTitleDisplayMode(.inline)
                    .navigationViewStyle(.stack)
                    .tabItem {
                        Label("Favorites", systemImage: "suit.heart").navigationTitle("Favourites")
                    }
                    .tag(HomeTab.favourites)
                    .navigationTitle("\($tab.wrappedValue.title)")
            }
            .navigationTitle("\($tab.wrappedValue.title)")
            .toolbar {
             
                ToolbarItemGroup {
                    HStack(alignment: .center) {

                        if actorType == .PROVIDER {
                            NavigationLink(destination: GoogleMapView(providers: .constant(
                                [Address(postcode: "", town: "", street: "", -33.86, 151.20),
                                 Address(postcode: "", town: "", street: "", -33.26, 151.24),
                                 Address(postcode: "", town: "", street: "", -32.26, 151.34)]),
                                                                      pickedAddress: .constant(Address(postcode: "", town: "", street: "",
                                                                                                       locationManager.latitude, locationManager.longitude)))) {
                                Image("MapIcon")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.accentColor)
                                    .frame(width: 30, height: 30, alignment: .trailing)
                                    .padding(5)
                            }
                        }
                        Button {
                            isFiltersPresented = true
                        } label: {
                            Image("FilterIcon")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.accentColor)
                                .frame(width: 30, height: 30, alignment: .trailing)
                                .padding(5)
                        }


                        NavigationLink(destination: ProfileSetupView(actorType: $actorType, customer: $customer, provider: $provider)) {
                            Image(actorType != .CUSTOMER ? "ProviderProfileIcon" : "CustomerProfileIcon")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.accentColor)
                                .frame(width: 30, height: 30, alignment: .trailing)
                                .padding(5)
                        }

                    }
                }


            }
        }.navigationBarTitleDisplayMode(.inline)
            .navigationViewStyle(.stack)

            .sheet(isPresented: $isFiltersPresented) { ProvidersFilterView().cornerRadius(35) }

        //            .navigationBarHidden(true)

    }
}

struct EntryProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHomeTabBarView(actorType: .constant( .CUSTOMER))
    }
}
