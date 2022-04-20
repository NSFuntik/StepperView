//
//  TodayTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/18/22.
//

import SwiftUI
import Combine

class OrdersCotroller: ObservableObject {
    @Published var PrvOrders: [OrderContent] = [
            OrderContent(statusRecord:
                            OrderStatusRecord(date: "2022-03-04T01:08:35.500828Z", actor: "QLOGA", actorId: 1002, action: "CLOSE_DISPUTE_WINDOW", note: "After 7 days Order dispute opportunity window is now closed.", status: .VISIT_CALLOUT_2PAY, display: "Visit Callout Charge requested", actionDisplay: "Close dispute period", actionPast: "QLOGA closed dispute opportunity window for the order"),
                         id: 1122,
                         addr: CstAddress(id: 1004, familyId: 1000, country: "GB", line1: "30", line2: "Cloth Market", town: "Newcastle upon Tyne", postcode: "NE1 1EE", lat: 54.9783, lng: -1.612255, timeOffset: 3600000, vrfs: [], businessOnly: false, line3: "Merchant House"),
                         amount: 35000, calloutAmount: nil, callout: false,
                         serviceDate: getDate(from: "2022-06-22 10:00:00", "YYYY-MM-DD HH:mm:ss"),
                         services: [
                            OrderService(id: 1178, conditions: [10], qty: 2, cost: 15000, timeNorm: 60, qserviceId: 140),
                            OrderService(id: 1179, conditions: [10], qty: 1, cost: 5000, timeNorm: 60, qserviceId: 130)
                         ],
                         provider:
                            OrderProvider(id: 1002, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
                         providerOrg:
                            OrderProviderOrg(name: "Kai\'s Elderly care business (London)", offTime: [], workingHours: [], verifications: [],                                  settings: OrderSettings()),
                         cancelHrs: nil, cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []), dayPlans: [], cstActions: [], prvActions: [], payments: [], assigns: []),
            OrderContent(
                statusRecord:
                    OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .ACCEPTED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                id: 20218000753074,
                addr:
                            CstAddress(id: 1001, familyId: 1000, country: "GB", line1: "01", line2: "Princes Street", town: "Edinburgh", postcode: "EH2 2ER", lat: 55.953188, lng: -3.189556, timeOffset: 3600000, vrfs: [
                                CstVrf(id: 10000, type: "ADDRESS", subjId: 1001, holderId: 1001, date: getDate(from: "2018-10-10 00:00:00", "YYYY-MM-DD HH:mm:ss") , notes: "Address verification for managing Kai\'s Org")], businessOnly: false, line3: nil), amount: 150000, calloutAmount: 1500, callout: true, serviceDate: getDate(from: "2022-03-27 09:00:00", "YYYY-MM-DD HH:mm:ss"),
                services: [
                    OrderService(id: 1177, conditions: [10], qty: 1, cost: 150000, timeNorm: 60, qserviceId: 40)
                ],
                provider:
                    OrderProvider(id: 1001, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
                providerOrg: OrderProviderOrg(name: "Kai\'s Cleaning agency (Edinburgh)", offTime: [], workingHours: [], verifications: [], settings: OrderSettings()),
                cancelHrs: 4,
                cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []),
                dayPlans: [
                            OrderDayPlan(id: 1033, day: "2022-03-27",
                                         visit1:
                                            OrderVisit(time: "09:00", status:
                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_APPROVED", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                                                       tracks: [
                                                        OrderStatusRecord(date: "2022-03-28T09:04:17.082419Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")
                                                       ], prvActions: [], cstActions: []),
                                         visit2: OrderVisit(time: "11:00", status:
                                                                OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"), tracks: [
                                                                    OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")], prvActions: [], cstActions: []),
                                         visit3: OrderVisit(time: nil, status: nil, tracks: [], prvActions: [], cstActions: []))
                ], cstActions: [], prvActions: [], payments: [], assigns: [])
        ]
    @Published var PrvQuotes: [OrderContent] = []
    @Published var CstInquires: [OrderContent] = [
            OrderContent(
                statusRecord:
                    OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .INQUIRY, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                id: 20218000753074,
                addr:
                    CstAddress(id: 1001, familyId: 1000, country: "GB", line1: "01", line2: "Princes Street", town: "Edinburgh", postcode: "EH2 2ER", lat: 55.953188, lng: -3.189556, timeOffset: 3600000, vrfs: [
                        CstVrf(id: 10000, type: "ADDRESS", subjId: 1001, holderId: 1001, date: getDate(from: "2018-10-10 00:00:00", "YYYY-MM-DD HH:mm:ss") , notes: "Address verification for managing Kai\'s Org")], businessOnly: false, line3: nil), amount: 150000, calloutAmount: 1500, callout: true, serviceDate: getDate(from: "2022-03-27 09:00:00", "YYYY-MM-DD HH:mm:ss"),
                services: [
                    OrderService(id: 1177, conditions: [10], qty: 1, cost: 150000, timeNorm: 60, qserviceId: 40)
                ],
                provider:
                    OrderProvider(id: 1001, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
                providerOrg: OrderProviderOrg(name: "Kai\'s Cleaning agency (Edinburgh)", offTime: [], workingHours: [], verifications: [], settings: OrderSettings()),
                cancelHrs: 4,
                cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []),
                dayPlans: [], cstActions: [], prvActions: [], payments: [], assigns: []),
            OrderContent(statusRecord:
                            OrderStatusRecord(date: "2022-03-04T01:08:35.500828Z", actor: "QLOGA", actorId: 1002, action: "CLOSE_DISPUTE_WINDOW", note: "After 7 days Order dispute opportunity window is now closed.", status: .CST_DECLINED, display: "Visit Callout Charge requested", actionDisplay: "Close dispute period", actionPast: "QLOGA closed dispute opportunity window for the order"),
                         id: 1122,
                         addr: CstAddress(id: 1004, familyId: 1000, country: "GB", line1: "30", line2: "Cloth Market", town: "Newcastle upon Tyne", postcode: "NE1 1EE", lat: 54.9783, lng: -1.612255, timeOffset: 3600000, vrfs: [], businessOnly: false, line3: "Merchant House"),
                         amount: 35000, calloutAmount: nil, callout: false,
                         serviceDate: getDate(from: "2022-06-22 10:00:00", "YYYY-MM-DD HH:mm:ss"),
                         services: [
                            OrderService(id: 1178, conditions: [10], qty: 2, cost: 15000, timeNorm: 60, qserviceId: 140),
                            OrderService(id: 1179, conditions: [10], qty: 1, cost: 5000, timeNorm: 60, qserviceId: 130)
                         ],
                         provider:
                            OrderProvider(id: 1002, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
                         providerOrg:
                            OrderProviderOrg(name: "Kai\'s Elderly care business (London)", offTime: [], workingHours: [], verifications: [],                                  settings: OrderSettings()),
                         cancelHrs: nil, cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []), dayPlans: [
                            OrderDayPlan(id: 1033, day: "2022-03-27",
                                         visit1:
                                            OrderVisit(time: "09:00", status:
                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_APPROVED", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                                                       tracks: [
                                                        OrderStatusRecord(date: "2022-03-28T09:04:17.082419Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")
                                                       ], prvActions: [], cstActions: []),
                                         visit2: OrderVisit(time: "11:00", status:
                                                                OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"), tracks: [
                                                                    OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")], prvActions: [], cstActions: []),
                                         visit3: OrderVisit(time: nil, status: nil, tracks: [], prvActions: [], cstActions: []))
                         ], cstActions: [], prvActions: [], payments: [], assigns: [])
        ]
    @Published var CstOrders: [OrderContent] = []
    @Published var CstQuotes: [OrderContent] = [
            OrderContent(
                statusRecord:
                    OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .QUOTE, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                id: 20218000753074,
                addr:
                    CstAddress(id: 1001, familyId: 1000, country: "GB", line1: "01", line2: "Princes Street", town: "Edinburgh", postcode: "EH2 2ER", lat: 55.953188, lng: -3.189556, timeOffset: 3600000, vrfs: [
                        CstVrf(id: 10000, type: "ADDRESS", subjId: 1001, holderId: 1001, date: getDate(from: "2018-10-10 00:00:00", "YYYY-MM-DD HH:mm:ss") , notes: "Address verification for managing Kai\'s Org")], businessOnly: false, line3: nil), amount: 150000, calloutAmount: 1500, callout: true, serviceDate: getDate(from: "2022-03-27 09:00:00", "YYYY-MM-DD HH:mm:ss"),
                services: [
                    OrderService(id: 1177, conditions: [10], qty: 1, cost: 150000, timeNorm: 60, qserviceId: 40)
                ],
                provider:
                    OrderProvider(id: 1001, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
                providerOrg: OrderProviderOrg(name: "Kai\'s Cleaning agency (Edinburgh)", offTime: [], workingHours: [], verifications: [], settings: OrderSettings()),
                cancelHrs: 4,
                cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []),
                dayPlans: [], cstActions: [], prvActions: [], payments: [], assigns: []),
            OrderContent(statusRecord:
                            OrderStatusRecord(date: "2022-03-04T01:08:35.500828Z", actor: "QLOGA", actorId: 1002, action: "CLOSE_DISPUTE_WINDOW", note: "After 7 days Order dispute opportunity window is now closed.", status: .CST_DECLINED, display: "Visit Callout Charge requested", actionDisplay: "Close dispute period", actionPast: "QLOGA closed dispute opportunity window for the order"),
                         id: 1122,
                         addr: CstAddress(id: 1004, familyId: 1000, country: "GB", line1: "30", line2: "Cloth Market", town: "Newcastle upon Tyne", postcode: "NE1 1EE", lat: 54.9783, lng: -1.612255, timeOffset: 3600000, vrfs: [], businessOnly: false, line3: "Merchant House"),
                         amount: 35000, calloutAmount: nil, callout: false,
                         serviceDate: getDate(from: "2022-06-22 10:00:00", "YYYY-MM-DD HH:mm:ss"),
                         services: [
                            OrderService(id: 1178, conditions: [10], qty: 2, cost: 15000, timeNorm: 60, qserviceId: 140),
                            OrderService(id: 1179, conditions: [10], qty: 1, cost: 5000, timeNorm: 60, qserviceId: 130)
                         ],
                         provider:
                            OrderProvider(id: 1002, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []),
                         providerOrg:
                            OrderProviderOrg(name: "Kai\'s Elderly care business (London)", offTime: [], workingHours: [], verifications: [],                                  settings: OrderSettings()),
                         cancelHrs: nil, cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []), dayPlans: [
                            OrderDayPlan(id: 1033, day: "2022-03-27",
                                         visit1:
                                            OrderVisit(time: "09:00", status:
                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_APPROVED", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                                                       tracks: [
                                                        OrderStatusRecord(date: "2022-03-28T09:04:17.082419Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"),
                                                        OrderStatusRecord(date: "2022-03-28T12:23:57.285168Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 1 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")
                                                       ], prvActions: [], cstActions: []),
                                         visit2: OrderVisit(time: "11:00", status:
                                                                OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit"), tracks: [
                                                                    OrderStatusRecord(date: "2022-03-28T12:23:57.293317Z", actor: "CUSTOMER", actorId: 1002, action: "VISIT_CANCEL", note: "Visit 2 is marked as \"Provider not arrived\" after 24 hours of no response from the provider.", status: .VISIT_APPROVED, display: "VISIT_CANCELLED", actionDisplay: "Cancel visit", actionPast: "Customer cancelled the visit")], prvActions: [], cstActions: []),
                                         visit3: OrderVisit(time: nil, status: nil, tracks: [], prvActions: [], cstActions: []))
                         ], cstActions: [], prvActions: [], payments: [], assigns: [])
        ]
    @Published var PrvInquires: [OrderContent] = []

    public static var shared = OrdersCotroller()
}

