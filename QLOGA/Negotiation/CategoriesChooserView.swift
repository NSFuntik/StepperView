//
//  CategoriesChooserView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/15/22.
//

import SwiftUI

struct CategoriesChooserView: View {
    @Binding var customer: Customer
    @State var amount: Double
    var body: some View {
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Divider().padding(.horizontal, -10).padding(.leading, 10)

                        ForEach($customer.services, id: \.self) { service in
                            Section {
                                DisclosureGroup(isExpanded: service.isEditable) {
                                    VStack(spacing: 10) {
                                        Text(service.descr.wrappedValue ?? "nil")
                                            .foregroundColor(Color.secondary.opacity(0.7))
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                            .lineLimit(5)
                                            .padding(10)
                                        HStack(alignment: .center, spacing: 10) {

                                            CategoryServiceCell(count: service.unitsCount,
                                                                price: service.price.wrappedValue, serviceType: service.wrappedValue)
                                            .padding(1)

                                            Spacer()
                                            NavigationLink(destination: CategoryServiceDetailView(service: service)) {
                                                HStack {

                                                    Text("Details")
                                                        .lineLimit(1)
                                                        .font(.system(size: 20, weight: .regular, design: .default))
                                                        .foregroundColor(.infoBlue)
                                                        .frame(width: 100, height: 34)

                                                        .padding(1)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color.infoBlue, lineWidth: 2)
                                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white)))
                                                        .transition(.move(edge: .leading))
                                                }
                                                .frame(width: 100, height: 35)
                                            }
                                        }.padding(.horizontal, 10)

                                    }.frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(service.name.wrappedValue ?? "nil")
                                                    .foregroundColor(Color.black.opacity(0.9))
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                    .lineLimit(1)
                                                //                                            .padding(.leading, 10)
                                                Spacer()
                                            }
                                            Spacer()
                                            HStack(alignment: .bottom, spacing: 5) {
                                                VStack {
                                                    HStack {
                                                        Text("Time norm: " + (service.timeNorm.wrappedValue?.description ?? "0") + " min/room")
                                                            .foregroundColor(Color.secondary)
                                                            .multilineTextAlignment(.leading)
                                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                            .lineLimit(1)
                                                        Spacer()

                                                    }

                                                    if !service.isEditable.wrappedValue {
                                                        CategoryServiceCell(count: service.unitsCount,
                                                                            price: service.price.wrappedValue, serviceType: service.wrappedValue).padding(1)
                                                    }

                                                }
                                                Spacer()
                                                Text("£" + "\(service.unitsCount.wrappedValue.double * service.price.wrappedValue)")
                                                    .foregroundColor(Color.black)
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.system(size: 17, weight: .medium, design: .rounded))
                                                    .lineLimit(1)
                                            }
                                        }

                                    }.padding(5)
                                }
                                Divider().padding(.horizontal, -10).padding(.leading, 10)
                            }
                        }
                    }
                    Spacer(minLength: 100)
                }.ignoresSafeArea(.container, edges: .bottom)
            }
            VStack {
                Spacer()
                NavigationLink(destination: QuoteOverView(customer: $customer, amount: amount)) {
                    Text("Add service").withDoneButtonStyles(backColor: .accentColor, accentColor: .white)
                }

                .zIndex(1)//.opacity($tags.wrappedValue.count > 0 ? 1 : 0)
            }.padding(.bottom, 20)
        }.onAppear {
            var cust = customer
            cust.services = customer.services.map { s in
                var serv = s
                serv.unitsCount = 1
                return serv
            }
            customer = cust
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Services")
    }
}

//struct CategoriesChooserView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoriesChooserView(customer: .constant(testProvider))
//    }
//}

struct AddServicesChooserView: View {
    @Binding var customer: OrderContent
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Divider().padding(.horizontal, -10).padding(.leading, 10)

