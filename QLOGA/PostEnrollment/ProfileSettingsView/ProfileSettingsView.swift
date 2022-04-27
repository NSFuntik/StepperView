//
//  ProfileSettingsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/16/22.
//

import Combine
import SwiftUI
struct ProfileSettingsView: View {
	@State var actorType: ActorsEnum
	@Binding var customer: Customer
	@Binding var provider: Provider
	@State var familyRole: FamilyRole = .Single

	@State var isPickedDate = false
	@FocusState private var isFocused: Bool
	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		VStack(alignment: .center) {
			ScrollView(showsIndicators: false) {
				VStack {
					if $actorType.wrappedValue == .CUSTOMER {
						customerInfo
					} else {
						Section {
							HStack {
								Toggle(isOn: $provider.isActive) {
									Text("Active")
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
										.padding(.leading, 10)
									Spacer()
								}
							}.padding(.horizontal, 5)
								.frame(height: 40)
							Divider().padding(.horizontal, -10).padding(.leading, 25)
						}
						Section {
							HStack {
								TextField("Name", text: $provider.name)
									.foregroundColor(Color.black.opacity(0.9))
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 17, weight: .regular, design: .rounded))
									.lineLimit(1)
									.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
							Divider().padding(.horizontal, -10).padding(.leading, 25)
						}
					}
					Section {
						NavigationLink(destination: PhoneVerifyView(phone: actorType == .CUSTOMER ? $customer.phone : $provider.phone,
						                                            isInheritedSettingsView: true, actorType: actorType)) {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Phone")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									Text(actorType == .CUSTOMER ? $customer.phone.wrappedValue : $provider.phone.wrappedValue)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
								}.padding(.leading, 10)
								Spacer()
								Image(systemName: "chevron.right")
									.foregroundColor(Color.accentColor)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 20, weight: .regular, design: .rounded))
									.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
						}
						Divider().padding(.horizontal, -10).padding(.leading, 25)
					}
					Section {
						NavigationLink(destination: MailVerifyView(phone: actorType == .CUSTOMER ? $customer.email : $provider.email, actorType: actorType, isInheritedSettingsView: true)) {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Email")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									Text(actorType == .CUSTOMER ? $customer.email.wrappedValue : $provider.email.wrappedValue)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
								}.padding(.leading, 10)
								Spacer()
								Image(systemName: "chevron.right")
									.foregroundColor(Color.accentColor)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 20, weight: .regular, design: .rounded))
									.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
						}
						Divider().padding(.horizontal, -10).padding(.leading, 25)
					}
					Section {
						NavigationLink(destination: AddressSearchView(address: actorType == .CUSTOMER ? $customer.address.total : $provider.address.total, actorType: actorType)) {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Address")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									Text(actorType == .CUSTOMER ? $customer.address.total.wrappedValue : $provider.address.total.wrappedValue)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
								}.padding(.leading, 10)
								Spacer()
								Image(systemName: "chevron.right")
									.foregroundColor(Color.accentColor)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 20, weight: .regular, design: .rounded))
									.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
						}
						Divider().padding(.horizontal, -10).padding(.leading, 25)
					}
					Section {
						NavigationLink(destination: LanguagesPickerView(languages: actorType == .CUSTOMER ? $customer.languages : $provider.languages)) {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Spoken language")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									Text(getLanguages(languages: actorType == .CUSTOMER ? $customer.languages.wrappedValue : $provider.languages.wrappedValue))
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
								}.padding(.leading, 10)
								Spacer()
								Image(systemName: "chevron.right")
									.foregroundColor(Color.accentColor)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 20, weight: .regular, design: .rounded))
									.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
						}
						Divider().padding(.horizontal, -10).padding(.leading, 25)
					}
					if actorType != .CUSTOMER {
						Section {
							HStack {
								Toggle(isOn: $provider.calloutCharge) {
									Text("Callout charge")
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
										.padding(.leading, 11)
									Spacer()
								}
							}.padding(.horizontal, 5).frame(height: 40)
							Divider().padding(.horizontal, -10).padding(.leading, 25)
						}
						Section {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Cancellation period (hours)")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									TextField("Cancellation period (hours)", text: $provider.cancellation)
										.keyboardType(.numberPad)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
										.onReceive(Just($provider.cancellation.wrappedValue)) { newValue in
											let filtered = newValue.filter { "0123456789".contains($0) }
											if filtered != newValue {
												self.$provider.cancellation.wrappedValue = filtered
											}
										}
										.focused($isFocused)
								}
								.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
							Divider().padding(.horizontal, -10).padding(.leading, 25)
						}
						Section {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Coverage zone (miles)")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									TextField("Coverage zone (miles)", text: $provider.coverage)
										.keyboardType(.numberPad)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
										.onReceive(Just($provider.coverage.wrappedValue)) { newValue in
											let filtered = newValue.filter { "0123456789".contains($0) }
											if filtered != newValue {
												self.$provider.coverage.wrappedValue = filtered
											}
										}
										.focused($isFocused)
								}
								.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
							Divider().padding(.horizontal, -10).padding(.leading, 25)
						}
					}
					Section {
						NavigationLink(destination: ProviderVerificationsView()) {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Verifications")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									Text(getVerifications(verifications: actorType == .CUSTOMER ? $customer.verifications.wrappedValue : $provider.verifications.wrappedValue))
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)

								}.padding(.leading, 10)
								Spacer()
								Image(systemName: "chevron.right")
									.foregroundColor(Color.accentColor)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 20, weight: .regular, design: .rounded))
									.padding(.leading, 10)
							}.padding(7)

						}.frame(height: 40)
					}
					if actorType != .CUSTOMER {
						Divider().padding(.horizontal, -10).padding(.leading, 25)
						Section {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Website")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									TextField("Website", text: $provider.website)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
										.focused($isFocused)
								}
								.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
							Divider().padding(.horizontal, -10).padding(.leading, 25)
						}
						Section {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Registration details")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									TextField("Registration details", text: $provider.registrationDetails)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
										.focused($isFocused)
								}
								.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
							Divider().padding(.horizontal, -10).padding(.leading, 25)
						}
						Section {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Busines insurance details")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									TextField("Busines insurance details", text: $provider.businesInsuranceDetails)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
										.focused($isFocused)
								}
								.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
							Divider().padding(.horizontal, -10).padding(.leading, 25)
						}
						Section {
							HStack {
								VStack(alignment: .leading, spacing: 0) {
									Text("Description")
										.foregroundColor(.lightGray)
										.font(Font.system(size: 12, weight: .regular, design: .rounded))
									TextField("Description", text: $provider.description)
										.foregroundColor(Color.black.opacity(0.9))
										.multilineTextAlignment(.leading)
										.font(Font.system(size: 17, weight: .regular, design: .rounded))
										.lineLimit(1)
										.focused($isFocused)
								}
								.padding(.leading, 10)
							}.padding(.horizontal, 5).frame(height: 40)
						}
					}
				}.padding(10)
					.overlay(RoundedRectangle(cornerRadius: 10)
						.stroke(Color.secondary
							.opacity(0.7), lineWidth: 1).padding(1))
				VStack {
					HStack {
						Text(actorType == .CUSTOMER ? "FAMILY STATUS" : "VISIBLE DETAILS")
							.foregroundColor(Color.pickerTitle)
							.font(Font.system(size: 17,
							                  weight: .regular,
							                  design: .rounded))
							.padding(.horizontal, 25)
						Spacer()
						if actorType != .CUSTOMER {
							Button {
								$provider.isPhoneVisible.wrappedValue = false
								$provider.isOffTimeVisible.wrappedValue = false
							} label: {
								Text("HIDE ALL")
									.foregroundColor(Color.pickerTitle)
									.font(Font.system(size: 17,
									                  weight: .regular,
									                  design: .rounded))
									.padding(.horizontal, 15)
							}
						}
					}.padding(.bottom, -5)
					VStack {
						if actorType == .CUSTOMER {
							customerFamilyStatus
						} else {
							providerVisibleDetails
						}
					}.padding(10)
						.overlay(RoundedRectangle(cornerRadius: 10)
							.stroke(Color.secondary
								.opacity(0.7), lineWidth: 1).padding(1))
				}.padding(.top, 20)
                Spacer(minLength: 30)
			}
		}.padding(.horizontal, 20).padding(.top, 10)

			.toolbar {
				ToolbarItem(placement: .keyboard) {
					HStack {
						Spacer()
						Button("Done") { isFocused = false }
					}
				}
			}
			.toolbar {
				Button("Save", role: .destructive) {
					$customer.familyRole.wrappedValue = $familyRole.wrappedValue
					testCustomer = $customer.wrappedValue
					self.presentationMode.wrappedValue.dismiss()
				}
			}
			.onAppear { $familyRole.wrappedValue = $customer.familyRole.wrappedValue }
			.navigationTitle("Settings")
			.navigationBarTitleDisplayMode(.inline)
	}

	var customerInfo: some View {
		VStack(alignment: .center) {
			Section {
				HStack {
					TextField("Name", text: $customer.name)
						.foregroundColor(Color.black.opacity(0.9))
						.multilineTextAlignment(.leading)
						.font(Font.system(size: 17, weight: .regular, design: .rounded))
						.lineLimit(1)
						.padding(.leading, 10)
						.focused($isFocused)

				}.padding(.horizontal, 5).frame(height: 40)
				Divider().padding(.horizontal, -10).padding(.leading, 25)
			}
			Section {
				HStack {
					TextField("Middle name", text: $customer.middleMame)
						.foregroundColor(Color.black.opacity(0.9))
						.multilineTextAlignment(.leading)
						.font(Font.system(size: 17, weight: .regular, design: .rounded))
						.lineLimit(1)
						.padding(.leading, 10)
						.focused($isFocused)

				}.padding(.horizontal, 5).frame(height: 40)
				Divider().padding(.horizontal, -10).padding(.leading, 25)
			}
			Section {
				HStack {
					TextField("Surname", text: $customer.surname)
						.foregroundColor(Color.black.opacity(0.9))
						.multilineTextAlignment(.leading)
						.font(Font.system(size: 17, weight: .regular, design: .rounded))
						.lineLimit(1)
						.padding(.leading, 10)
						.focused($isFocused)

				}.padding(.horizontal, 5).frame(height: 40)
				Divider().padding(.horizontal, -10).padding(.leading, 25)
			}
			Section {
				HStack {
					TextField("Maiden name", text: $customer.maidenName)
						.foregroundColor(Color.black.opacity(0.9))
						.multilineTextAlignment(.leading)
						.font(Font.system(size: 17, weight: .regular, design: .rounded))
						.lineLimit(1)
						.padding(.leading, 10)
						.focused($isFocused)

					Spacer()
				}.padding(.horizontal, 5).frame(height: 40)
				Divider().padding(.horizontal, -10).padding(.leading, 25)
			}
            HStack(alignment: .center) {
//                Text("Birthday")
//                    .foregroundColor(Color.black.opacity(0.9))
//                    .multilineTextAlignment(.leading)
//                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
//                    .lineLimit(1)
//                Spacer()
                DatePicker(
                    "Birthday",
                    selection: $customer.birthday,
                    in: ...Date(),
                    displayedComponents: [.date])
//                .datePickerStyle(.compact)
                .onSubmit {
                    $isPickedDate.wrappedValue = false
                }
            }
//            ZStack {
//                DisclosureGroup(isExpanded: $isPickedDate) {
//
//                } label: {
//				}
//				HStack {
//					Spacer()
//					if !$isPickedDate.wrappedValue {
//						Text(getString(from: $customer.birthday.wrappedValue))
//							.foregroundColor(Color.white)
//							.multilineTextAlignment(.trailing)
//							.font(Font.system(size: 17, weight: .regular, design: .rounded))
//							.lineLimit(1)
//							.padding(3)
//							.background(RoundedRectangle(cornerRadius: 5).fill(Color.lightGray))
//							.offset(x: 10)
//							.onTapGesture {
//								$isPickedDate.wrappedValue.toggle()
//							}
//					}
//				}
//				.padding(.leading, 10)
//			}
			.padding(.horizontal).frame(height: $isPickedDate.wrappedValue ? .infinity : 40)
			Divider().padding(.horizontal, -10).padding(.leading, 25)
		}
	}

	var customerFamilyStatus: some View {
		VStack {
			HStack {
				Text("Families")
					.foregroundColor(Color.pickerTitle)
					.multilineTextAlignment(.leading)
					.font(Font.system(size: 17, weight: .regular, design: .rounded))
					.lineLimit(1)
				Spacer()
				Text("Stokes")
					.foregroundColor(Color.black.opacity(0.9))
					.multilineTextAlignment(.leading)
					.font(Font.system(size: 17, weight: .regular, design: .rounded))
					.lineLimit(1)
			}.padding(15).frame(height: 40, alignment: .center)
			Divider().padding(.horizontal, -10).padding(.leading, 25)

			HStack {
				Text("Role")
					.foregroundColor(Color.pickerTitle)
					.multilineTextAlignment(.leading)
					.font(Font.system(size: 17, weight: .regular, design: .rounded))
					.lineLimit(1)
				Spacer()
				Picker("Role", selection: $familyRole) {
					ForEach(FamilyRole.allCases) { role in
						Text(role.rawValue)
							.foregroundColor(Color.black.opacity(0.9))
							.multilineTextAlignment(.leading)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
							.lineLimit(1)
					}
				}.pickerStyle(.menu)
			}.padding(15).frame(height: 40, alignment: .center)
		}
	}

	var providerVisibleDetails: some View {
		VStack {
			Section {
				HStack {
					Toggle(isOn: $provider.isPhoneVisible) {
						Text("Phone")
							.foregroundColor(Color.black.opacity(0.9))
							.multilineTextAlignment(.leading)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
							.lineLimit(1)
							.padding(.leading, 10)
						Spacer()
					}
				}.padding(.horizontal, 5).frame(height: 40)
				Divider().padding(.horizontal, -10).padding(.leading, 25)
			}
			Section {
				HStack {
					Toggle(isOn: $provider.isOffTimeVisible) {
						Text("Off-Time")
							.foregroundColor(Color.black.opacity(0.9))
							.multilineTextAlignment(.leading)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
							.lineLimit(1)
							.padding(.leading, 10)
						Spacer()
					}
				}.padding(.horizontal, 5).frame(height: 40)
			}
		}
	}
}

struct ProfileSettingsView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			NavigationView {
				ProfileSettingsView(actorType: .CUSTOMER, customer: Binding(projectedValue: .constant(testCustomer)), provider: Binding(projectedValue: .constant(testProvider)))
			}.previewDevice("iPhone 6s")
		}
	}
}
