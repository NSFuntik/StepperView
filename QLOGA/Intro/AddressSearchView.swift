//
//  AddressSearchView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import Combine
import CoreLocation

struct AddressSearchView: View {
    @State var showMap = false
    //    @State var list = false
    @State private var price: Int = 0
    @Binding var address: String
    @State var pickedAddress: Address = Address(postcode: "", town: "", street: "", building: "", apt: "")

    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                //                VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Enter your address or postcode", text: self.$address)
                    NavigationLink(destination: GoogleMapView(providers: .constant([]), pickedAddress: $pickedAddress)) {
                        if showMap {
                            Image(systemName: "mappin.and.ellipse").foregroundColor(Color.accentColor)
                        }
                        //Image("MapSymbol")mappin.and.ellipse
                    }
                }
                .foregroundColor(Color(UIColor.secondaryLabel))
                .padding(.vertical, 8)
                .padding(.horizontal, 5)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.groupTableViewBackground)))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.lightGray.opacity(0.6), lineWidth: 1)
//                        .shadow(color: .lightGray.opacity(0.5), radius: 3)
                )
//                .shadow(color: .lightGray.opacity(0.6), radius: 3, y: 3)

                //                    .padding(.bottom)
                //                    TextField("Enter your address or postcode", text: $address).textFieldStyle(BottomLineTextFieldStyle())
                //                }


            }.padding()
                .onTapGesture {
                    if address == "Enter new address" || "Enter new address".contains(address) {
                        UIView.animate(withDuration: 0.5) {
                            address = ""
                        }
                    }
                }

            if Addresses.filter({$0.postcode.contains($address.wrappedValue) || $0.street.contains($address.wrappedValue)}) != [] {
                withAnimation {
                    List(Addresses.filter({$0.postcode.contains($address.wrappedValue) || $0.street.contains($address.wrappedValue)}), id: \.self) { adr in
                        Text(" \(adr.apt) \(adr.building) \(adr.street) \(adr.town)")
                            .onTapGesture {
                                self.pickedAddress = adr
                                self.address = " \(adr.apt) \(adr.building) \(adr.street) \(adr.town)"
                                showMap.toggle()
                            }        .animation(.easeInOut(duration: 2), value: pickedAddress)
                            .animation(.easeInOut(duration: 2), value: address)

                    }.listStyle(InsetListStyle())
                        .frame(maxHeight: .infinity, alignment: .center)
                }
            }
            GroupBox {
                HStack {
                    Text("Parking")
                    Spacer()
                    Picker("Parking", selection: $price) {
                        ForEach(ParkingType.allCases) { provider in
                            Text(provider.rawValue)
                        }
                    }.pickerStyle(.menu)
                }
                Divider()
                HStack {
                    Text("Postcode")
                    Spacer()
                    TextField("Postcode", text: $pickedAddress.postcode).multilineTextAlignment(.trailing)

                }
                Divider()
                HStack {
                    Text("Town")
                    Spacer()
                    TextField("", text: $pickedAddress.town).multilineTextAlignment(.trailing)
                }
                Divider()
                HStack {
                    Text("Street")
                    Spacer()
                    TextField("", text: $pickedAddress.street).multilineTextAlignment(.trailing)
                }
                Divider()
                VStack {
                    HStack {
                        Text("Building")
                        Spacer()
                        TextField("", text: $pickedAddress.building).multilineTextAlignment(.trailing)
                    }
                    Divider()

                    HStack {
                        Text("Apartments")
                        Spacer()
                        TextField("", text: $pickedAddress.apt).multilineTextAlignment(.trailing)
                    }
                }
            }.overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.lightGray.opacity(0.6), lineWidth: 1))
            .padding()
            //            .ignoresSafeArea(.all)
            //            }
            Spacer()
        }
//        .padding()
        .ignoresSafeArea(.keyboard)
        //        .onDisappear {
        //            if address == "", "Enter new address".contains(address) {
        //                address = "Enter new address"
        //            }
        //        }
        .navigationTitle("Address")
    }
}

struct AddressSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressSearchView(address: .constant(""), pickedAddress:  Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "09"))
                .previewInterfaceOrientation(.portrait)
        }
    }
}

struct BottomLineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack() {
            configuration
            Rectangle()
                .frame(height: 0.5, alignment: .bottom)
                .foregroundColor(Color.lightGray)

        }
    }
}


enum ParkingType: String, CaseIterable, Identifiable  {
    case Free
    case Paid
    case Unspecified
    var id: String { self.rawValue }
}