//var PrvQuotes: [OrderContent] = []
//var CstInquires: [OrderContent] = []
//var CstOrders: [OrderContent] = []
//var PrvOrders: [OrderContent] = []
//var CstQuotes: [OrderContent] = []
//var PrvInquires: [OrderContent] = []

struct TodayListTabView: View {
    @Binding var provider: Provider
    @Binding var customer: Customer
    @Binding var actorType: ActorsEnum
    @EnvironmentObject var tabController: TabController
    @ObservedObject var ordersController: OrdersViewModel
    @State var orders = OrdersCotroller.shared.PrvOrders
    var body: some View {
        ScrollView {
            VStack(spacing: -22) {
                if actorType == .CUSTOMER {
                    if  !OrdersCotroller.shared.CstInquires.isEmpty {
                        InquiryListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                    }
                    if  !OrdersCotroller.shared.CstQuotes.isEmpty {
                        QuotesListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                    }
                    if !OrdersCotroller.shared.CstOrders.isEmpty {
                        OrdersListTabView(provider: $provider, customer: $customer, ordersController: ordersController, actorType: $actorType)
                    }
                }
                if  actorType == .PROVIDER {
                    if  !OrdersCotroller.shared.PrvQuotes.isEmpty {
                        QuotesListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                    }
                    if  !OrdersCotroller.shared.PrvInquires.isEmpty {
                        InquiryListTabView(provider: $provider, customer: $customer, actorType: $actorType, ordersController: ordersController)
                    }
                    if !OrdersCotroller.shared.PrvOrders.isEmpty {
                        OrdersListTabView(provider: $provider, customer: $customer, ordersController: ordersController, actorType: $actorType)
                    }
                }
                Spacer()
            }.padding(.top, 15)
        }.background(Color.white.opacity(0.7))
    }
}

