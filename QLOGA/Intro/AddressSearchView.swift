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
    @State private var price: Int = 0
    @Binding var address: String
    @State var pickedAddress: Address = Address(postcode: "", town: "", street: "", building: "", apt: "")

    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Enter your address or postcode", text: self.$address)
                    NavigationLink(destination: GoogleMapView(providers: .constant([]), pickedAddress: $pickedAddress)) {
                        if showMap {
                            Image(systemName: "mappin.and.ellipse").foregroundColor(Color.accentColor)
                        }
                    }
                }
                .foregroundColor(Color(UIColor.secondaryLabel))
                .padding(.vertical, 8)
                .padding(.horizontal, 5)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary.opacity(0.7), lineWidth: 1))
            }.padding()
                .onTapGesture {
                    if address == "Enter new address" || "Enter new address".contains(address) {
                        withAnimation(.easeInOut) {
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
                            }
                            .animation(.easeInOut(duration: 2), value: pickedAddress)
                            .animation(.easeInOut(duration: 2), value: address)
                    }.listStyle(InsetListStyle())
                        .frame(maxHeight: .infinity, alignment: .center)
                }
            }
            VStack {
                Section {
                    HStack {
                        Text("Parking")
                        Spacer()
                        Picker("Parking", selection: $price) {
                            ForEach(ParkingType.allCases) { provider in
                                Text(provider.rawValue)
                            }
                        }.pickerStyle(.menu)
                    }
                }.padding(.horizontal, 5).padding(.top, 3)
                Divider().padding(.horizontal, 5)
                Section {
                    HStack {
                        Text("Postcode")
                        Spacer()
                        TextField("Postcode", text: $pickedAddress.postcode).multilineTextAlignment(.trailing)

                    }.padding(5)}
                Divider().padding(.horizontal, 5)
                Section {
                    HStack {
                        Text("Town")
                        Spacer()
                        TextField("", text: $pickedAddress.town).multilineTextAlignment(.trailing)
                    }.padding( 5)}
                Divider().padding(.horizontal, 5)
                Section {
                    HStack {
                        Text("Street")
                        Spacer()
                        TextField("", text: $pickedAddress.street).multilineTextAlignment(.trailing)
                    }.padding(5)}
                Divider().padding(.horizontal, 5)
                Section {
                    VStack {
                        HStack {
                            Text("Building")
                            Spacer()
                            TextField("", text: $pickedAddress.building).multilineTextAlignment(.trailing)
                        }.padding( 5)
                    }
                    Divider().padding(.horizontal, 5)
                    Section {

                        HStack {
                            Text("Apartments")
                            Spacer()
                            TextField("", text: $pickedAddress.apt).multilineTextAlignment(.trailing)
                        }.padding( 5)
                    }
                }
            }.background(Color.white).padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary
                        .opacity(0.7), lineWidth: 1).padding(1))
                .padding()
            Spacer()
        }
        .ignoresSafeArea(.keyboard)
        .navigationTitle("Address").navigationBarTitleDisplayMode(.inline)
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
