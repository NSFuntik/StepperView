//
//  OrderDetailView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/20/22.
//

import SwiftUI

enum OrderType: String, CaseIterable, Identifiable, Codable {
    case Order
    case Quote
    case Inquiry
    var id: String { self.rawValue }
}

struct OrderDetailView: View {
    @Binding var actorType: ActorsEnum
    var totalSum: Double {
        get {
            return Double(order.services.map({$0.qty * Int($0.cost)}).reduce(0, +))
        }
        set {
            self.totalSum = newValue
        }
    }
    @State var orderType: OrderType
    @Binding var order: OrderContent
    @State var isChargeOn = false
    @State var calloutCharge = 0.0
    @State var cancellation = 0
    @State var showAlert = false
    @State var isPicked = false
    @State var isExist = false
    @State var services: [CategoryService] = []
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    VStack {
                        ForEach($services)
                        { service in
                            Section {
                                NavigationLink(destination: CategoryServiceDetailView(service: service)) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(service.name.wrappedValue ?? "nil")
                                                .foregroundColor(Color.black.opacity(0.9))
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                .lineLimit(1)
                                            Spacer()
                                            Text(service.unitsCount.wrappedValue.description)
                                                .foregroundColor(Color.lightGray.opacity(0.9))
                                                .multilineTextAlignment(.trailing)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                .lineLimit(1)
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color.Green)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                                .padding(.horizontal, 10)
                                        }
                                    }
                                }.padding(.horizontal, 5).frame(height: 40)
                                Divider().padding(.horizontal, -10).padding(.leading, 50)
                            }
                        }
                    }
                    .padding(10).padding(.bottom, -10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary
                            .opacity(0.7), lineWidth: 1).padding(1)).padding(.horizontal, 20).padding(.top, 10)
                    VStack(alignment: .center) {
                        NavigationLink(destination: AddServicesChooserView(customer: $order)) {
                            HStack {
                                Text("Add services")
                                    .lineLimit(1)
                                    .ignoresSafeArea(.all)
                                    .font(.system(size: 20, weight: .regular, design: .default))
                                    .foregroundColor(.Green)
                                    .frame(width: UIScreen.main.bounds.width - 42, height: 50)
                                    .background(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.Green, lineWidth: 4)
                                            .clipShape(RoundedRectangle(cornerRadius: 25))
                                            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white)))
                            }
                        }.padding(.bottom, 10)

                        VStack(alignment: .center, spacing: 20) {
                            HStack(alignment: .center) {
                                Text("Total sum:")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 19, weight: .regular, design: .default))
                                Spacer()
                                if isExist {
                                    Text(poundsFormatter.string(from: order.amount as NSNumber)!)
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 19, weight: .bold, design: .default))

                                } else {
                                    VStack(alignment: .trailing) {
                                        TextField("Total price:", value: $order.amount, formatter: poundsFormatter, prompt: Text(isExist ? "£\( String(order.services.map({$0.qty * Int($0.cost * 100)}).reduce(0, +) * 100)).00" : (poundsFormatter.string(from: order.amount * 100 as NSNumber)!)))
                                            .font(Font.system(size: 17,
                                                              weight: .semibold,
                                                              design: .rounded))
                                            .foregroundColor(Color.black)
                                            .keyboardType(.decimalPad)
                                            .gesture(DragGesture()
                                                .onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
                                            .toolbar{
                                                ToolbarItem(placement: .keyboard, content: {
                                                    Button(role: ButtonRole.destructive) {
                                                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                    } label: {
                                                        Text("Done")
                                                    }})
                                            }
                                            .multilineTextAlignment(.trailing)
                                    }
                                }
                            }
                            VStack {
                                Group {
                                    HStack(alignment: .center) {
                                        Text("Callout charge:")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .default))
                                        Spacer()
                                        Toggle(isOn: $order.callout) {
                                            TextField("Callout charge:", value: $order.calloutAmount, formatter: poundsFormatter, prompt: Text("£0.00"))
                                                .font(Font.system(size: 17,
                                                                  weight: .semibold,
                                                                  design: .rounded))
                                                .foregroundColor( order.callout ? Color.black : .lightGray)
                                                .keyboardType(.decimalPad)
                                                .gesture(DragGesture()
                                                    .onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
                                                .toolbar{
                                                    ToolbarItem(placement: .keyboard, content: {
                                                        Button(role: ButtonRole.destructive) {
                                                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                        } label: {
                                                            Text("Done")
                                                        }})
                                                }.disabled(!order.callout)
                                                .multilineTextAlignment(.trailing)
                                        }
                                    }.frame(height: 40)
                                    Divider().padding(.horizontal, -10).padding(.leading, 50)

                                    Section {
                                        DisclosureGroup {
                                            Picker("Cancellation period", selection: $order.cancelHrs) {
                                                ForEach(0 ..< 72) {
                                                    if   $0 > 0 { Text("\($0) hrs") }
                                                }
                                            }.pickerStyle(.wheel)
                                        } label: {
                                            HStack {
                                                Text("Cancellation period")
                                                    .foregroundColor(Color.black)
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                Spacer()
                                                Text(String(order.cancelHrs ?? 0) + " hrs")
                                                    .lineLimit(2)
                                                    .foregroundColor(Color.secondary)
                                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            }.frame(height: 40)
                                        }
                                    }
                                }.padding(.horizontal, 5)
                            }
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(Color.lightGray))
                            VStack {
                                Group {
                                    NavigationLink(destination: AddressPickerView(pickedAddress: $order.addr)) {
                                        HStack(alignment: .center) {
                                            Text("Address")
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            Spacer()
                                            Text(order.addr.total!)
                                                .foregroundColor(Color.lightGray).lineLimit(1)
                                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color.Green)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                                .padding(.trailing, 10)
                                        }
                                    }.padding(.top, 15)
                                    Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -15)

                                    NavigationLink(destination: CalendarPickerView().navigationBarTitle("Date & Time").ignoresSafeArea(.all, edges: .bottom)) {
                                        HStack(alignment: .center) {
                                            Text("Date & Time")
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            Spacer()
                                            Text(getString(from: Date(), "dd/MM/yy HH:MM"))
                                                .foregroundColor(Color.lightGray)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color.Green)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                                .padding(.trailing, 10)
                                        }
                                    }
                                    Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -15)

                                    NavigationLink(destination: VisitsScedulerView()) {
                                        HStack(alignment: .center) {
                                            Text("Visits")
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            Spacer()
                                            Text("1")
                                                .foregroundColor(Color.lightGray)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color.Green)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                                .padding(.trailing, 10)
                                        }
                                    }
                                    Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -15)

                                    NavigationLink(destination: RequestTrackingView()) {
                                        HStack(alignment: .center) {
                                            Text("Tracking")
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            Spacer()
                                            Text(order.statusRecord.status.display)
                                                .foregroundColor(Color(hex: order.statusRecord.status.colors[1]))
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                .multilineTextAlignment(.leading)
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color.Green)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                                .padding(.trailing, 10)
                                        }
                                    }
                                    Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -15)

                                    NavigationLink(destination: ProfilePublicView(actorType: actorType, customer: .constant(testCustomer), provider: .constant(testProvider))) {
                                        HStack(alignment: .center) {
                                            Text("Customer details")
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color.Green)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                                .padding(.trailing, 10)
                                        }
                                    }.padding(.bottom, 15)
                                }.padding(5)
                            }.padding(.horizontal, 10)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 1.0)
                                    .foregroundColor(Color.lightGray))
                        }
                    }.padding(.horizontal, 20).padding(.top, 10)
                    Spacer(minLength: 120)
                }
            }
            VStack {
                Spacer()
                if orderType == .Order {
                    Button(action : {
                        dismiss()
                    }) {
                        Text("Cancel").withDoneButtonStyles(backColor: .red, accentColor: .white, isShadowOn: true)
                    }
                } else if orderType == .Inquiry {
                    Button(action : {
                        if actorType == .CUSTOMER {
                            if var prvQuote = OrdersCotroller.shared.PrvInquires.first(where: {$0.id == order.id}) {
                                prvQuote.statusRecord.status = .ACCEPTED
                                OrdersCotroller.shared.PrvInquires = OrdersCotroller.shared.PrvInquires.filter({$0.id != prvQuote.id})
                                OrdersCotroller.shared.PrvOrders.append(prvQuote)
                                OrdersCotroller.shared.CstInquires = OrdersCotroller.shared.CstInquires.filter({$0.id != prvQuote.id})
                                order.statusRecord.status = .NEEDS_FUNDING
                                OrdersCotroller.shared.CstOrders.append(order)
                            }
                        }
                        if actorType == .PROVIDER {
                            if var cstQuote = OrdersCotroller.shared.CstInquires.first(where: {$0.id == order.id}) {
                                cstQuote.statusRecord.status = .NEEDS_FUNDING
                                OrdersCotroller.shared.CstInquires = OrdersCotroller.shared.CstInquires.filter({$0.id != cstQuote.id})
                                OrdersCotroller.shared.CstOrders.append(cstQuote)
                                OrdersCotroller.shared.PrvInquires = OrdersCotroller.shared.PrvInquires.filter({$0.id != cstQuote.id})
                                order.statusRecord.status = .ACCEPTED
                                OrdersCotroller.shared.PrvOrders.append(order)
                            }
                        }
                        dismiss()
                    }) {
                        Text("Accept").withDoneButtonStyles(backColor: .green, accentColor: .white, height: 45, isShadowOn: true)
                    }
                    HStack(alignment: .center, spacing: 15) {
                        Button(action : {
                            if actorType == .CUSTOMER {
                                if var prvQuote = OrdersCotroller.shared.PrvInquires.first(where: {$0.id == order.id}) {
                                    prvQuote.statusRecord.status = .CST_DECLINED
                                    OrdersCotroller.shared.PrvInquires = OrdersCotroller.shared.PrvInquires.filter({$0.id != prvQuote.id})
                                    OrdersCotroller.shared.PrvInquires.append(prvQuote)
                                    OrdersCotroller.shared.CstInquires = OrdersCotroller.shared.CstInquires.filter({$0.id != prvQuote.id})
                                    order.statusRecord.status = .CANCELLED
                                    OrdersCotroller.shared.CstInquires.append(order)
                                }
                            }
                            if actorType == .PROVIDER {
                                if var cstQuote = OrdersCotroller.shared.CstInquires.first(where: {$0.id == order.id}) {
                                    cstQuote.statusRecord.status = .PRV_DECLINED
                                    OrdersCotroller.shared.CstInquires = OrdersCotroller.shared.CstInquires.filter({$0.id != cstQuote.id})
                                    OrdersCotroller.shared.CstInquires.append(cstQuote)
                                    OrdersCotroller.shared.PrvInquires = OrdersCotroller.shared.PrvInquires.filter({$0.id != cstQuote.id})
                                    order.statusRecord.status = .CANCELLED
                                    OrdersCotroller.shared.PrvInquires.append(order)
                                }
                            }
                            dismiss()
                        }) {
                            Text("Cancel").withDoneButtonStyles(backColor: .red, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 4, height: 45, isShadowOn: true)
                        }
                        Button(action : {
                            if actorType == .CUSTOMER {
                                if var prvQuote = OrdersCotroller.shared.PrvInquires.first(where: {$0.id == order.id}) {
                                    prvQuote.statusRecord.status = .QUOTE
                                    OrdersCotroller.shared.PrvInquires = OrdersCotroller.shared.PrvInquires.filter({$0.id != prvQuote.id})
                                    OrdersCotroller.shared.PrvQuotes.append(prvQuote)
                                    OrdersCotroller.shared.CstInquires = OrdersCotroller.shared.CstInquires.filter({$0.id != prvQuote.id})
                                    order.statusRecord.status = .QUOTE
                                    OrdersCotroller.shared.CstQuotes.append(order)
                                }
                            }
                            if actorType == .PROVIDER {
                                if var prvQuote = OrdersCotroller.shared.CstInquires.first(where: {$0.id == order.id}) {
                                    prvQuote.statusRecord.status = .QUOTE
                                    OrdersCotroller.shared.CstInquires = OrdersCotroller.shared.CstInquires.filter({$0.id != prvQuote.id})
                                    OrdersCotroller.shared.CstQuotes.append(prvQuote)
                                    OrdersCotroller.shared.PrvInquires = OrdersCotroller.shared.PrvInquires.filter({$0.id != prvQuote.id})
                                    order.statusRecord.status = .QUOTE
                                    OrdersCotroller.shared.PrvQuotes.append(order)
                                }
                            }
                            dismiss()
                        }) {
                            Text("Update").withDoneButtonStyles(backColor: .green, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 4 * 2.5, height: 45, isShadowOn: true)
                        }
                    }
                } else if orderType == .Quote {
                    Button(action : {
                        if actorType == .CUSTOMER {
                            if var prvQuote = OrdersCotroller.shared.PrvQuotes.first(where: {$0.id == order.id}) {
                                prvQuote.statusRecord.status = .ACCEPTED
                                OrdersCotroller.shared.PrvQuotes = OrdersCotroller.shared.PrvQuotes.filter({$0.id != prvQuote.id})
                                OrdersCotroller.shared.PrvOrders.append(prvQuote)
                                OrdersCotroller.shared.CstQuotes = OrdersCotroller.shared.CstQuotes.filter({$0.id != prvQuote.id})
                                order.statusRecord.status = .NEEDS_FUNDING
                                OrdersCotroller.shared.CstOrders.append(order)
                            }
                        }
                        if actorType == .PROVIDER {
                            if var cstQuote = OrdersCotroller.shared.CstQuotes.first(where: {$0.id == order.id}) {
                                cstQuote.statusRecord.status = .NEEDS_FUNDING
                                OrdersCotroller.shared.CstQuotes = OrdersCotroller.shared.CstQuotes.filter({$0.id != cstQuote.id})
                                OrdersCotroller.shared.CstOrders.append(cstQuote)
                                OrdersCotroller.shared.PrvQuotes = OrdersCotroller.shared.PrvQuotes.filter({$0.id != cstQuote.id})
                                order.statusRecord.status = .ACCEPTED
                                OrdersCotroller.shared.PrvOrders.append(order)
                            }
                        }
                        dismiss()
                    }) {
                        Text("Accept").withDoneButtonStyles(backColor: .green, accentColor: .white, height: 45, isShadowOn: true)
                    }
                    HStack(alignment: .center, spacing: 15) {
                        Button(action : {
                            if actorType == .CUSTOMER {
                                if var prvQuote = OrdersCotroller.shared.PrvQuotes.first(where: {$0.id == order.id}) {
                                    prvQuote.statusRecord.status = .CST_DECLINED
                                    OrdersCotroller.shared.PrvQuotes = OrdersCotroller.shared.PrvQuotes.filter({$0.id != prvQuote.id})
                                    OrdersCotroller.shared.PrvQuotes.append(prvQuote)
                                    OrdersCotroller.shared.CstQuotes = OrdersCotroller.shared.CstQuotes.filter({$0.id != prvQuote.id})
                                    order.statusRecord.status = .CANCELLED
                                    OrdersCotroller.shared.CstQuotes.append(order)
                                }
                            }
                            if actorType == .PROVIDER {
                                if var cstQuote = OrdersCotroller.shared.CstQuotes.first(where: {$0.id == order.id}) {
                                    cstQuote.statusRecord.status = .PRV_DECLINED
                                    OrdersCotroller.shared.CstQuotes = OrdersCotroller.shared.CstQuotes.filter({$0.id != cstQuote.id})
                                    OrdersCotroller.shared.CstQuotes.append(cstQuote)
                                    OrdersCotroller.shared.PrvQuotes = OrdersCotroller.shared.PrvQuotes.filter({$0.id != cstQuote.id})
                                    order.statusRecord.status = .CANCELLED
                                    OrdersCotroller.shared.PrvQuotes.append(order)
                                }
                            }
                            dismiss()
                        }) {
                            Text("Cancel").withDoneButtonStyles(backColor: .red, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 4, height: 45, isShadowOn: true)
                        }
                        Button(action : {
                            if actorType == .CUSTOMER {
                                if var prvQuote = OrdersCotroller.shared.PrvQuotes.first(where: {$0.id == order.id}) {
                                    prvQuote.statusRecord.status = .INQUIRY
                                    OrdersCotroller.shared.PrvQuotes = OrdersCotroller.shared.PrvQuotes.filter({$0.id != prvQuote.id})
                                    OrdersCotroller.shared.PrvInquires.append(prvQuote)
                                    OrdersCotroller.shared.CstQuotes = OrdersCotroller.shared.CstQuotes.filter({$0.id != prvQuote.id})
                                    order.statusRecord.status = .INQUIRY
                                    OrdersCotroller.shared.CstInquires.append(order)
                                }
                            }
                            if actorType == .PROVIDER {
                                if var prvQuote = OrdersCotroller.shared.CstQuotes.first(where: {$0.id == order.id}) {
                                    prvQuote.statusRecord.status = .INQUIRY
                                    OrdersCotroller.shared.CstQuotes = OrdersCotroller.shared.CstQuotes.filter({$0.id != prvQuote.id})
                                    OrdersCotroller.shared.CstInquires.append(prvQuote)
                                    OrdersCotroller.shared.PrvQuotes = OrdersCotroller.shared.PrvQuotes.filter({$0.id != prvQuote.id})
                                    order.statusRecord.status = .INQUIRY
                                    OrdersCotroller.shared.PrvInquires.append(order)
                                }
                            }
                            dismiss()
                        }) {
                            Text("Update").withDoneButtonStyles(backColor: .green, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 4 * 2.5, height: 45, isShadowOn: true)
                        }
                    }
                }

            }.padding(.bottom, 17.5)
                .zIndex(1)
        }
        .onAppear {
            services = $order.services.map({
                var s = StaticCategories[$0.qserviceId.wrappedValue]!
                s.unitsCount = $0.wrappedValue.qty
                s.price = Double($0.wrappedValue.cost)
                return s
            })
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(orderType.rawValue) #\(order.id.description)")
    }
}
