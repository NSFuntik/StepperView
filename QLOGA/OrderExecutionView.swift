//
//  OrderExecutionView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/20/22.
//

import SwiftUI
import BottomSheetSwiftUI
struct OrderExecutionView: View {
    enum FeedbackInfoBottomSheetPosition: CGFloat, CaseIterable {
        case middle = 0.3
        case hidden = 0
    }
    @Binding var actorType: ActorsEnum
    @State var RatingActorType: ActorsEnum = .CUSTOMER
    @Binding var order: OrderContent
    @State var services: [CategoryService] = []
    @Environment(\.presentationMode) var presentationMode
    @State var noGPS = false
    @State var showMap = false
    @State var CstCommunicationsRating: Int = 0
    @State var CstTimelyArrivalRating: Int = 0
    @State var CstQOSRating: Int = 0
    @State var CstFriendlynessRating: Int = 0
    @State var CstPerformanceRating: Int = 0
    @State var PrvCommunicationsRating: Int = 0
    @State var PrvTimelyArrivalRating: Int = 0
    @State var PrvQOSRating: Int = 0
    @State var PrvFriendlynessRating: Int = 0
    @State var PrvPerformanceRating: Int = 0
    @State var bottomSheetPosition: FeedbackInfoBottomSheetPosition = .hidden
    @State var infoText: String = ""
    @State var infoTitle: String = ""
    @State var publicFeedback: String = ""
    @State var privateFeedback: String = ""
    @State var showInfo = false

