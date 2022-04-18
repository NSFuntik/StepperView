//
//  ProviderOrdersListTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI
import Combine
class OrdersViewModel: ObservableObject {
    //    typealias OffTime = OrderTime
    @Published var orders: [OrderContent] = []
    @StateObject var CategoryVM = CategoriesViewModel()

    //    @Published var totalPrice: NSNumber?
    var ordersRoot: OrdersRoot

    var defaultOrders: [OrderContent]
    static let shared = OrdersViewModel()

    init() {
        self.ordersRoot = try! newJSONDecoder().decode(OrdersRoot.self, from: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "orders", ofType: "json")!)))
        self.defaultOrders = ordersRoot.content
        
        print(self.defaultOrders)
        self.orders.append(contentsOf: defaultOrders)
    }
}
struct PrvOrdersListTabView: View {
    @Binding var provider: Provider
    @Binding var customer: Customer
    @EnvironmentObject var tabController: TabController
    @ObservedObject var ordersController: OrdersViewModel
    @State var orders = Orders
    @Binding var actorType: ActorsEnum
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                Divider().background(Color.accentColor)
                ForEach(orders.indices, id: \.self) { orderId in
                    VStack {
                        //.padding(.leading, 20)
                        OrdersListCell(order: orders[orderId], customer: $customer, actorType: $actorType)
                        Divider().background(Color.accentColor)
                    }.background(Color.white)
                }
                Spacer()
            }.padding(.top, 5).listStyle(.grouped)
        }
    }
}

struct ProviderOrdersListTabView_Previews: PreviewProvider {
    static var previews: some View {
        PrvOrdersListTabView(provider: .constant(testProvider), customer: .constant(testCustomer), ordersController: OrdersViewModel.shared, actorType:  .constant(.PROVIDER))
    }
}


struct OrdersListCell: View {
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

                    Text("\(order.statusRecord.status.capitalized.replacingOccurrences(of: "_", with: " "))")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.red)
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
            }
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
            RemovableTagListView(selected: $catID, isRemovable: .constant(false),
                                 categoriesVM: CategoriesViewModel.shared,
                                 tags:
                                    Binding { Set(getCategoriesFor(order: order).frequency.map({ category, count in
                return " \(category.title): \(count)"
            }))} set: { tags in
                self.tags = tags
            }, fontSize: 21.5).scaleEffect(0.78).offset(x: -40)

                .disabled(true)

        }.padding(15).padding(.bottom, 5)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring()) {
                        $order.wrappedValue.services = $order.wrappedValue.services
                    }
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


func getDate(from dateString: String, _ dateFormat: String) -> Date {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.amSymbol = ""
    formatter.pmSymbol = ""
    let date: Date = formatter.date(from: dateString)!

    return date
}

//func getString(from date: Date, _ dateFormat: String) -> String {
//    let formatter = DateFormatter()
//    formatter.dateFormat = dateFormat
//    let string: String = formatter.string(from: date)
//
//    return string
//}
