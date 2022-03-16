//
//  AddressVerifyView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import BottomSheetSwiftUI

enum AddressesBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 0.5, hidden = 0.0
}
struct AddressVerifyView: View {
    @State var actorType: ActorsEnum
    @State var bottomSheetPosition: AddressesBottomSheetPosition = .hidden
    @FocusState var isApartmentsEditing: Bool
    @FocusState var isBuildingEditing: Bool
    @FocusState var isStreetEditing: Bool
    @FocusState var isCityEditing: Bool
    @FocusState var isPostcodeEditing: Bool

    @State var showAddresses = false
    @State var showMap = false
    @State var address: String = ""
    @State var pickedAddress: Address = Address(postcode: "", town: "", street: "", building: "", apt: "")

    var body: some View {
        
        VStack(alignment: .center) {
            ZStack {
                HStack {
                    Spacer()
                    DottedLine()
                        .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                        .shadow(radius: 0.5)
                        .foregroundColor(Color.lightGray)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 0.5, alignment: .leading)
                .ignoresSafeArea(.all, edges: .trailing)

                Image("VerifyStep")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30, alignment: .center)
            }.frame(height: 50, alignment: .center)

            HStack {
                Text("Your address is required to proceed with the order.")
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 19, weight: .regular, design: .rounded))
                    .padding(10)
                Spacer()
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
            }

            VStack {
                HStack(alignment: .center, spacing: 15) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.orange.opacity(0.5))
                        TextField("", text: self.$address)
                            .placeholder(when:  $address.wrappedValue.count < 1) {
                                HStack(alignment: .center) {
                                    Text("  Please enter your address here")
                                        .font(.system(size: 17, weight: .regular, design: .rounded))
                                        .lineLimit(1)
                                        .foregroundColor(.orange.opacity(0.5))
                                    Spacer()
                                }
                            }
                        Spacer()
                    }
                    .foregroundColor(Color(UIColor.secondaryLabel))
                }
                .onTapGesture {
                    if address == "Enter new address" || "Enter new address".contains(address) {
                        withAnimation(.easeInOut) {
                            address = ""
                        }
                    }
                }
            }.frame(height: 50, alignment: .bottom)

            Divider().background(.orange)
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: "info.circle")
                    .foregroundColor(Color.lightGray)
                    .font(Font.system(size: 22, weight: .regular, design: .rounded))
                    .offset( y: 2)
                Text("You can start by typing postcode or first line of your address")
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 16, weight: .regular, design: .rounded))
                Spacer()
            }
            
            if Addresses.filter({$0.postcode.contains($address.wrappedValue) || $0.street.contains($address.wrappedValue)}) != [] {
                withAnimation {
                    List(Addresses.filter({$0.postcode.contains($address.wrappedValue) || $0.street.contains($address.wrappedValue)}), id: \.self) { adr in
                        Text(" \(adr.apt) \(adr.building) \(adr.street) \(adr.town)")
                            .onTapGesture {
                                self.pickedAddress = adr
                                self.address = " \(adr.apt) \(adr.building) \(adr.street) \(adr.town)"
                                showMap = true
                            }
                            .animation(.easeInOut(duration: 2), value: pickedAddress)
                            .animation(.easeInOut(duration: 2), value: address)
                    }
                    .listStyle(InsetListStyle())
                    .frame(maxHeight: .infinity, alignment: .center)
                }
            }

            if actorType != .CUSTOMER {
                Button {
                    bottomSheetPosition = .middle
                } label: {
                    HStack {
                        Image(systemName: "list.dash")
                            .foregroundColor(Color.orange.opacity(0.5))
                            .shadow(color: Color.lightGray, radius: 0.5, x: 0.5, y: 0.5)
                        Text("Select existing address")
                            .lineLimit(1)
                            .shadow(color: Color.lightGray, radius: 0.5, x: 0.5, y: 0.5)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                    }
                    .foregroundColor(.orange.opacity(0.5))
                    .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(color: Color.lightGray, radius: 4, x: -4.5, y: -4.5)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1.5)
                        .foregroundColor(Color.orange.opacity(0.5))
                        .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3))
                }
            }

            if showMap == true {
                NavigationLink(destination: GoogleMapView(providers: .constant([]), pickedAddress: $pickedAddress)) {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(Color.orange.opacity(0.5))
                            .shadow(color: Color.lightGray, radius: 0.5, x: 0.5, y: 0.5)
                        Text("Show location on map")
                            .lineLimit(1)
                            .shadow(color: Color.lightGray, radius: 0.5, x: 0.5, y: 0.5)
                            .font(.system(size: 20, weight: .regular, design: .rounded))
                    }
                    .foregroundColor(.orange.opacity(0.5))
                    .frame(width: UIScreen.main.bounds.width - 40, height: 50)
                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(color: Color.lightGray, radius: 4, x: -4.5, y: -4.5)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(lineWidth: 1.5)
                        .foregroundColor(Color.orange.opacity(0.5))
                        .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3))
                }
                ScrollView {
                VStack {
                    Section {
                        HStack {
                            Text("Line 1").foregroundColor(.secondary)
                            Spacer()
                            TextField("Mandatory", text: $pickedAddress.street).multilineTextAlignment(.trailing)
                                .focused($isStreetEditing)
                                .onTapGesture {
                                    $isStreetEditing.wrappedValue = true
                                }
                        }.padding(5)}
                    Divider().padding(.horizontal, 5)
                    Section {
                        VStack {
                            HStack {
                                Text("Line 2").foregroundColor(.secondary)
                                Spacer()
                                TextField("Optional", text: $pickedAddress.building).multilineTextAlignment(.trailing)
                                    .focused($isBuildingEditing)
                                    .onTapGesture {
                                        $isBuildingEditing.wrappedValue = true
                                    }
                            }.padding(5)
                        }
                        Divider().padding(.horizontal, 5)
                        Section {
                            HStack {
                                Text("Line 3").foregroundColor(.secondary)
                                Spacer()
                                TextField("Optional   ", text: $pickedAddress.apt).multilineTextAlignment(.trailing)
                                    .focused($isApartmentsEditing)
                                    .onTapGesture {
                                        $isApartmentsEditing.wrappedValue = true
                                    }
                            }.padding(5)
                        }
                    }.transition(.opacity).animation(.easeInOut, value: $showMap.wrappedValue)
                    Divider().padding(.horizontal, 5)
                    Section {
                        HStack {
                            Text("City").foregroundColor(.secondary)
                            Spacer()
                            TextField("Mandatory", text: $pickedAddress.town).multilineTextAlignment(.trailing)
                                .focused($isCityEditing)
                                .onTapGesture {
                                    $isCityEditing.wrappedValue = true
                                }
                        }.padding( 5)}
                    Divider().padding(.horizontal, 5)
                    Section {
                        HStack {
                            Text("Postcode").foregroundColor(.secondary)
                            Spacer()
                            TextField("Mandatory", text: $pickedAddress.postcode).multilineTextAlignment(.trailing)
                                .focused($isPostcodeEditing)
                                .onTapGesture {
                                    $isPostcodeEditing.wrappedValue = true
                                }
                        }.padding(5)
                    }
                }.background(Color.white).padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
                    }.padding(.top, 5).padding(1)
                }


            }
            if $isApartmentsEditing.wrappedValue {
                Section {
                    HStack {
                        Text("Line 3").foregroundColor(.secondary)
                        Spacer()
                        TextField("Optional   ", text: $pickedAddress.apt).multilineTextAlignment(.trailing)
                            .focused($isApartmentsEditing)
                            .onTapGesture {
                                $isApartmentsEditing.wrappedValue = true
                            }
                    }.padding(5)
                }.padding(5).overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
                }.padding(1)
            } else if $isStreetEditing.wrappedValue {
                Section {
                    HStack {
                        Text("Line 1").foregroundColor(.secondary)
                        Spacer()
                        TextField("Mandatory", text: $pickedAddress.street).multilineTextAlignment(.trailing)
                            .focused($isStreetEditing)
                            .onTapGesture {
                                $isStreetEditing.wrappedValue = true
                            }
                    }.padding(5)
                }.padding(5).overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
                }.padding(1)
            } else if $isBuildingEditing.wrappedValue {
                Section {
                    HStack {
                        Text("Line 2").foregroundColor(.secondary)
                        Spacer()
                        TextField("Optional   ", text: $pickedAddress.building).multilineTextAlignment(.trailing)
                            .focused($isBuildingEditing)
                            .onTapGesture {
                                $isBuildingEditing.wrappedValue = true
                            }
                    }.padding(5)
                }.padding(5).overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
                }.padding(1)
            } else if $isCityEditing.wrappedValue {
                Section {
                    HStack {
                        Text("City").foregroundColor(.secondary)
                        Spacer()
                        TextField("Mandatory", text: $pickedAddress.town).multilineTextAlignment(.trailing)
                            .focused($isCityEditing)
                            .onTapGesture {
                                $isCityEditing.wrappedValue = true
                            }
                    }.padding(5)
                }.padding(5).overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
                }.padding(1)
            } else if $isPostcodeEditing.wrappedValue {
                Section {
                    HStack {
                        Text("Postcode").foregroundColor(.secondary)
                        Spacer()
                        TextField("Mandatory", text: $pickedAddress.postcode).multilineTextAlignment(.trailing)
                            .focused($isPostcodeEditing)
                            .onTapGesture {
                                $isPostcodeEditing.wrappedValue = true
                            }
                    }.padding(5)
                }.padding(5).overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
                }.padding(1)
            } else {

                Spacer()
            }
            Rectangle().foregroundColor(.clear).ignoresSafeArea(.container, edges: .horizontal)
                .overlay {
                    VStack {
                        Spacer()
                        NavigationLink(destination: TermsConditionsView( actorType: actorType)) {
                            HStack{
                                Text("Next")
                                    .lineLimit(1)
                                    .shadow(color: Color.secondary, radius: 0.5, x: 0.5, y: 0.5)
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    .foregroundColor(.accentColor)
                                    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .shadow(color: Color.lightGray, radius: 4, x: -4.5, y: -4.5)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .overlay(RoundedRectangle(cornerRadius: 25)
                                        .stroke(lineWidth: 2.0)
                                        .foregroundColor(Color.accentColor)
                                        .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3))
                            }
                        }
                    }.padding(.bottom, 15)
                }.frame( height: 55)
        }.frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                         options: [.allowContentDrag, .tapToDissmiss, .swipeToDismiss,
                                   .shadow(color: .lightGray, radius: 3, x: 3, y: 3), .noBottomPosition,
                                   .appleScrollBehavior, .dragIndicatorColor(Color.lightGray.opacity(0.5)),
                                   .showCloseButton(action: {bottomSheetPosition = .hidden})],
                         headerContent:{},
                         mainContent: {

                ForEach(Addresses, id: \.self) { adr in
                    Section {
                        VStack(alignment: .leading) {
                            Text("\(adr.apt) \(adr.building) \(adr.street) \(adr.town)")
                                .foregroundColor(.secondary)
                            Divider().background(Color.lightGray.opacity(0.5)).padding(.horizontal, 10)
                        }.padding(.horizontal, 20)
                    }
                    .onTapGesture {
                        self.pickedAddress = adr
                        self.address = " \(adr.apt) \(adr.building) \(adr.street) \(adr.town)"
                        showMap = true
                    }
                    .animation(.easeInOut(duration: 2), value: pickedAddress)
                    .animation(.easeInOut(duration: 2), value: address)
                }
            }).navigationTitle("Confirm address").navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressVerifyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressVerifyView(actorType: .QLOGA)
        }.previewDevice("iPhone 6s")
    }
}
