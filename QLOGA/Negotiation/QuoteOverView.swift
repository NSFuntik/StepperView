//
//  QuoteOverView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/15/22.
//

import SwiftUI

struct QuoteOverView: View {
    @Binding var customer: Customer
    var totalSum: Double {
        get {
            return Double(customer.services.map({$0.unitsCount * Int($0.price)}).reduce(0, +))
        }
        set {
            totalSum = newValue
        }
    }
    @State var amount: Double
    @State var isChargeOn = false
    @State var calloutCharge = 0.0
    @State var cancellation = 0
    @State var showAlert = false
    @State var actorType: ActorsEnum = .PROVIDER
    @State var isPicked = false
    @State var isExist = false
    @State var services: [CategoryService] = []
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    VStack {
                        ForEach($customer.services)//$categories.flatMap({$0.}).sorted(by: {$0.id.wrappedValue < $1.id.wrappedValue}))
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
                                            //                                            .padding(.leading, 10)
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
                        Button(action : {
                            dismiss()
                        }) {
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
                                    Text(poundsFormatter.string(from: customer.services.map({$0.unitsCount * Int($0.price)}).reduce(0, +) as NSNumber)!)
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 19, weight: .bold, design: .default))

                                } else {

                                    VStack(alignment: .trailing) {
                                        TextField("Total price:", value: $amount, formatter: poundsFormatter, prompt: Text(isExist ? "£\( String(customer.services.map({$0.unitsCount * Int($0.price * 100)}).reduce(0, +) * 100)).00" : (poundsFormatter.string(from: Int(customer.address.building)! * 100 as NSNumber)!)))
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
                                        Toggle(isOn: $isChargeOn) {
                                            TextField("Callout charge:", value: $calloutCharge, formatter: poundsFormatter, prompt: Text("£0.00"))
                                                .font(Font.system(size: 17,
                                                                  weight: .semibold,
                                                                  design: .rounded))
                                                .foregroundColor( isChargeOn ? Color.black : .lightGray)
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
                                                }.disabled(!isChargeOn)
                                                .multilineTextAlignment(.trailing)
                                        }
                                    }.frame(height: 40)
                                    Divider().padding(.horizontal, -10).padding(.leading, 50)

                                    Section {
                                        DisclosureGroup {
                                            Picker("Cancellation period", selection: $cancellation) {
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
                                                Text("\(cancellation) hrs")
                                                    .lineLimit(2)
                                                    .foregroundColor(Color.secondary)
                                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            }
                                            .frame(height: 40)
                                        }
                                    }
                                }.padding(.horizontal, 5)
                            }.padding(10)
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 1.0)
                                    .foregroundColor(Color.lightGray))

                        VStack {
                            Group {
                                NavigationLink(destination: AddressPickerView(pickedAddress: $customer.address.defaultAddress)) {
                                    HStack(alignment: .center) {
                                        Text("Address")
                                            .foregroundColor(Color.black)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text(customer.address.total)
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
                                        Text("")
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

                                NavigationLink(destination: ProfilePublicView(actorType: .CUSTOMER, customer: $customer, provider: .constant(testProvider))) {
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
                    Spacer(minLength: 100)
                }

            }
            VStack {
                Spacer()
                Button(action : {
                    Orders.append(OrderContent(statusRecord: OrderStatusRecord(date: getString(from: Date()), actor: actorType.rawValue, actorId: 0, action: "VISIT_ADDED", note: "", status: "VISIT_ADDED", display: "VISIT_ADDED", actionDisplay: "VISIT_ADDED", actionPast: "VISIT_ADDED"), id: Int.random(in: 200...5000), addr: customer.address.defaultAddress,
                                               amount: amount == 0.0 ? Int(customer.services.map({$0.unitsCount * Int($0.price)}).reduce(0, +) * 100) * 100 : Int(amount), callout: isChargeOn, serviceDate: Date(), services: customer.services.map({ s in
                        return OrderService(id: s.avatarID ?? Int.random(in: 200...5000), conditions: [0], qty: s.unitsCount, cost: Int(s.price), timeNorm: s.timeNorm ?? 30, qserviceId: s.id)
                    }), provider: OrderProvider(id: 1002, calloutCharge: false, services: [], resourceIds: [], favs: [], ratings: [], portfolio: []), providerOrg: OrderProviderOrg(name: "Kai\'s Elderly care business (London)", offTime: [], workingHours: [], verifications: [], settings: QLOGA.OrderSettings()), cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []), dayPlans: [], cstActions: [], prvActions: [], payments: [], assigns: []))
                    isPicked = true
                }) {
                    Text("Send Quote").withDoneButtonStyles(backColor: .accentColor, accentColor: .white)
                }

                .zIndex(1)//.opacity($tags.wrappedValue.count > 0 ? 1 : 0)
            }.padding(.bottom, 20)
        }
        .onAppear {
            if !services.isEmpty {
                customer.services = services
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Quote overview")
        .navigationBarBackButtonHidden(!isExist)
        .navigationBarItems(leading: Button(action : {
            showAlert = true
        }){
            if !isExist {

                HStack {
                    Image(systemName: "chevron.left").foregroundColor(.accentColor)
                        .aspectRatio(contentMode: .fit)
                    Text("Revert").bold().foregroundColor(.red)
                }
            }
        })
        .alert("You have chosen to return to the list of services - in this case, the provider you have chosen and its services will not be saved! Are you sure?", isPresented: $showAlert) {
            Button("Decline", role: .cancel) { showAlert = false}

            Button("Allow", role: .destructive) {

                isPicked = true
            }

        }
        .fullScreenCover(isPresented: $isPicked, content: {
            ProfileHomeTabBarView(actorType: $actorType, tabController: TabController.shared)
        })
    }
}

//struct QuoteOverView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuoteOverView()
//    }
//}
