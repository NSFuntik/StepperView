//
//  SuccessEnrollmenrModalView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import Combine

enum ProviderTodayTab: Int, CaseIterable, Identifiable {
    var id: Int { self.rawValue }
    case Today
    case Orders
    case Quotes
    case Inquires
    var description: String {
        switch self {
            case .Today:
                return "Today"
            case .Orders:
                return "Orders"
            case .Quotes:
                return "Quotes"
            case .Inquires:
                return "Inquires"
        }
    }
}
enum CustomerTodayTab: Int, CaseIterable, Identifiable {
    var id: Int { self.rawValue }
    case Today
    case Orders
    case Inquires
    case Quotes
    var description: String {
        switch self {
            case .Today:
                return "Today"
            case .Orders:
                return "Orders"
            case .Inquires:
                return "Inquires"
            case .Quotes:
                return "Quotes"
        }
    }
}
struct EnrolledProfileView: View {
    var allPrvTitles: [String] = [ProviderTodayTab.Today.description, ProviderTodayTab.Orders.description,
                                  ProviderTodayTab.Quotes.description, ProviderTodayTab.Inquires.description]
    var allCstTitles: [String] = [CustomerTodayTab.Today.description, CustomerTodayTab.Orders.description,
                                  CustomerTodayTab.Inquires.description, CustomerTodayTab.Quotes.description]

    @State private var selectedTab = 0
    @EnvironmentObject var tabController: TabController
    @ObservedObject var locationManager = LocationManager()
    @StateObject var ordersController = OrdersViewModel()
    @Binding var actorType: ActorsEnum
    @State var customer: Customer = testCustomer
    @State var provider: Provider = testProvider
    @State var isModalPresented = false
    @State var isFiltersPresented = false
    @State var isNotShowAgain = false

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    TabBarView(tabs: .constant(actorType != .CUSTOMER ? allPrvTitles : allCstTitles),
                               selection: $selectedTab,
                               underlineColor: .accentColor) { title, isSelected in
                        Text(title)
                            .font(.system(size: 18, weight: .regular, design: .rounded))
                            .ignoresSafeArea(.all, edges: .horizontal)
                            .foregroundColor(isSelected ? .black : .lightGray)
                    }
                    VStack(alignment: .center) {
                        if actorType == .CUSTOMER {
                            if CustomerTodayTab(rawValue: $selectedTab.wrappedValue) == .Today {
                                TodayListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                            } else if CustomerTodayTab(rawValue: $selectedTab.wrappedValue) == .Orders {
                                OrdersListTabView(provider: $provider, customer: $customer, ordersController: ordersController, actorType: $actorType)
                            }  else if CustomerTodayTab(rawValue: $selectedTab.wrappedValue) == .Quotes {
                                QuotesListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                            } else if CustomerTodayTab(rawValue: $selectedTab.wrappedValue) == .Inquires {
                                InquiryListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                            }
                        } else {
                            if ProviderTodayTab(rawValue: $selectedTab.wrappedValue) == .Today {
                                TodayListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                            } else if ProviderTodayTab(rawValue: $selectedTab.wrappedValue) == .Orders {
                                OrdersListTabView(provider: $provider, customer: $customer, ordersController: ordersController, actorType: $actorType)
                            }  else if ProviderTodayTab(rawValue: $selectedTab.wrappedValue) == .Quotes {
                                QuotesListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                            } else if ProviderTodayTab(rawValue: $selectedTab.wrappedValue) == .Inquires {
                                InquiryListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width)
                        .background(Color.lightGray.opacity(0.2))
                }
                .disabled(isModalPresented)
                if isModalPresented {
                    infoModal
                }
            }
            .sheet(isPresented: $isFiltersPresented) { ProvidersFilterView().cornerRadius(35) }
        }
    }
}

struct SuccessEnrollmenrModalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EnrolledProfileView(actorType: .constant( .CUSTOMER))
        }.previewDevice("iPhone 6s")
    }
}
extension EnrolledProfileView {
    var infoModal: some View {
        VStack(alignment: .center) {
            Spacer()
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .lightGray, radius: 3, x: 0, y: 1)
                .overlay {
                    VStack(alignment: .center, spacing: 15) {
                        Image(actorType != .CUSTOMER ? "ProviderImage" : "CustomerImage")
                            .resizable()
                            .frame(width: 144, height: 144, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                isModalPresented = false
                            }
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
                        NavigationLink(destination: ProfileSetupView(actorType: $actorType, customer: $customer, provider: $provider)) {
                            RoundedRectangle(cornerRadius: 10).fill(Color.accentColor)
                                .frame(width: 172, height: 40, alignment: .center)
                                .overlay {
                                    Text("Go to profile")
                                        .foregroundColor(.white).lineLimit(1)
                                        .font(.system(size: 17, weight: .regular, design: .rounded))
                                }
                        }
                    }.padding(.horizontal, 20)
                }.frame(width: UIScreen.main.bounds.width - 40, height: 375, alignment: .center)
            Spacer().onTapGesture {
                isModalPresented = false
            }
        }
    }
}
