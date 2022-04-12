//
//  ServiceConditionsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ServiceConditionsView: View {
	@State var isCustomerProvides = false
	@State var isNoCarpet = false
	@State var isNoExternalWindows = false
	@Binding var conditions: Set<String>

	var body: some View {
		VStack(alignment: .leading, spacing: 20) {
			VStack {
				Section {
					HStack {
						Toggle(isOn: $isCustomerProvides) {
							Text("Customer provides cleaning products")
								.foregroundColor(Color.black.opacity(0.9))
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded))
								.lineLimit(1)
								.padding(.leading, 10)
							Spacer()
						}
						.onChange(of: $isCustomerProvides.wrappedValue) { newValue in
							if newValue == true {
								$conditions.wrappedValue.insert("Customer provides cleaning products")
							} else {
								$conditions.wrappedValue =
									$conditions.wrappedValue.filter { $0 != "Customer provides cleaning products" }
							}
						}
					}.padding(.horizontal, 5).frame(height: 40)
				}
			}.padding(10)
				.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))
			HStack {
				Text("Customer provides all cleaning products like kitchen cleaner, bathroom cleaner, bleach, window and glass cleaner, disinfectant, oven cleaning liquid, limescale remover, etc.")
					.foregroundColor(Color.secondary)
					.multilineTextAlignment(.leading)
					.font(Font.system(size: 17, weight: .regular, design: .rounded))
				Spacer()
			}

			VStack {
				Section {
					HStack {
						Toggle(isOn: $isNoCarpet) {
							Text("No carpet cleaning")
								.foregroundColor(Color.black.opacity(0.9))
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded))
								.lineLimit(1)
								.padding(.leading, 10)
							Spacer()
						}
						.onChange(of: $isNoCarpet.wrappedValue) { newValue in
							if newValue == true {
								$conditions.wrappedValue.insert("No carpet cleaning")
							} else {
								$conditions.wrappedValue =
									$conditions.wrappedValue.filter { $0 != "No carpet cleaning" }
							}
						}
					}.padding(.horizontal, 5).frame(height: 40)
				}
			}.padding(10)
				.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))

			HStack {
				Text("Service person will not clean or hoover carpets")
					.foregroundColor(Color.secondary)
					.multilineTextAlignment(.leading)
					.font(Font.system(size: 17, weight: .regular, design: .rounded))
				Spacer()
			}
			VStack {
				Section {
					HStack {
						Toggle(isOn: $isNoExternalWindows) {
							Text("No cleaning of external-facing sides of windows")
								.foregroundColor(Color.black.opacity(0.9))
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded))
								.lineLimit(1)
								.padding(.leading, 10)
							Spacer()
						}
						.onChange(of: $isNoExternalWindows.wrappedValue) { newValue in
							if newValue == true {
								$conditions.wrappedValue.insert("No cleaning of external-facing sides of windows")
							} else {
								$conditions.wrappedValue =
									$conditions.wrappedValue.filter { $0 != "No cleaning of external-facing sides of windows" }
							}
						}
					}.padding(.horizontal, 5).frame(height: 40)
				}
			}.padding(10)
				.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))
			HStack {
				Text("Customer provides all cleaning products like kitchen cleaner, bathroom cleaner, bleach, window and glass cleaner, disinfectant, oven cleaning liquid, limescale remover, etc.")
					.foregroundColor(Color.secondary)
					.multilineTextAlignment(.leading)
					.font(Font.system(size: 17, weight: .regular, design: .rounded))
				Spacer()
			}
			Spacer()
		}.padding(.horizontal, 20).padding(.vertical, 10)
			.navigationTitle("Conditions")
			.navigationBarTitleDisplayMode(.inline)
			.onAppear {
				$isCustomerProvides.wrappedValue = conditions.contains("Customer provides cleaning products")
				$isNoCarpet.wrappedValue = conditions.contains("No carpet cleaning")
				$isNoExternalWindows.wrappedValue = conditions.contains("No cleaning of external-facing sides of windows")
			}
	}
}

struct ServiceConditionsView_Previews: PreviewProvider {
	static var previews: some View {
		ServiceConditionsView(conditions: .constant([]))
	}
}
