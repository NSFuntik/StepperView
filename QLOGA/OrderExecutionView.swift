//
//  OrderExecutionView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/20/22.
//

import SwiftUI

struct OrderExecutionView: View {
    @Binding var actorType: ActorsEnum
    @Binding var order: OrderContent
    @State var services: [CategoryService] = []
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 15) {
                HStack {
                    Text(order.statusRecord.status.display)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(.black).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                    Spacer()
//                    Image(systemName: "chevron.right")
//                        .foregroundColor(order.statusRecord.status == .QUOTE || order.statusRecord.status == .INQUIRY ? .accentColor : .white)
//                        .multilineTextAlignment(.leading)
//                        .font(Font.system(size: 20, weight: .semibold, design: .rounded))
//                        .padding(.trailing, 15)
//                        .padding(.top, 10)
                }.padding(.vertical, 5).padding(10)
                    .background(
                    LinearGradient(gradient: Gradient(colors: [Color(hex: order.statusRecord.status.colors[0])!,

                                                               Color(hex: order.statusRecord.status.colors[1])!]),
                                   startPoint: .leading, endPoint: .trailing))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
                .padding(1)

                .frame(height: 45)
                VStack {

                    HStack {
                        Text("\(getString(from: order.serviceDate, "YYYY/MM/DD HH:mm"))")
                            .font(.system(size: 17, weight: .regular, design: .rounded))
                            .foregroundColor(.black)
                        Spacer()
                        Text(poundsFormatter.string(from: order.amount as NSNumber)!)//order.services.map({$0.qty * $0.cost}).reduce(0, +) as NSNumber)!)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                    }
                    NavigationLink(destination: GoogleMapView(providers: .constant([]), pickedAddress: $order.addr.defaultAddress)) {
                        HStack(alignment: .center, spacing: 5) {
                            Text(order.addr.total ?? "" + "\n")
                                .lineLimit(4)
                                .foregroundColor(Color.secondary.opacity(0.8))
                                .font(Font.system(size: 17,
                                                  weight: .regular,
                                                  design: .rounded))
                                .multilineTextAlignment(.leading)
                                .frame(idealHeight: 45, maxHeight: 65)
                            Spacer()
                            Image("MapSymbol")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit().aspectRatio(contentMode: .fit)
                                .foregroundColor(.accentColor)
                                .frame(width: 20, height: 20, alignment: .center)
                        }.lineLimit(4).padding(.vertical, 10).frame(idealHeight: 40, maxHeight: 65)
                    }
                }.padding(.horizontal, 10)
                VStack {
                    ForEach($services)
                    { service in
                        Section {
                            NavigationLink(destination: CategoryServiceDetailView(service: service)) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(service.wrappedValue.name ?? "nil")
                                            .foregroundColor(Color.black.opacity(0.9))
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            .lineLimit(1)
                                        Spacer()
                                        Text(poundsFormatter.string(from: service.wrappedValue.price as NSNumber)!)
                                            .foregroundColor(Color.lightGray.opacity(0.9))
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 17, weight: .regular, design: .default))
                                            .foregroundColor(Color.lightGray.opacity(0.9))
                                            .multilineTextAlignment(.trailing)
                                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            .lineLimit(1)
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(Color.Green)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                            .padding(.leading, 5)
                                    }

                                }
                            }.padding(.horizontal, 5).frame(height: 35)
                                Divider().padding(.horizontal, -10).padding(.leading, 50)

                        }
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(10).padding(.bottom, -10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary.opacity(0.7),
                                lineWidth: 1).padding(1))
                    VStack {
                        if order.statusRecord.status == .NEEDS_FUNDING {
                            NEEDS_FUNDING_BUTTONS
                        } else  if order.statusRecord.status == .ACCEPTED {
                            ACCEPTED_BUTTONS
                        } else  if order.statusRecord.status == .PRV_NEAR {
                            PRV_NEAR_BUTTONS
                        } else  if order.statusRecord.status == .ARRIVED {
                            ARRIVED_BUTTONS
                        } else  if order.statusRecord.status == .PRV_NEAR {
                            PRV_NEAR_BUTTONS
                        } else  if order.statusRecord.status == .ARRIVED {
                            ARRIVED_BUTTONS
                        } else  if order.statusRecord.status == .COMPLETED {
                            COMPLETED_BUTTONS
                        }
                    }
                VStack {
                    Group {
                        HStack(alignment: .center)  {

                        NavigationLink(destination: ProviderOverview(isButtonShows: false)) {
                            Label {
                                Text("Provider")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Spacer()
                                Text(testProvider.name)
                                    .foregroundColor(Color.lightGray)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .lineLimit(1)
                                    .truncationMode(.middle)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.Green)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                    .padding(.trailing, 10)
                            } icon: {
                                Image("RequestDetailsIcon")
                                    .resizable()
                                    .frame(width: 25,height: 25, alignment: .center).aspectRatio(contentMode: .fit).scaledToFit()
                                    .padding(.horizontal, 5)
                            }

                        }                        .padding(.vertical, 10)

                        }.frame(height: 40)
                        Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -10).frame(height: 2)

                        HStack(alignment: .center)  {

                        NavigationLink(destination: VisitsView()) {
                            HStack(alignment: .center) {
                                Label {
                                    Text("Visits")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("5")
                                        .foregroundColor(Color.lightGray)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.Green)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.trailing, 10)
                                } icon: {
                                    Image("RequestVisitsIcon")
                                        .resizable()
                                        .frame(width: 25,height: 25, alignment: .center).aspectRatio(contentMode: .fit).scaledToFit()
                                        .foregroundColor(Color.Green)
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                        }.frame(height: 40)
                        Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -10).frame(height: 2)

                        HStack(alignment: .center)  {

                        NavigationLink(destination: ProviderPortfolioView()) {
                            Label {
                                Text("Photos")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Spacer()
                                Text("6")
                                    .foregroundColor(Color.lightGray)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.Green)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                    .padding(.trailing, 10)
                            } icon: {
                                Image("PortfolioIcon")
                                    .resizable().aspectRatio(contentMode: .fit).scaledToFit()
                                    .frame(width: 25,height: 25, alignment: .center).aspectRatio(contentMode: .fit).scaledToFit()
                                    .padding(.horizontal, 5)
                            }
                        }
                    }.frame(height: 40)
                        Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -10).frame(height: 2)

                        HStack(alignment: .center)  {
                            NavigationLink(destination: NotesView(actorType: $actorType)) {
                                Label {
                                    Text("Notes")
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


                                } icon: {
                                    Image("RequestNotesIcon")
                                        .resizable().aspectRatio(contentMode: .fit)
                                        .scaledToFit()
                                        .frame(width: 25,height: 25, alignment: .center).aspectRatio(contentMode: .fit).scaledToFit()
                                        .padding(.horizontal, 5)

                                }


                            }
                        }.frame(height: 40)
                        Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -10).frame(height: 2)
                        HStack(alignment: .center)  {
                        NavigationLink(destination: PaymentsView(actorType: $actorType, order: $order)) {
                            Label {
                                Text("Payments")
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
                            } icon: {
                                Image("PoundIcon")
                                    .resizable().aspectRatio(contentMode: .fit)
                                    .frame(width: 25,height: 25, alignment: .center).aspectRatio(contentMode: .fit).scaledToFit()
                                    .padding(.horizontal, 5)
                            }

                        }
                        .padding(.vertical, 10)
                    }.frame(height: 40)
                    }
                }.padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1.0)
                        .foregroundColor(Color.lightGray))
            }.padding(.horizontal, 20).padding(.top, 10)
        }.animation(.spring(), value: order.statusRecord.status ).transition(.slide)
        .onAppear {
            services = $order.services.map({
                var s = StaticCategories[$0.qserviceId.wrappedValue]!
                s.unitsCount = $0.wrappedValue.qty
                s.price = Double($0.wrappedValue.cost)
                return s
            })
        }
        .navigationTitle("Order #\(order.id.description)")
    }


    var NEEDS_FUNDING_BUTTONS: some View {
        HStack(alignment: .center, spacing: 10) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 - 20, height: 45, isShadowOn: true)
            }
            Button {
                order.statusRecord.status = .ACCEPTED
            } label: {
                Text("Reserve funds")
                    .withDoneButtonStyles(backColor: .accentColor, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 * 2 - 20, height: 45, isShadowOn: true)
            }
        }
    }

    var ACCEPTED_BUTTONS: some View {
        VStack {
            Button {
                order.statusRecord.status = .PRV_NEAR
            } label: {
                Text("Reschedule (next)")
                    .withDoneButtonStyles(backColor: .Orange, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }
            HStack(alignment: .center, spacing: 10) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 - 20, height: 45, isShadowOn: true)
                }
                Button {
                    order.statusRecord.status = .CANCELLED
                } label: {
                    Text("Provider not arrived")
                        .withDoneButtonStyles(backColor: .red, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 * 2 - 20, height: 45, isShadowOn: true)
                }
            }
        }
    }

    var PRV_NEAR_BUTTONS: some View {
        HStack(alignment: .center, spacing: 10) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 - 20, height: 45, isShadowOn: true)
            }
            Button {
                order.statusRecord.status = .ARRIVED
            } label: {
                Text("Confirm Arrival")
                    .withDoneButtonStyles(backColor: .accentColor, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 * 2 - 20, height: 45, isShadowOn: true)
            }
        }
    }

    var ARRIVED_BUTTONS: some View {
        HStack(alignment: .center, spacing: 10) {
            Button {
                order.statusRecord.status = .COMPLETED
            } label: {
                Text("Cancel (next)")
                    .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }
        }
    }

    var COMPLETED_BUTTONS: some View {
        VStack {
            Button {
                order.statusRecord.status = .PAYMENT_IN_PROGRESS
            } label: {
                Text("Approve")
                    .withDoneButtonStyles(backColor: .accentColor, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }
            HStack(alignment: .center, spacing: 10) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 - 20, height: 45, isShadowOn: true)
                }
                Button {
                    order.statusRecord.status = .UNSATISFIED
                } label: {
                    Text("Unsatisfaied")
                        .withDoneButtonStyles(backColor: .red, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 * 2 - 20, height: 45, isShadowOn: true)
                }
            }
        }
    }












}

struct OrderExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        OrderExecutionView(actorType: .constant(.CUSTOMER), order: .constant(
                    OrderContent(statusRecord:
                                    OrderStatusRecord(date: "2022-03-04T01:08:35.500828Z", actor: "QLOGA", actorId: 1002, action: "CLOSE_DISPUTE_WINDOW", note: "After 7 days Order dispute opportunity window is now closed.", status: .NEEDS_FUNDING, display: "Visit Callout Charge requested", actionDisplay: "Close dispute period", actionPast: "QLOGA closed dispute opportunity window for the order"),
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
                                 cancelHrs: nil, cstPerson: OrderCstPerson(verifications: [], settings: OrderSettings(), payMethods: []), dayPlans: [], cstActions: [], prvActions: [], payments: [], assigns: [])))
    }
}