                        ForEach(getCategoriesFor(order: $customer), id: \.self) { service in
                            Section {
                                DisclosureGroup(isExpanded: service.isEditable) {
                                    VStack(spacing: 10) {
                                        Text(service.descr.wrappedValue ?? "nil")
                                            .foregroundColor(Color.secondary.opacity(0.7))
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                            .lineLimit(5)
                                            .padding(10)
                                        HStack(alignment: .center, spacing: 10) {

                                            CategoryServiceCell(count: service.unitsCount,
                                                                price: service.price.wrappedValue, serviceType: service.wrappedValue)
                                            .padding(1)

                                            Spacer()
                                            NavigationLink(destination: CategoryServiceDetailView(service: service)) {
                                                HStack {

                                                    Text("Details")
                                                        .lineLimit(1)
                                                        .font(.system(size: 20, weight: .regular, design: .default))
                                                        .foregroundColor(.infoBlue)
                                                        .frame(width: 100, height: 34)

                                                        .padding(1)
                                                        .background(
                                                            RoundedRectangle(cornerRadius: 8)
                                                                .stroke(Color.infoBlue, lineWidth: 2)
                                                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white)))
                                                        .transition(.move(edge: .leading))
                                                }
                                                .frame(width: 100, height: 35)
                                            }
                                        }.padding(.horizontal, 10)

                                    }.frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            HStack {
                                                Text(service.name.wrappedValue ?? "nil")
                                                    .foregroundColor(Color.black.opacity(0.9))
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                    .lineLimit(1)
                                                //                                            .padding(.leading, 10)
                                                Spacer()
                                            }
                                            Spacer()
                                            HStack(alignment: .bottom, spacing: 5) {
                                                VStack {
                                                    HStack {
                                                        Text("Time norm: " + (service.timeNorm.wrappedValue?.description ?? "0") + " min/room")
                                                            .foregroundColor(Color.secondary)
                                                            .multilineTextAlignment(.leading)
                                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                            .lineLimit(1)
                                                        Spacer()

                                                    }

                                                    if !service.isEditable.wrappedValue {
                                                        CategoryServiceCell(count: service.unitsCount,
                                                                            price: service.price.wrappedValue, serviceType: service.wrappedValue).padding(1)
                                                    }

                                                }
                                                Spacer()
                                                Text("£" + "\(service.unitsCount.wrappedValue.double * service.price.wrappedValue)")
                                                    .foregroundColor(Color.black)
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.system(size: 17, weight: .medium, design: .rounded))
                                                    .lineLimit(1)
                                            }
                                        }

                                    }.padding(5)
                                }
                                Divider().padding(.horizontal, -10).padding(.leading, 10)
                            }
                        }
                    }
                    Spacer(minLength: 100)
                }.ignoresSafeArea(.container, edges: .bottom)
            }
            VStack {
                Spacer()
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Add services").withDoneButtonStyles(backColor: .accentColor, accentColor: .white)
                })

                .zIndex(1)//.opacity($tags.wrappedValue.count > 0 ? 1 : 0)
            }.padding(.bottom, 20)
        }
//        .onAppear {
//            var cust = customer
//            cust.services = customer.services.map { s in
//                var serv = s
//                serv.unitsCount = 1
//                return serv
//            }
//            customer = cust
//        }
        .ignoresSafeArea(.container, edges: .bottom)
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Services")
    }
    func getCategoriesFor(order: Binding<OrderContent>) -> Binding<[CategoryService]> {
//        var services: [CategoryService] = []
        let category = qServiceID[order.services.first(where: {qServiceID[$0.wrappedValue.qserviceId] != nil})!.wrappedValue.qserviceId]
        let ServKeys = qServiceID.keys.filter({qServiceID[$0] == category})

        let services: Binding<[CategoryService]> = Binding(get: {
            return ServKeys.compactMap({
                if var s = StaticCategories[$0] {
//                    if let Os = order.services.wrappedValue.first(where: {$0.qserviceId == s.sortOrder}) {
//                        s.price = Double(Os.cost)
//                        s.unitsCount = Os.qty
//                        s.timeNorm = Os.timeNorm
                        return s
//                    } else {
//                        return nil
//                    }
                } else {
                    return nil
                }
            })
        }, set: { _ in})

//        order.services.forEach { s in
//            qServiceIDDict.keys.compactMap { qId in
//                if qId == s.qserviceId {
//                    categories.append(qServiceID[qId]!)
//                }
//            }
//        }
        return services
    }
}
