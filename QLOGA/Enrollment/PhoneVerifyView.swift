//
//  PhoneVerifyView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import AnyFormatKitSwiftUI
import Combine
import SwiftUI
struct PhoneVerifyView: View {
    let bounds = UIScreen.main.bounds
    enum Field: Hashable {
        case countryCode
        case phone
        case pinCode
    }

    @FocusState private var focusedField: Field?
    @Binding var phone: String
    @State var isInheritedSettingsView = false
    @FocusState var phoneIsFocused: Bool
    @FocusState private var isCountryCodeFocused: Bool
    @FocusState private var isPhoneFocused: Bool
    @FocusState private var isPinFocused: Bool

    @ObservedObject var codeContryCode = ObservableCountryCode()
    @State var actorType: ActorsEnum

    @State var pinRequested: Bool = false
    @State var y = false
    @Environment(\.presentationMode) var presentationMode
    @State var pinCode = ""
    @State var phoneNumber = ""
    @State var countryName = "United Kindom"
    @State var countryCode = "44"
    @State var countryFlag = "🇬🇧"

    var body: some View {
        VStack(alignment: .center) {
            if !$y.wrappedValue {
                if !$isInheritedSettingsView.wrappedValue {
                    ZStack {
                        HStack {
                            Spacer()
                            DottedLine()
                                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                                .shadow(radius: 0.5)
                                .frame(width: bounds.width / 2 - 5, height: 0.5, alignment: .leading)
                                .ignoresSafeArea(.all, edges: .trailing)
                                .foregroundColor(Color.lightGray)
                        }
                        Image("VerifyStep")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30, alignment: .center)
                    }.frame(height: 50, alignment: .center)
                }
                HStack {
                    Text("Your verified mobile number is mandatory and needed for maintaining communication with providers.")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 19, weight: .regular, design: .rounded))
                        .padding(10)
                    Spacer()
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
                }.padding(.top, $isInheritedSettingsView.wrappedValue ? 10 : 0)
            }
            Group {
                VStack {
                    DisclosureGroup(isExpanded: $y) {
                        CountryCodes(countryCode: $countryCode, countryFlag: $countryFlag, countryName: $countryName, y: $y)
                            .listStyle(InsetListStyle())
                            .frame(minHeight: 100, maxHeight: 300)
                            .cornerRadius(10)
                            .ignoresSafeArea(.keyboard)
                    } label: {
                        VStack {
                            HStack(alignment: .center) {
                                Text("Country Code")
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))

                                Spacer()
                                Text(String("\($countryName.wrappedValue)  (+\($countryCode.wrappedValue))"))
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                                    .keyboardType(.numberPad)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            }
                        }.frame(height: 50)
                    }
                    Divider()
                    HStack {
                        HStack(spacing: 2) {
                            Text($countryFlag.wrappedValue)
                                .frame(height: 50)
                                .onTapGesture {
                                    $focusedField.wrappedValue = .countryCode
                                    isCountryCodeFocused = true
                                }
                            Text($countryCode.wrappedValue.isEmpty ? "" : "+ ")
                                .padding(.trailing, -5)
                                .frame(width: 10, height: 50)
                                .multilineTextAlignment(.leading)

                            TextField("+44", text: $countryCode)
                                .focused($focusedField, equals: .countryCode)
                                .focused($isCountryCodeFocused, equals: focusedField == .countryCode)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.leading)
                                .keyboardShortcut(.defaultAction)
                                .frame(width: 35, height: 50)
                                .submitScope()
                                .onChange(of: $countryCode.wrappedValue, perform: { _ in $y.wrappedValue = true })
                                .onReceive(Just($countryCode.wrappedValue)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        $countryCode.wrappedValue = filtered
                                    }
                                }
                                .onSubmit {
                                    $focusedField.wrappedValue = .phone
                                    isPhoneFocused = true
                                    $y.wrappedValue = false
                                }
                        }

                        TextField("Phone number", text: $phoneNumber.max(13))
                            .focused($focusedField, equals: .phone)
                            .focused($isPhoneFocused, equals: focusedField == .phone)
                            .keyboardType(.phonePad)
                            .showClearButton($phoneNumber)
                            .keyboardShortcut(.defaultAction)
                            .textContentType(.telephoneNumber)
                            .submitScope()
                            .multilineTextAlignment(.leading)
                            .onReceive(Just($phoneNumber.wrappedValue)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.$phoneNumber.wrappedValue = filtered
                                }
                            }
                            .onSubmit {
                                pinRequested = true
                                $focusedField.wrappedValue = .pinCode
                                isPinFocused = true
                                pinRequested = true
                            }
                        Spacer()
                    }
                    .frame(height: 50)
                    Divider()

                    if pinRequested == true {
                        HStack(alignment: .center) {
                            Spacer()
                            VStack(alignment: .center) {
                                TextField("", text: $pinCode.max(6))
                                    .offset(y: 10)
                                    .textContentType(.oneTimeCode)
                                    .multilineTextAlignment(.center)
                                    .focused($focusedField, equals: .pinCode)
                                    .focused($isPinFocused, equals: $focusedField.wrappedValue == .pinCode)

                                    .placeholder(when: $pinCode.wrappedValue.count < 1) {
                                        VStack {
                                            Spacer()
                                            Text("Enter 6-digit code")
                                                .offset(y: 10)
                                                .font(.system(size: 17, weight: .regular, design: .rounded))
                                                .foregroundColor(.orange.opacity(0.5))
                                            Spacer()
                                        }
                                    }
                                    .submitScope()
                                    .onSubmit {
                                        $focusedField.wrappedValue = .pinCode
                                        isPinFocused = true
                                        pinRequested = true
                                    }
                                    .onTapGesture {
                                        $focusedField.wrappedValue = .pinCode
                                        isPinFocused = true
                                        pinRequested = true
                                    }
                                    .keyboardType(.numberPad)
                                    .keyboardShortcut(.defaultAction)
                                    .foregroundColor(.orange)
                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                            }.frame(width: 250, height: 50, alignment: .center)
                            Spacer()
                        }.frame(height: 50).padding(.bottom, 5).transition(.opacity).animation(.easeInOut, value: $isPinFocused.wrappedValue)
                        Divider().padding(.horizontal, 20).background(.orange)
                    }

                    Button {
                        if !$phoneNumber.wrappedValue.isEmpty {
                            pinRequested = true
                            $focusedField.wrappedValue = .pinCode
                            isPinFocused = true
                        }
                    } label: {
                        HStack {
                            Text(pinRequested ? "Resend code" : "Send code")
                                .withDoneButtonStyles(backColor: .Orange, accentColor: .white)
                        }
                    }.disabled($phoneNumber.wrappedValue.count < 5)
                }
            }
            .onSubmit {
                if $focusedField.wrappedValue == .countryCode {
                    $focusedField.wrappedValue = .phone
                } else {
                    focusedField = .none
                }
            }
            Spacer()

            if $pinCode.wrappedValue.count > 5 {
                Rectangle().foregroundColor(.white).ignoresSafeArea(.container, edges: .horizontal)
                    .overlay {
                        VStack {
                            Spacer()
                            if $isInheritedSettingsView.wrappedValue {
                                Button(action: {
                                    $phone.wrappedValue = "+" + $countryCode.wrappedValue + $phoneNumber.wrappedValue
                                    self.presentationMode.wrappedValue.dismiss()
                                }) {
                                    HStack {
                                        Text("Done")
                                            .withDoneButtonStyles(backColor: .accentColor, accentColor: .white)
                                    }
                                }
                            } else {
                                NavigationLink(destination: AddressVerifyView(actorType: actorType)) {
                                    HStack {
                                        Text("Next")
                                            .withDoneButtonStyles(backColor: .white, accentColor: .accentColor)
                                    }
                                }
                                //                                .ignoresSafeArea(.keyboard, edges: .bottom)
                            }
                        }.padding(.bottom, 25)
                    }
                //                    .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }.padding(.horizontal, 20)
            .toolbar {


                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done", role: .destructive) {
                            if isCountryCodeFocused == false, isPhoneFocused == false, isPinFocused == false {
                                $focusedField.wrappedValue = .none
                                UIApplication.shared.closeKeyboard()
                            }
                            switch $focusedField.wrappedValue {
                                case .countryCode:
                                    $focusedField.wrappedValue = .phone
                                    isPinFocused = false
                                    isCountryCodeFocused = false
                                    isPhoneFocused = true
                                case .phone:
                                    if $phoneNumber.wrappedValue.count > 5 {
                                        pinRequested = true
                                        $focusedField.wrappedValue = .pinCode
                                        isPinFocused = true
                                    }
                                case .pinCode:
                                    if $pinCode.wrappedValue.count == 6 {
                                        $focusedField.wrappedValue = .none
                                        UIApplication.shared.closeKeyboard()
                                        $focusedField.wrappedValue = .none
                                    }
                                case .none:
                                    $focusedField.wrappedValue = .none
                                    UIApplication.shared.closeKeyboard()
                                    $focusedField.wrappedValue = .none
                                    if $isInheritedSettingsView.wrappedValue {
                                        $phone.wrappedValue = "+" + $countryCode.wrappedValue + $phoneNumber.wrappedValue
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                    //                                case .some(.pinCode):
                                    //                                    $focusedField.wrappedValue = .none
                                    //                                    UIApplication.shared.closeKeyboard()
                                    //                                    $focusedField.wrappedValue  = .none
                            }
                        }
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isCountryCodeFocused = false
                    isPinFocused = false
                    $focusedField.wrappedValue = .phone
                    isPhoneFocused = true
                }
            }
            .navigationTitle("Verify phone").navigationBarTitleDisplayMode(.inline)
            .environmentObject(ObservableCountryCode())
    }
}

extension Text {
    func withDoneButtonStyles(backColor: Color, accentColor: Color, isWide: Bool = true, width: CGFloat = UIScreen.main.bounds.width - 30, height: CGFloat = 50) -> some View {
        self.lineLimit(1)
            .shadow(color: Color.secondary, radius: 0.5, x: 0.5, y: 0.5)
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .foregroundColor(accentColor)
            .frame(width: width, height: height)
            .background(RoundedRectangle(cornerRadius: 25).fill(backColor))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(color: Color.lightGray, radius: 4, x: -4.5, y: -4.5)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 2.0)
                .foregroundColor(accentColor)
                .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3))
    }
}

struct PhoneVerifyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PhoneVerifyView(phone: .constant(""), actorType: .QLOGA)
        }.previewDevice("iPhone 6s")
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .center,
        @ViewBuilder placeholder: () -> Content) -> some View
    {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
