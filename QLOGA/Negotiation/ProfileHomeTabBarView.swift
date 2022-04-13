//
//  EntryProfileView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI
import Combine


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
class TabController: ObservableObject {
    public var objectWillChange = PassthroughSubject<Void, Never>()
    @Published var activeTab: HomeTab = .requests {
        willSet {
            objectWillChange.send()
        }
    }
    static let shared = TabController()

    func open(_ tab: HomeTab) {
        activeTab = tab
    }
}
struct ProfileHomeTabBarView: View {
    @State var provider: Provider = testProvider
    @Binding var actorType: ActorsEnum
    @State var customer: Customer = testCustomer
    @StateObject var tabController: TabController

    @State var isFiltersPresented = false
    @State var tab: HomeTab = .orders
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        NavigationView {
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                        switch tabController.activeTab {
                            case .orders:
                                EnrolledProfileView(actorType: $actorType).navigationTitle("\(tabController.activeTab.title)")
                            case .requests:
                                CstRequestsTabView(provider: $provider, customer: $customer)
                                    .navigationTitle("Open Requests").navigationBarTitleDisplayMode(.inline)
                            case .search:
                                ProviderSearchView().navigationTitle("Provider Search")
                            case .favourites:
                                FavoritesTabView(provider: $provider).navigationTitle("Favorite Providers")
                        }
                        Spacer()
                        ZStack {
                            //                    if showPopUp {
                            //                        PlusMenu(widthAndHeight: geometry.size.width/7)
                            //                            .offset(y: -geometry.size.height/6)
                            //                    }
                            HStack {
                                TabBarIcon(tabController: tabController, assignedPage: .orders, width: geometry.size.width/4, height: geometry.size.height/28, systemIconName: "OrdersTabIcon", tabName: "Orders")
                                TabBarIcon(tabController: tabController, assignedPage: .requests, width: geometry.size.width/4, height: geometry.size.height/28, systemIconName: "RequestsTabIcon", tabName: "Requests")
                                TabBarIcon(tabController: tabController, assignedPage: .search, width: geometry.size.width/4, height: geometry.size.height/28, systemIconName: "SearchTabIcon", tabName: "Search")
                                TabBarIcon(tabController: tabController, assignedPage: .favourites, width: geometry.size.width/4, height: geometry.size.height/28, systemIconName: "FavouritesTabIcon", tabName: "Favourites")
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height/8)
                            .background(.white)
                        }//.overlay(Rectangle().stroke(lineWidth: 0.2).fill(Color.lightGray.opacity(0.2)).foregroundColor((Color.lightGray.opacity(0.2))))
                    }
                    .edgesIgnoringSafeArea(.bottom)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
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
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        HStack(alignment: .center) {
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
                                    .foregroundColor(actorType == .CUSTOMER ? .accentColor : .infoBlue)
                                    .frame(width: 30, height: 30, alignment: .trailing)
                                    .padding(5)
                            }

                        }

                    }
                }
        }
            .environmentObject(tabController)
            .sheet(isPresented: $isFiltersPresented) { ProvidersFilterView().cornerRadius(35) }
            .navigationViewStyle(.stack)
    }
}


struct EntryProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHomeTabBarView(actorType: .constant( .CUSTOMER), tabController: .init())
            .previewDevice("iPhone 6s")
    }
}

struct TabBarIcon: View {
    @StateObject var tabController: TabController
    let assignedPage: HomeTab

    let width, height: CGFloat
    let systemIconName, tabName: String

    var body: some View {
        VStack {
            Image(systemIconName)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height)
                .padding(.top, 10)
            Text(tabName)
                .font(.footnote)
            Spacer()
        }
        .padding(.horizontal, -4)
        .onTapGesture {
            tabController.activeTab = assignedPage
        }
        .foregroundColor(tabController.activeTab == assignedPage ? .accentColor : .gray)
    }
}
