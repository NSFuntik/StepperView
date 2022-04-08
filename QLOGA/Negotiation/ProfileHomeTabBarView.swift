//
//  EntryProfileView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI

struct ProfileHomeTabBarView: View {
    @State var provider: Provider = testProvider
    @State var actorType: ActorsEnum
    @State var customer: Customer = testCustomer
    enum HomeTab: Int {
        case orders, requests, search, favourites
    }
    @State var tab: HomeTab = .orders
    var body: some View {
        
        TabView(selection: $tab) {
            
            EnrolledProfileView(actorType: .PROVIDER).navigationTitle("Orders").navigationBarTitleDisplayMode(.inline)
                        .tabItem {
                            Label("Orders", systemImage: "list.bullet.rectangle.portrait")
//                            HStack {
//
//                            Image("OrdersTabIcon")
//                                .resizable()
//                                .renderingMode(.template)
//                                .frame(width: 15, height: 15, alignment: .center)
//                                .aspectRatio(contentMode: .fit).scaledToFit()
//                                .foregroundColor(.accentColor)
//
//                            Text("Orders")
//                                .foregroundColor(Color.secondary)
//                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
//                            }

                        }
                        .tag(HomeTab.orders)

                    PrvRequestsTabView(provider: $provider).navigationTitle("Requests").navigationBarTitleDisplayMode(.inline)
                        .tabItem {
                            Label("Requests", systemImage: "hand.raised")
//                            HStack {
//
//                            Image("RequestsTabIcon")
//                                .resizable()
//                                .renderingMode(.template)
//                                .frame(width: 15, height: 15, alignment: .center)
//                                .aspectRatio(contentMode: .fit).scaledToFit()
//                                .foregroundColor(.accentColor)
//
//                            Text("Requests")
//                                .foregroundColor(Color.secondary)
//                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
//                            }

                    }
                    .tag(HomeTab.requests)

                    ProviderSearchView()
                        .tabItem {
//                            HStack {

                            Label("Search", systemImage: "magnifyingglass")
//                            Image("SearchTabIcon")
//                                .resizable()
//                                .renderingMode(.template)
//                                .frame(width: 15, height: 15, alignment: .center)
//                                .aspectRatio(contentMode: .fit).scaledToFit()
//                                .foregroundColor(.accentColor)
//                            Text("Search")
//                                .foregroundColor(Color.secondary)
//                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
//                            }

                        }
                        .tag(HomeTab.requests)

                    FavoritesTabView(provider: $provider).navigationTitle("Favourites").navigationBarTitleDisplayMode(.inline)
                        .tabItem {
//                            HStack {
//
//                                Image("FavouritesTabIcon")
//                                    .resizable()
//                                    .renderingMode(.template)
//                                    .frame(width: 15, height: 15, alignment: .center)
//                                    .aspectRatio(contentMode: .fit).scaledToFit()
//                                    .foregroundColor(.accentColor)
//                                Text("Favourites")
//                                    .foregroundColor(Color.secondary)
//                                    .font(Font.system(size: 15, weight: .regular, design: .rounded))
//                            }
                            Label("Favorites", systemImage: " suit.heart")

                        }
                        .tag(HomeTab.favourites)
        }
    }
}

struct EntryProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHomeTabBarView(actorType: .CUSTOMER)
    }
}
