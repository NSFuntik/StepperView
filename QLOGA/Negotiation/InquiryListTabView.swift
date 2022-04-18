//
//  InquiryListTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/19/22.
//

import SwiftUI
import Combine

struct InquiryListTabView: View {
    @Binding var provider: Provider
    @Binding var customer: Customer
    @Binding var actorType: ActorsEnum
    @EnvironmentObject var tabController: TabController
    @ObservedObject var ordersController: OrdersViewModel
    @State var orders = Orders
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Divider().background(Color.accentColor)
                ForEach(orders.indices, id: \.self) { orderId in
                    VStack {
                        //.padding(.leading, 20)
                        InquiryListCell(order: orders[orderId], customer: $customer, actorType: $actorType)
                        Divider().background(Color.accentColor)
                    }.background(Color.white)
                }
                Spacer()
            }.padding(.top, 5).listStyle(.grouped)
        }

    }
}

struct InquiryListTabViewListTabView_Previews: PreviewProvider {
    static var previews: some View {
        InquiryListTabView(provider: .constant(testProvider), customer: .constant(testCustomer), actorType:  .constant(.PROVIDER), ordersController: OrdersViewModel.shared)
    }
}


struct InquiryListCell: View {
    typealias Int = CategoryType.ID
    @State var catID: CategoryType.ID = 0
    @State var order: OrderContent
    @Binding var customer: Customer
    @State var tags: Set<String> = []
    @Binding var actorType: ActorsEnum

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            NavigationLink(destination: QuoteOverView(customer: $customer, amount: Double(order.amount),  isChargeOn: order.callout, calloutCharge: Double(order.calloutAmount ?? 0 / 100), cancellation: order.cancelHrs ?? 0, showAlert: false, actorType: ActorsEnum(rawValue: order.statusRecord.actor) ?? .CUSTOMER, isPicked: false, isExist: true, services: order.services.compactMap({ s in
                var serv = StaticCategories[s.qserviceId]
                serv?.unitsCount = s.qty
                serv?.price = Double(s.cost)
                return serv
            }))) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {

                        if order.dayPlans.count > 0 {
                            Text("\(order.dayPlans.count + 1) Visits")
                                .font(.system(size: 17, weight: .semibold, design: .rounded))
                                .foregroundColor(.lightGray)
                        } else {
                            Text("\(getString(from: order.serviceDate))")
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

                    }.padding(.vertical, 5).frame(idealHeight: 20, maxHeight: 40)
                }

                //                        NavigationLink(destination: GoogleMapView(providers: .constant([]), pickedAddress: $order.addr.defaultAddress)) {

                //                        }.layoutPriority(1).zIndex(1)

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


        }.padding(15).padding(.bottom, 5)
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
