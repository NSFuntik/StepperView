//
//  AddressSearchView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import Combine
import CoreLocation
import SwiftUI

struct AddressSearchView: View {
    @State var showMap = false
    @State private var price: Int = 0
    @Binding var address: String
    @State var pickedAddress: Address = .init(postcode: "", town: "", street: "", building: "", apt: "")
    @FocusState var fieldIsFocused: Bool
    @State var actorType: ActorsEnum
    @FocusState private var isFocused: Bool

    enum Field: Hashable {
        case search
        case postcode
    }

    @FocusState private var focusedField: Field?

    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                HStack(alignment: .center) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Enter your address or postcode", text: self.$address)
                            .focused($fieldIsFocused)
                            .focused($focusedField, equals: .search)
                            .showClearButton($address)
                        Spacer()
                    }
                    .foregroundColor(Color.secondary)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 5)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary.opacity(0.7), lineWidth: 1))

                    NavigationLink(destination: GoogleMapView(providers: .constant([]), pickedAddress: $pickedAddress)) {
                        if showMap {
                            Image(systemName: "mappin.and.ellipse").foregroundColor(Color.accentColor).zIndex(2).font(.system(size: 20, weight: .regular, design: .rounded))
                        }
                    }
                }.zIndex(2)
                    .task {
                        if address == "Enter new address" || "Enter new address".contains(address) {
                            address = ""
                            focusedField = .search
                        }
                    }

                if Addresses.filter({ $0.postcode.contains($address.wrappedValue) || $0.street.contains($address.wrappedValue) }) != [] {
                    VStack {
                        List(Addresses.filter { $0.postcode.contains($address.wrappedValue) || $0.street.contains($address.wrappedValue) }, id: \.self) { adr in
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
                            .transition(.opacity)
                            .animation(.easeInOut, value: $fieldIsFocused.wrappedValue)
                    }.transition(.offset()).animation(.easeInOut, value: $fieldIsFocused.wrappedValue)
                }
                ScrollView {
                    VStack {
                        if $focusedField.wrappedValue != .search {
                            if actorType != .CUSTOMER {
                                Section {
                                    HStack {
                                        Toggle(isOn: $pickedAddress.isBussinessOnly) {
                                            Text("Business only")
                                            Spacer()
                                        }
                                    }
                                }.padding(.horizontal, 5)
                                Divider().padding(.horizontal, 5)
                            }
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
                            }.padding(.horizontal, 5)

                            Divider().padding(.horizontal, 5)
                        }
                        Section {
                            HStack {
                                Text("Line 1").foregroundColor(.black)
                                Spacer()
                                TextField("Mandatory", text: $pickedAddress.street).multilineTextAlignment(.trailing)
                                    .focused($isFocused)
                            }.padding(5)
                        }.ignoresSafeArea(.keyboard)
                        Divider().padding(.horizontal, 5)
                        Section {
                            HStack {
                                Text("Line 2").foregroundColor(.black)
                                Spacer()
                                TextField("Optional", text: $pickedAddress.building).multilineTextAlignment(.trailing)
                                    .focused($isFocused)
                            }.padding(5)
                        }.ignoresSafeArea(.keyboard)
                        Divider().padding(.horizontal, 5)
                        if $focusedField.wrappedValue != .search {
                            Section {
                                HStack {
                                    Text("Line 3").foregroundColor(.black)
                                    Spacer()
                                    TextField("Optional   ", text: $pickedAddress.apt).multilineTextAlignment(.trailing)
                                        .keyboardType(.numberPad)
                                        .ignoresSafeArea(.keyboard)
                                        .focused($isFocused)
                                }.padding(5)
                            }.transition(.opacity).animation(.easeInOut, value: $showMap.wrappedValue).ignoresSafeArea(.keyboard)
                            Divider().padding(.horizontal, 5)
                        }
                        Section {
                            HStack {
                                Text("City").foregroundColor(.black)
                                Spacer()
                                TextField("Mandatory", text: $pickedAddress.town).multilineTextAlignment(.trailing)
                                    .focused($isFocused)
                            }.padding(5)
                        }.ignoresSafeArea(.keyboard)
                        Divider().padding(.horizontal, 5)
                        Section {
                            HStack {
                                Text("Postcode").foregroundColor(.black)
                                Spacer()
                                TextField("Mandatory", text: $pickedAddress.postcode).multilineTextAlignment(.trailing)
                                    .focused($isFocused)
                            }.padding(5).ignoresSafeArea(.keyboard)
                        }.transition(.opacity).animation(.easeInOut, value: $fieldIsFocused.wrappedValue)

                    }.background(Color.white).padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary
                                .opacity(0.7), lineWidth: 1).padding(1)).padding(.top, 30)
                        .transition(.opacity).animation(.easeInOut, value: $fieldIsFocused.wrappedValue).ignoresSafeArea(.keyboard)
                }
                Spacer()
            }.padding(.horizontal, 20).padding(.top, 10)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        $focusedField.wrappedValue = .search
                        fieldIsFocused = true
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("Done") { $isFocused.wrappedValue = false; $focusedField.wrappedValue = nil }
                        }
                    }
                }

                .navigationTitle("Address").navigationBarTitleDisplayMode(.inline).background(NavigationConfiguration())
        }.ignoresSafeArea(.keyboard)
    }
}

struct AddressSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressSearchView(address: .constant(""), pickedAddress: Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "09"), actorType: .PROVIDER)
                .previewInterfaceOrientation(.portrait)
        }
    }
}

struct BottomLineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            configuration
            Rectangle()
                .frame(height: 0.5, alignment: .bottom)
                .foregroundColor(Color.lightGray)
        }.ignoresSafeArea(.keyboard)
    }
}

struct NavigationConfiguration: UIViewControllerRepresentable {
    // MARK: Lifecycle

    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear
        navBarAppearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }

    // MARK: Internal

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<NavigationConfiguration>
    ) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController,
                                context: UIViewControllerRepresentableContext<NavigationConfiguration>) {}
}