struct TodayListTabViewListTabView_Previews: PreviewProvider {
    static var previews: some View {
        TodayListTabView(provider: .constant(testProvider), customer: .constant(testCustomer), actorType:  .constant(.PROVIDER), ordersController: OrdersViewModel.shared)
    }
}


struct TodayListCell: View {
    typealias Int = CategoryType.ID
    @State var catID: CategoryType.ID = 0
    @State var order: OrderContent
    @Binding var customer: Customer
    @State var tags: Set<String> = []
    @Binding var actorType: ActorsEnum

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            NavigationLink(destination: OrderDetailView(actorType: $actorType, orderType: .Order, order: $order)) {
                VStack(alignment: .leading, spacing: 10) {
                    VStack {
                        HStack {
                            Text(order.statusRecord.status.display)
                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                .foregroundColor(.black).padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 10))
                            Spacer()
                        }
                        Divider().background(Color.lightGray)
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [Color(hex: order.statusRecord.status.colors[0])!,
                                                                           Color(hex: order.statusRecord.status.colors[1])!]),
                                               startPoint: .leading, endPoint: .trailing))
                    .padding([.top, .horizontal], -15)
                    HStack {
                        if order.dayPlans.count > 0 {
                            Text("\(order.dayPlans.count + 1) Visits")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                                .foregroundColor(.secondary)
                        } else {
                            Text("\(getString(from: order.serviceDate, "MM-DD-YYYY HH:mm"))")
                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text(poundsFormatter.string(from: order.amount as NSNumber)!)//order.services.map({$0.qty * $0.cost}).reduce(0, +) as NSNumber)!)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                    }
                    if order.dayPlans.count > 0 {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(alignment: .center, spacing: 0) {
                                Text("First Visit: \(order.dayPlans.last!.day) \(order.dayPlans.first!.visit1.time!)")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            HStack(alignment: .center, spacing: 0) {
                                Text("Last Visit:  \(order.dayPlans.last!.day) \(order.dayPlans.last!.visit2.time!)")
                                    .font(.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                    }
                }
            }.zIndex(0)
            if actorType == .PROVIDER {
                NavigationLink(destination: GoogleMapView(providers: .constant([]), pickedAddress: $order.addr.defaultAddress)) {
                    HStack(alignment: .top, spacing: 5) {
                        Image("MapSymbol")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit().aspectRatio(contentMode: .fit)
                            .foregroundColor(.accentColor)
                            .frame(width: 20, height: 20, alignment: .center)
                        Text(order.addr.total ?? "")
                            .lineLimit(3)
                            .foregroundColor(Color.secondary.opacity(0.8))
                            .font(Font.system(size: 15,
                                              weight: .regular,
                                              design: .rounded))
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }.padding(.vertical, 10).frame(idealHeight: 30, maxHeight: 45)
                }
            } else {
                HStack(alignment: .top, spacing: 5) {
                    Text(order.addr.total ?? "")
                        .lineLimit(3)
                        .foregroundColor(Color.secondary.opacity(0.8))
                        .font(Font.system(size: 15,
                                          weight: .regular,
                                          design: .rounded))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }.padding(.vertical, 5).frame(idealHeight: 20, maxHeight: 40)
            }
            HStack {
                RemovableTagListView(selected: $catID, isRemovable: .constant(false),
                                     categoriesVM: CategoriesViewModel.shared,
                                     tags:
                                        Binding { Set(getCategoriesFor(order: order).frequency.map({ category, count in
                    return " \(category.title): \(count)"
                }))} set: { tags in
                    self.tags = tags
                }, fontSize: 21.5).padding(1)
            }
            .scaleEffect(0.78).offset(x: -40)
            .disabled(true)
        }.padding(15).background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 13))
            .overlay(RoundedRectangle(cornerRadius: 13).stroke(lineWidth: 1).fill(Color.lightGray))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    $order.wrappedValue = $order.wrappedValue
                }
            }
    }

    func getCategoriesFor(order: OrderContent) -> [CategoryType] {
        var categories: [CategoryType] = []
        let qServiceIDDict = qServiceID
        order.services.forEach { s in
            qServiceIDDict.keys.compactMap { qId in
                if qId == s.qserviceId {
                    categories.append(qServiceID[qId]!)
                }
            }
        }
        return categories
    }
}