    var body: some View {
        VStack {
            ScrollView {
                if actorType == .PROVIDER, showMap == true {
                    PRV_MAP_VIEW
                } else {
                    VStack(alignment: .center, spacing: 15) {
                        NavigationLink {
                            RequestTrackingView()
                        } label: {
                            HStack {
                                Text(order.statusRecord.status.display)
                                    .font(.system(size: 18, weight: .regular, design: .rounded))
                                    .foregroundColor(.black).padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(order.statusRecord.status == .QUOTE || order.statusRecord.status == .INQUIRY ? .accentColor : .black)
                                    .shadow(color: Color.lightGray.opacity(0.7), radius: 0.2, x: 0.2, y: 0.2)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .light, design: .rounded))
                                    .padding(.trailing, 5)

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
                        }

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
                                        .frame(minHeight: 45)

                                    Spacer()
                                    Image("MapSymbol")
                                        .renderingMode(.template)
                                        .resizable()
                                        .scaledToFit().aspectRatio(contentMode: .fit)
                                        .foregroundColor(.accentColor)
                                        .frame(width: 20, height: 20, alignment: .center)
                                }.lineLimit(4).padding(.vertical, 10).frame(idealHeight: 40, maxHeight: 65)
                            }
                        }.padding(.horizontal, 10).padding(.bottom, 10)
                        if order.statusRecord.status != .PAID, order.statusRecord.status != .CLOSED {
                            SERVICES_LIST
                        }
                        VStack {
                            if actorType == .CUSTOMER {
                                if order.statusRecord.status == .NEEDS_FUNDING {
                                    NEEDS_FUNDING_BUTTONS
                                } else  if order.statusRecord.status == .ACCEPTED {
                                    CST_ACCEPTED_BUTTONS
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
                                } else  if order.statusRecord.status == .PAID {
                                    CST_PAID_BUTTONS
                                } else if order.statusRecord.status == .CLOSED {
                                    CST_CLOSED_BUTTONS
                                } else if order.statusRecord.status == .CLOSED_NO_REVIEW {
                                    CST_CLOSED_NO_REVIEW_BUTTONS
                                }
                            }
                            else if actorType == .PROVIDER {
                                if order.statusRecord.status == .ACCEPTED {
                                    PRV_ACCEPTED_BUTTONS
                                } else  if order.statusRecord.status == .PRV_NEAR {
                                    PRV_NEAR_BUTTONS
                                } else  if order.statusRecord.status == .ARRIVED {
                                    PRV_PRV_ARRIVED_BUTTONS
                                } else if order.statusRecord.status == .PAYMENT_IN_PROGRESS {
                                    PAYMENT_IN_PROGRESS_BUTTONS
                                } else  if order.statusRecord.status == .PAID {
                                    CST_PAID_BUTTONS
                                } else if order.statusRecord.status == .CLOSED {
                                    CST_CLOSED_BUTTONS
                                } else if order.statusRecord.status == .CLOSED_NO_REVIEW {
                                    CST_CLOSED_NO_REVIEW_BUTTONS
                                }
                            }
                        }
                        VStack {
                            Group {
                                if order.statusRecord.status == .PAID || order.statusRecord.status == .CLOSED {
                                    VStack {
                                        HStack(alignment: .center)  {

                                            NavigationLink(destination:
                                                            VStack {
                                                SERVICES_LIST.padding(.horizontal, 20).padding(.top, 10)
                                                Spacer()
                                                    .navigationTitle("Services: \(order.services.count.description)")
                                            }) {
                                                Label {
                                                    Text("Services")
                                                        .foregroundColor(Color.black)
                                                        .multilineTextAlignment(.leading)
                                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                    Spacer()
                                                    Text(order.services.count.description)
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
                                                    Image("ServicesPublicIcon")
                                                        .resizable()
                                                        .frame(width: 25,height: 25, alignment: .center).aspectRatio(contentMode: .fit).scaledToFit()
                                                        .padding(.horizontal, 5)
                                                }

                                            }                        .padding(.vertical, 10)

                                        }.frame(height: 40)
                                        Divider().background(Color.lightGray).padding(.leading, 50).padding(.trailing, -10).frame(height: 2)
                                    }
                                }

                                HStack(alignment: .center)  {

                                    NavigationLink(destination:  ProviderOverview(isButtonShows: false)) {
                                            
                                            HStack(alignment: .center) {
                                                Image("RequestDetailsIcon")
                                                    .resizable()
                                                    .frame(width: 25,height: 25, alignment: .center).aspectRatio(contentMode: .fit).scaledToFit()
                                                    .padding(.horizontal, 5)
                                                Text("\(actorType == .CUSTOMER ? "Provider" : "Customer")")
                                                    .foregroundColor(Color.black)
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                Spacer()
                                                Text(testProvider.name)
                                                    .foregroundColor(Color.lightGray)
                                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                    .lineLimit(2)
                                                    .truncationMode(.middle)
                                                    .multilineTextAlignment(.leading)
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(Color.Green)
                                                    .multilineTextAlignment(.leading)
                                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                                    .padding(.trailing, 10)
                                            }


                                    }                        .padding(.vertical, 10)

                                }.frame(minHeight: 40)
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

                                    NavigationLink(destination: ProviderPortfolioView().navigationBarTitle("Photos")) {
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
                        
                    }
                    .padding(.horizontal, 20).padding(.top, 10)
                }
                Spacer(minLength: 50)
            }.animation(.spring(), value: order.statusRecord.status).animation(.spring(), value: showMap).transition(.slide)
        }
        .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                     options: [.allowContentDrag, .tapToDissmiss, .swipeToDismiss,
                               .cornerRadius(25), .shadow(color: .lightGray, radius: 3, x: 3, y: 3),
                               .noBottomPosition, .appleScrollBehavior,
                               .dragIndicatorColor(Color.lightGray.opacity(0.5)),
                               .showCloseButton(action: { self.bottomSheetPosition = .hidden })],
                     headerContent: {
            VStack {
                HStack(alignment: .center) {
                    Spacer()
                    Text(infoTitle)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 16, weight: .medium, design: .rounded))
                    Spacer()
                }
            }.frame(height: 20)
        },
                     mainContent: {
            VStack {
                Text(infoText)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary)
                    .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                    .lineLimit(30)
            }.padding(20)
        })
        .onAppear {
            RatingActorType = actorType
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

    var PRV_ACCEPTED_BUTTONS: some View {
        HStack(alignment: .center, spacing: 10) {
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 - 20, height: 45, isShadowOn: true)
            }
            Button {
                showMap = true
            } label: {
                Text("Mark Arrived")
                    .withDoneButtonStyles(backColor: .accentColor, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 * 2 - 20, height: 45, isShadowOn: true)
            }
        }
    }
    var CST_ACCEPTED_BUTTONS: some View {
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
    var PRV_PRV_ARRIVED_BUTTONS: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 - 20, height: 45, isShadowOn: true)
                }
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Reschedule")
                        .withDoneButtonStyles(backColor: .Orange, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 3 * 2 - 20, height: 45, isShadowOn: true)

                    //                        .withDoneButtonStyles(backColor: .Orange, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
                }
            }
            Button {
                order.statusRecord.status = .COMPLETED
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    order.statusRecord.status = .PAYMENT_IN_PROGRESS
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        order.statusRecord.status = .PAID
                    }
                }
            } label: {
                Text("Complete")
                    .withDoneButtonStyles(backColor: .accentColor, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }
        }
    }

    var PRV_NEAR_BUTTONS: some View {
        HStack(alignment: .center, spacing: 10) {
            Button {
                order.statusRecord.status = .ARRIVED
            } label: {
                Text("Cancel (next)")
                    .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }
        }
    }

    var CST_PRV_NEAR_BUTTONS: some View {
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
                    .withDoneButtonStyles(backColor: .red, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }
        }
    }

    var COMPLETED_BUTTONS: some View {
        VStack {
            Button {
                order.statusRecord.status = .PAYMENT_IN_PROGRESS
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    order.statusRecord.status = .PAID
                }
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

    var PAYMENT_IN_PROGRESS_BUTTONS: some View {
        HStack(alignment: .center, spacing: 10) {
            Button {
                order.statusRecord.status = .COMPLETED
            } label: {
                Text("Dispute")
                    .withDoneButtonStyles(backColor: .Orange, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }
        }
    }

    var PRV_MAP_VIEW: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                Text("You can carry on without leaving your GPS cords. However, in this case QLOGA complaints team may not be able to assist you if the customer refuses to pay due your absence on site!")
                    .lineLimit(6)
                    .foregroundColor(.Orange)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                Button {
                    $noGPS.wrappedValue.toggle()
                } label: {
                    Image(systemName: $noGPS.wrappedValue ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(.Orange)
                        .font(.system(size: 25, weight: .light, design: .rounded))

                }
            }.frame(height: 150).padding(.horizontal, 20).padding(.bottom, -20)
            ZStack {
                GoogleMapView(providers: .constant([]), pickedAddress: $order.addr.defaultAddress).body.frame(height: UIScreen.main.bounds.height - 230, alignment: .center)
                VStack {
                    Spacer()
                    Button {

                    } label: {
                        Text("Refresh GPS")
                            .withDoneButtonStyles(backColor: .infoBlue, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
                    }
                    Button {
                        order.statusRecord.status = .PRV_NEAR
                        showMap = false
                    } label: {
                        Text("Arrived no GPS")
                            .withDoneButtonStyles(backColor:  .Orange, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
                    }
                }.frame(height: UIScreen.main.bounds.height - 250, alignment: .center).padding(.bottom, 25)
            }.padding(.bottom, 25)
            Spacer()
        }.frame(height: UIScreen.main.bounds.height - 20, alignment: .center)
    }

    var CST_PAID_BUTTONS: some View {
        VStack(alignment: .center, spacing: 15) {
            Button {
                order.statusRecord.status = .CLOSED
            } label: {
                Text("Review by Customer")
                    .withDoneButtonStyles(backColor: .accentColor, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }
            Button {
                order.statusRecord.status = .CLOSED_NO_REVIEW
            } label: {
                Text("Not review")
                    .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, height: 45, isShadowOn: true)
            }

            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("RATING")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black.opacity(0.9))
                    Spacer()
                    Button {
                        checkBottomSheetConds(text: "Your rating will not be visible until the opposite side leaves their own.", title: "RATING")
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.Orange)
                    }
                }.padding(.horizontal, 10)
                VStack {
                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Communications")
                                    .foregroundColor(Color.secondary.opacity(0.9))
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .lineLimit(1)
                                Spacer()
                                RatingPicker(rating: actorType == .CUSTOMER ? $CstCommunicationsRating : $PrvCommunicationsRating)

                            }
                        }.padding(.horizontal, 5).frame(height: 35)
                        Divider().padding(.horizontal, -10).padding(.leading, 50)
                    }
                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Timely arrival")
                                    .foregroundColor(Color.secondary.opacity(0.9))
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                Spacer()
                                RatingPicker(rating: actorType == .CUSTOMER ? $CstTimelyArrivalRating : $PrvTimelyArrivalRating)

                            }
                        }.padding(.horizontal, 5).frame(height: 35)
                        Divider().padding(.horizontal, -10).padding(.leading, 50)
                    }
                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Quality of service")
                                    .foregroundColor(Color.secondary.opacity(0.9))
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                Spacer()
                                RatingPicker(rating: actorType == .CUSTOMER ? $CstQOSRating : $PrvQOSRating)

                            }
                        }.padding(.horizontal, 5).frame(height: 35)
                        Divider().padding(.horizontal, -10).padding(.leading, 50)

                    }
                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Friendlyness")
                                    .foregroundColor(Color.secondary.opacity(0.9))
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                Spacer()
                                RatingPicker(rating: actorType == .CUSTOMER ? $CstFriendlynessRating : $PrvFriendlynessRating)
                            }
                        }.padding(.horizontal, 5).frame(height: 35)
                        Divider().padding(.horizontal, -10).padding(.leading, 50)

                    }
                    Section {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Performance & effectiveness")
                                    .foregroundColor(Color.secondary.opacity(0.9))
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                Spacer()
                                RatingPicker(rating: actorType == .CUSTOMER ? $CstPerformanceRating : $PrvPerformanceRating)
                            }
                        }.padding(.horizontal, 5).frame(height: 55)
                        Divider().background(Color.clear).padding(.horizontal, -10).padding(.leading, 50)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(10).padding(.bottom, -10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary.opacity(0.7),
                            lineWidth: 1).padding(1))
            }
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text("FEEDBACK")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black.opacity(0.9))
                    Spacer()
                    Button {
                        checkBottomSheetConds(text: "Your feedback will not be visible until the opposite side leaves their own.", title: "FEEDBACK")
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.Orange)
                    }
                }.padding(.horizontal, 10)
                VStack {
                    Section {
                        HStack {
                            TextField("Public", text: $publicFeedback, prompt:  Text("Public")
                                .foregroundColor(Color.secondary.opacity(0.9))
                                .font(Font.system(size: 17, weight: .regular, design: .rounded)))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            .foregroundColor(Color.black)
                            .lineLimit(5)
                        }
                        .padding(.horizontal, 5).frame(minHeight: 35)
                        Divider().padding(.horizontal, -10).padding(.leading, 50)
                    }
                    Section {
                        HStack {
                            TextField("Private", text: $privateFeedback, prompt:  Text("Private")
                                .foregroundColor(Color.secondary.opacity(0.9))
                                .font(Font.system(size: 17, weight: .regular, design: .rounded)))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            .foregroundColor(Color.black)
                            .lineLimit(5)

                        }
                        .padding(.horizontal, 5).frame(minHeight: 35)
                        Divider().padding(.horizontal, -10).padding(.leading, 50)
                    }
                }                            .lineLimit(5)

                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(10).padding(.bottom, -10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary.opacity(0.7),
                            lineWidth: 1).padding(1))
            }
        }
    }

    var CST_CLOSED_BUTTONS: some View {
        
        VStack(alignment: .center, spacing: 15) {
            HStack {
                Text("RATING")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary.opacity(0.9))
                Spacer()
                Button {
                    checkBottomSheetConds(text: "Your rating will not be visible until the opposite side leaves their own.", title: "RATING")
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.Orange)
                }
            }.padding(.horizontal, 10).padding(.bottom, -5)

            Picker("", selection: $RatingActorType, content: {
                Text("\(actorType == .CUSTOMER ? "Provider" : "Customer")")
                    .padding(5)
                    .tag(ActorsEnum.CUSTOMER)
                Text("Your's")
                    .padding(5)
                    .tag(ActorsEnum.PROVIDER)
            }).pickerStyle(.segmented)
            if actorType == .CUSTOMER {
                RATINGS_LIST
            }
            else {
                RATINGS_LIST
            }


                HStack {
                    Text("FEEDBACK")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary.opacity(0.9))
                    Spacer()
                    Button {
                        checkBottomSheetConds(text: "Your feedback will not be visible until the opposite side leaves their own.", title: "FEEDBACK")
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.Orange)
                    }
                }.padding([.horizontal, .top], 10)
                Picker("", selection: $RatingActorType, content: {
                    Text("\(actorType == .CUSTOMER ? "Provider's" : "Customer's")")
                        .padding(5)
                        .tag(ActorsEnum.CUSTOMER)
                    Text("Your's")
                        .padding(5)
                        .tag(ActorsEnum.PROVIDER)
                }).pickerStyle(.segmented)
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                    Text("Public")
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black.opacity(0.9))
                    Spacer()
                }
                    Section {
                        HStack {
                            Text(publicFeedback != "" ? publicFeedback : "No feedback")
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            .foregroundColor(Color.secondary)
                            .lineLimit(5)
                            Spacer()
                        }
                        .frame(minHeight: 35)
                    }
                    if privateFeedback != "" {
                        Divider().padding(.horizontal, -10).padding(.leading, 50)
                        HStack {

                            Text("Private")
                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                .foregroundColor(.black.opacity(0.9))
                            Spacer()
                        }
                        Section {
                            HStack {
                                Text(privateFeedback != "" ? privateFeedback : "No feedback")
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .foregroundColor(Color.secondary)
                                    .lineLimit(5)
                                Spacer()

                            }
                            .frame(minHeight: 35)
                        }
                    }
                }
                .padding(10).padding(.bottom, -10)


        }.animation(.spring(), value: RatingActorType).transition(.slide)
    }
    var RATINGS_LIST: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack {
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Communications")
                                .foregroundColor(Color.secondary.opacity(0.9))
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                .lineLimit(1)
                            Spacer()
                            StarsView(rating: Float(actorType == .CUSTOMER ? CstCommunicationsRating : PrvCommunicationsRating))
                            //RatingPicker(rating: actorType == .CUSTOMER ? $CstCommunicationsRating : $PrvCommunicationsRating, accentColor: .Orange).disabled(true)

                        }
                    }.padding(.horizontal, 5).frame(height: 35)
                    Divider().padding(.horizontal, -10).padding(.leading, 50)
                }
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Timely arrival")
                                .foregroundColor(Color.secondary.opacity(0.9))
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Spacer()
                            StarsView(rating: Float(actorType == .CUSTOMER ? CstTimelyArrivalRating : PrvTimelyArrivalRating))
                        }
                    }.padding(.horizontal, 5).frame(height: 35)
                    Divider().padding(.horizontal, -10).padding(.leading, 50)
                }
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Quality of service")
                                .foregroundColor(Color.secondary.opacity(0.9))
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Spacer()
                            StarsView(rating: Float(actorType == .CUSTOMER ? CstQOSRating : PrvQOSRating))
                        }
                    }.padding(.horizontal, 5).frame(height: 35)
                    Divider().padding(.horizontal, -10).padding(.leading, 50)

                }
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Friendlyness")
                                .foregroundColor(Color.secondary.opacity(0.9))
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                .multilineTextAlignment(.leading)
                                .lineLimit(1)
                            Spacer()
                            StarsView(rating: Float(RatingActorType == .CUSTOMER ? CstFriendlynessRating : PrvFriendlynessRating))
                        }
                    }.padding(.horizontal, 5).frame(height: 35)
                    Divider().padding(.horizontal, -10).padding(.leading, 50)

                }
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Performance & effectiveness")
                                .foregroundColor(Color.secondary.opacity(0.9))
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                .multilineTextAlignment(.leading)
                                .lineLimit(2)
                            Spacer()
                            StarsView(rating: Float(RatingActorType == .CUSTOMER ? CstPerformanceRating : PrvPerformanceRating))
                        }
                    }.padding(.horizontal, 5).frame(height: 50)
