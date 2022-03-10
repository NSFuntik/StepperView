//
//  ContentView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
import Combine

struct IntroView: View {
	@State var address: String = "Enter new address"
	@State var selectedButton: Int = 0
	@State var isSearchEnabled = false

	var body: some View {
		NavigationView {
			VStack(alignment: .center, spacing: 10) {
				AddressSearchBarView
				HStack(alignment: .center, spacing: 0) {
					ServicesScrollView
						.padding([.top])
						.ignoresSafeArea(.all, edges: .bottom)
						.zIndex(1.0)

					Spacer(minLength: 50)
					ProfileChooserView
						.frame(width: .infinity, alignment: .trailing)
						.padding(.bottom, 10)
				}
			}.padding(.top, 10).padding(.horizontal, 20)
				.navigationBarTitle("").navigationBarHidden(true)
		}.environment(\.colorScheme, .light)
	}
}

extension IntroView {
	private var AddressSearchBarView: some View {
		NavigationLink(destination: AddressSearchView(address: $address)) {
			HStack(alignment: .center, spacing: 15, content: {
				Image("SearchIcon")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 24.0, height: 24.0, alignment: .center)
					.padding(.horizontal, 5)
				ZStack {
					Text(address == "" || address == "Enter new address" ? "Enter new address" : "")
						.foregroundColor(.lightGray.opacity(0.6))
						.font(.system(size: 16, weight: .regular, design: .rounded))
					Text(address)
						.foregroundColor(address == "Enter new address" ? .lightGray.opacity(0.6) : Color.init("Orange").opacity(1))
						.font(.system(size: 16, weight: .regular, design: .rounded))
				}
				Spacer()
			}).padding(10)
			.overlay(RoundedRectangle(cornerRadius: 10)
					.stroke(address == "Enter new address" || address == "" ? Color.lightGray.opacity(0.6) : Color.init("Orange")
					.opacity(0.8), lineWidth: 1))
		}
	}


	private var ServicesScrollView: some View {
		ScrollView(.vertical, showsIndicators: false) {
			ForEach(Services) { service in
				Button {
					selectedButton = service.id
				} label: {
					VStack {
						Image(service.image)
							.resizable()
							.aspectRatio(contentMode: .fit)
							.padding(10)
							.overlay(
								RoundedRectangle(cornerRadius: 10)
									.stroke(selectedButton == service.id ? Color.accentColor : Color.lightGray.opacity(0.6),
											lineWidth: selectedButton == service.id ? 2.0 : 1.5)
							).padding(.bottom, -3).padding(.top,2)
						Text(service.name)
							.foregroundColor(Color.black)
							.font(.system(size: 12.0, weight: .thin, design: .rounded))
					}.padding([.bottom, .horizontal], 1)
						.frame(maxWidth: 70)
				}
			}
		}
	}

	private var ProfileChooserView: some View {
		GeometryReader { geometry in

			VStack(alignment: .trailing, spacing: 15) {
				NavigationLink(destination: EnrollmentInfoView()) {
					VStack(alignment: .center, spacing: 10) {
						Image("CustomerIntro")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.padding([.horizontal, .top], 5)
						Text("Request")
							.foregroundColor(.black)
							.font(.system(size: 16, weight: .medium,
										  design: .rounded))
					}.padding(.bottom, 10).padding(.horizontal,25)
						.overlay(
							RoundedRectangle(cornerRadius: 16)
								.stroke(Color.lightGray.opacity(0.5), lineWidth: 1))
				}
				NavigationLink(destination: ProviderSearchView()) {
					VStack(alignment: .center, spacing: 10) {
						Image("ProviderSearchIntro")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.padding([.horizontal, .top], 5)

						Text("Provider search")
							.foregroundColor(.black)
							.font(.system(size: 16, weight: .medium, design: .rounded))
							.lineLimit(1)
							.padding(.horizontal, -20)
					}.padding(.bottom, 10).padding(.horizontal,25)
						.overlay(RoundedRectangle(cornerRadius: 16)
							.stroke(address == "Enter new address" ? Color.lightGray.opacity(0.5) : Color.accentColor.opacity(0.6), lineWidth: 1))
				}
				NavigationLink(destination: EnrollmentInfoView()) {
					VStack(alignment: .center, spacing: 10) {
						Image("BecomeProviderIntro")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.padding([.horizontal, .top], 5)

						Text("Become a provider")
							.foregroundColor(.black)
							.font(.system(size: 16, weight: .medium, design: .rounded))
							.lineLimit(1)
							.padding(.horizontal, -20)
					}.padding(.bottom, 10).padding(.horizontal,25)
						.overlay(
							RoundedRectangle(cornerRadius: 16)
								.stroke(Color.lightGray.opacity(0.5), lineWidth: 1))
				}
			}.frame(maxWidth: geometry.size.width).padding([.top], 20)

		}.frame(maxWidth: .infinity)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		IntroView()
	}
}





