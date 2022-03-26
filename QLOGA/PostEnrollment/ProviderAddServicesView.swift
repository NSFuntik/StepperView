//
//  ProviderAddServicesView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import Combine
import SwiftUI
struct ProviderAddServicesView: View {
	@FocusState private var isFocused: Bool
	@Binding var choisedServices: Set<ServiceCleaningType>
	@State var serviceType: ServiceCleaningType
	@State var price = "15.0"
	@State var timeNorm = "180"
	@State var isNotify = false
	@State var conditions: Set<String> = []
	@Environment(\.presentationMode) var presentationMode
	var body: some View {
		VStack(spacing: 10) {
			Image("KitchenCleaner")
				.resizable()
				.scaledToFill()
				.aspectRatio(contentMode: .fill)
				.frame(minHeight: 80, maxHeight: 120, alignment: .center)
				.clipShape(RoundedRectangle(cornerRadius: 10))
				.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(Color.lightGray))
				.padding(1)
			HStack {
				Text("\($serviceType.wrappedValue.title)")
					.foregroundColor(Color.black)
					.multilineTextAlignment(.leading)
					.font(Font.system(size: 20, weight: .regular, design: .rounded))
				Spacer()
			}
			HStack {
				Text("Internal and external drains and sewers repairs including blockage removals, pipe replacements, etc.")
					.foregroundColor(Color.secondary)
					.multilineTextAlignment(.leading)
					.font(Font.system(size: 17, weight: .regular, design: .rounded))
				Spacer()
			}
			VStack {
				Section {
					HStack {
						Text("Price")
							.foregroundColor(Color.black.opacity(0.9))
							.multilineTextAlignment(.leading)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
							.padding(.leading, 10)
							.lineLimit(1)
						Text("(£)")
							.foregroundColor(Color.secondary)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
						Spacer()
						TextField("", text: $price)
							.multilineTextAlignment(.trailing)
							.foregroundColor(Color.secondary)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
							.keyboardType(.decimalPad)
							.onReceive(Just($price.wrappedValue)) { newValue in
								let filtered = newValue.filter { "0123456789.".contains($0) }
								if filtered != newValue {
									$price.wrappedValue = filtered
								}
							}
							.focused($isFocused)
					}.padding(.horizontal, 5).frame(height: 40)
					Divider().padding(.horizontal, -10).padding(.leading, 25)
				}
				Section {
					HStack {
						Text("Time norm")
							.foregroundColor(Color.black.opacity(0.9))
							.multilineTextAlignment(.leading)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
							.lineLimit(1).padding(.leading, 10)

						Text("(min)")
							.foregroundColor(Color.secondary)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
						Spacer()
						TextField("", text: $timeNorm)
							.multilineTextAlignment(.trailing)
							.foregroundColor(Color.secondary)
							.font(Font.system(size: 17, weight: .regular, design: .rounded))
							.keyboardType(.decimalPad)
							.onReceive(Just($timeNorm.wrappedValue)) { newValue in
								let filtered = newValue.filter { "0123456789".contains($0) }
								if filtered != newValue {
									$timeNorm.wrappedValue = filtered
								}
							}
							.focused($isFocused)
					}.padding(.horizontal, 5).frame(height: 40)
					Divider().padding(.horizontal, -10).padding(.leading, 25)
				}
				Section {
					NavigationLink(destination: ServiceConditionsView(conditions: $conditions)) {
						HStack {
							Text("Conditions")
								.foregroundColor(Color.black)
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded))
								.padding(.leading, 10)

							Spacer()
							Text(!conditions.isEmpty ? conditions.count.description : "")
								.foregroundColor(Color.black.opacity(0.9))
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded))
								.lineLimit(1)
								.padding(.leading, 10)
							Image(systemName: "chevron.right")
								.foregroundColor(Color.accentColor)
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 20, weight: .regular, design: .rounded))
								.padding(.leading, 10)
						}
					}.padding(.horizontal, 5).frame(height: 40)
					Divider().padding(.horizontal, -10).padding(.leading, 25)
				}
				Section {
					HStack {
						Toggle(isOn: $isNotify) {
							Text("Notify")
								.foregroundColor(Color.black.opacity(0.9))
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded))
								.lineLimit(1)
								.padding(.leading, 10)
							Spacer()
						}
					}.padding(.horizontal, 5).frame(height: 40)
				}
			}.padding(10)
				.overlay(RoundedRectangle(cornerRadius: 10)
					.stroke(Color.secondary
						.opacity(0.7), lineWidth: 1).padding(1))

			VStack {
				Section {
					NavigationLink(destination: SelectedServiceDetailView(serviceType: serviceType)) {
						HStack {
							Text("Full service contract")
								.foregroundColor(Color.black)
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded)).padding(.leading, 10)
							Spacer()
							Image(systemName: "chevron.right")
								.foregroundColor(Color.accentColor)
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 20, weight: .regular, design: .rounded))
								.padding(.leading, 10)
						}
					}
				}.padding(.horizontal, 5).frame(height: 40)
			}.padding(7)
				.overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(Color.lightGray))
				.padding(1)

			Rectangle().foregroundColor(.white).ignoresSafeArea(.container, edges: .horizontal)
				.overlay {
					VStack {
						Spacer()
						Button(action: {
							self.choisedServices.insert(serviceType)
							self.presentationMode.wrappedValue.dismiss()
						}) {
							HStack {
								Text("Add")
									.withDoneButtonStyles(backColor: .white, accentColor: .accentColor)
							}
						}
						.ignoresSafeArea(.keyboard, edges: .bottom)
					}.padding(.vertical, 15)
				}.ignoresSafeArea(.keyboard, edges: .bottom)
			Spacer()
		}.padding(.horizontal, 20).padding(.top, 10)
			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle("Provided service")
			.toolbar {
				ToolbarItem(placement: .keyboard) {
					HStack {
						Spacer()
						Button("Done") { isFocused = false }
					}
				}
			}
	}
}

struct ProviderAddServicesView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ProviderAddServicesView(choisedServices: .constant([.CompleteHome]), serviceType: .Kitchen)
		}.previewDevice("iPhone 6s")
	}
}
