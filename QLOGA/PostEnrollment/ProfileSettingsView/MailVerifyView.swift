//
//  MailVerifyView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/17/22.
//

//import AnyFormatKitSwiftUI
import SwiftUI
struct MailVerifyView: View {
	let bounds = UIScreen.main.bounds
	enum Field: Hashable {
		case countryCode
		case phone
		case pinCode
	}

	@Binding var phone: String
	@State var actorType: ActorsEnum
	@State var isInheritedSettingsView = false
	@FocusState private var focusedField: Field?
	@FocusState var phoneIsFocused: Bool
	@FocusState private var isCountryCodeFocused: Bool
	@FocusState private var isPhoneFocused: Bool
	@FocusState private var isPinFocused: Bool

	@ObservedObject var codeContryCode = ObservableCountryCode()

	@State var pinRequested: Bool = false
	@State var y = false
	@Environment(\.presentationMode) var presentationMode
	@State var pinCode = ""
	@State var phoneNumber = ""
	@State var countryName = "United Kindom"
	@State var countryCode = ""
	@State var countryFlag = ""

	var body: some View {
		VStack(alignment: .center) {
			if !$y.wrappedValue {
				HStack {
					Text("Your verified Email address is mandatory and needed for maintaining communication with providers.")
						.multilineTextAlignment(.leading)
						.font(Font.system(size: 19, weight: .regular, design: .rounded))
						.padding(10)
					Spacer()
				}.overlay { RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray) }
			}
			Group {
				VStack {
					HStack {
						TextField("Email", text: $phoneNumber)
							.focused($focusedField, equals: .phone)
							.focused($isPhoneFocused, equals: focusedField == .phone)
							.keyboardType(.emailAddress)
							.keyboardShortcut(.defaultAction)
							.textContentType(.emailAddress)
							.submitScope()
							.multilineTextAlignment(.leading)
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
							Text(pinRequested ? "Resend verification email" : "Send verification email")
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

							Button(action: {
								$phone.wrappedValue = $phoneNumber.wrappedValue
								self.presentationMode.wrappedValue.dismiss()
							}) {
								HStack {
									Text("Done")
										.withDoneButtonStyles(backColor: .white, accentColor: .accentColor)
								}
							}
							.ignoresSafeArea(.keyboard, edges: .bottom)
						}.padding(.bottom, 15)
					}.ignoresSafeArea(.keyboard, edges: .bottom)
			}
		}.padding(.horizontal, 20).padding(.top, 10)
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
										$phone.wrappedValue = $phoneNumber.wrappedValue
										self.presentationMode.wrappedValue.dismiss()
									}
									//                                case .some(.pinCode):
									//                                    $focusedField.wrappedValue = .none
									//                                    UIApplication.shared.closeKeyboard()
									//                                    $focusedField.wrappedValue  = .none
							}
						}.font(.system(size: 20, weight: .semibold, design: .rounded))
					}
				}
			}
			.onAppear {
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
					isPinFocused = false
					isCountryCodeFocused = false
					$focusedField.wrappedValue = .phone
					isPhoneFocused = false
				}
			}
			.navigationTitle("Email (Verified)").navigationBarTitleDisplayMode(.inline)
			.environmentObject(ObservableCountryCode())
	}
}

struct MailVerifyView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			MailVerifyView(phone: .constant(""), actorType: .CUSTOMER)
		}.previewDevice("iPhone 6s")
	}
}