//                    Divider().background(Color.clear).padding(.horizontal, -10).padding(.leading, 50)
                }
            }
            .padding(10).padding(.bottom, -10)
        }
    }

    var CST_CLOSED_NO_REVIEW_BUTTONS: some View {
        VStack(alignment: .center, spacing: 15) {
            HStack {
                Text("RATING")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .foregroundColor(.black.opacity(0.9))
                Spacer()
            }.padding(.horizontal, 10).padding(.bottom, -5)

            HStack(alignment: .center) {
                Text("You have no rating from \(actorType == .CUSTOMER ? "Provider" : "Customer")")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary.opacity(0.9))
                Spacer()
            } .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(15)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary.opacity(0.7),
                            lineWidth: 1).padding(1))

            HStack {
                Text("FEEDBACK")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .foregroundColor(.black.opacity(0.9))
                Spacer()
            }.padding(.horizontal, 10).padding(.bottom, -5)

            HStack(alignment: .center) {
                Text("You have no feedback from \(actorType == .CUSTOMER ? "Provider" : "Customer")")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .foregroundColor(.secondary.opacity(0.9))
                Spacer()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(15)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary.opacity(0.7),
                        lineWidth: 1).padding(1))

        }
    }

    var SERVICES_LIST: some View {
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
                                    .lineLimit(3)
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
                    }.padding(.horizontal, 5).frame(minHeight: 35)
                    Divider().padding(.horizontal, -10).padding(.leading, 50)

                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(10).padding(.bottom, -10)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.secondary.opacity(0.7),
                    lineWidth: 1).padding(1))
    }

    func checkBottomSheetConds(text: String, title: String) {
        if text != self.infoText {
            if self.bottomSheetPosition == .middle {
                self.bottomSheetPosition = .hidden
                self.$infoText.wrappedValue = text
                self.$infoTitle.wrappedValue = title
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.bottomSheetPosition = .middle
                }
            }
            else {
                self.$infoText.wrappedValue = text
                self.$infoTitle.wrappedValue = title
                self.bottomSheetPosition = .middle
            }
        }
        else {
            self.bottomSheetPosition = self.bottomSheetPosition == .hidden ? .middle : .hidden
        }
    }





}

struct OrderExecutionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
        OrderExecutionView(actorType: .constant(.CUSTOMER), RatingActorType: .CUSTOMER, order: .constant(
            OrderContent(statusRecord:
                            OrderStatusRecord(date: "2022-03-04T01:08:35.500828Z", actor: "QLOGA", actorId: 1002, action: "CLOSE_DISPUTE_WINDOW", note: "After 7 days Order dispute opportunity window is now closed.", status: .CLOSED, display: "Visit Callout Charge requested", actionDisplay: "Close dispute period", actionPast: "QLOGA closed dispute opportunity window for the order"),
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
}

struct RatingPicker: View {
    @Binding var rating: Int
    @State var accentColor: Color = .accentColor
    var label = ""

    var maximumRating = 5

    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")




    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(accentColor)
                    .font(Font.system(size: 20, weight: number > rating ? .light : .semibold, design: .rounded))
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}
