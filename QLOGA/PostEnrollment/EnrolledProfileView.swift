//
//  SuccessEnrollmenrModalView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct EnrolledProfileView: View {

	@State private var selectedTab = 0

    enum Tab: Int, CaseIterable, Identifiable {
        var id: Int { self.rawValue }
        case Orders
        case Quotes
        case Inquires
        case Requests
        case Today
		var description: String {
			switch self {
				case .Orders:
					return "Orders"
				case .Quotes:
					return "Quotes"
				case .Inquires:
					return "Inquires"
				case .Requests:
					return "Requests"
				case .Today:
					return "Today"
			}
		}
	}

	@ObservedObject var locationManager = LocationManager()
	@State var actorType: ActorsEnum
	@State var customer: Customer = testCustomer
	@State var provider: Provider = testProvider

	@State var isModalPresented = false
	@State var isFiltersPresented = false
	@State var isNotShowAgain = false

	var body: some View {
		VStack {
			ZStack {
				VStack {
					TabBarView(tabs: .constant([Tab.Orders.description, Tab.Quotes.description, Tab.Inquires.description, actorType != .CUSTOMER ? Tab.Requests.description : Tab.Today.description]),
					           selection: $selectedTab,
					           underlineColor: .accentColor) { title, isSelected in
						Text(title)
							.font(.system(size: 18, weight: .regular, design: .rounded))
							.ignoresSafeArea(.all, edges: .horizontal)
							.foregroundColor(isSelected ? .black : .lightGray)
					}
					VStack(alignment: .center) {
						Spacer()
						Image("\(actorType != .CUSTOMER ? "prv" : "cst")-\(Tab(rawValue: actorType != .CUSTOMER ? $selectedTab.wrappedValue : $selectedTab.wrappedValue + 1)!.description.lowercased())")
							.resizable()
							.frame(width: 300, height: 375, alignment: .center)
							.scaledToFit()
							.aspectRatio(1, contentMode: .fit)
						Spacer()
					}.frame(width: UIScreen.main.bounds.width)
						.background(Color.lightGray.opacity(0.2))

				}.disabled(isModalPresented)
				if isModalPresented {
                    infoModal
				}
			}
		}.padding(.horizontal, 20).padding(.top, 10)
			.toolbar {
                HStack(alignment: .center) {
//					Spacer()
					if actorType != .CUSTOMER {
						NavigationLink(destination: GoogleMapView(providers: .constant(
								[Address(postcode: "", town: "", street: "", -33.86, 151.20),
								 Address(postcode: "", town: "", street: "", -33.26, 151.24),
								 Address(postcode: "", town: "", street: "", -32.26, 151.34)]),
							pickedAddress: .constant(Address(postcode: "", town: "", street: "",
							                                 locationManager.latitude, locationManager.longitude)))) {
							Image("MapIcon")
								.resizable()
								.renderingMode(.template)
								.aspectRatio(contentMode: .fit)
								.foregroundColor(.accentColor)
								.frame(width: 30, height: 30, alignment: .trailing)
								.padding(5)
						}
                    } else {
                        Spacer()
                    }
                    NavigationLink(destination: ProfileSetupView(actorType: $actorType, customer: $customer, provider: $provider)) {
						Image("FilterIcon")
							.resizable()
							.renderingMode(.template)
							.aspectRatio(contentMode: .fit)
							.foregroundColor(.accentColor)
							.frame(width: 30, height: 30, alignment: .trailing)
							.padding(5)
					}
					NavigationLink(destination: ProfileSetupView(actorType: $actorType, customer: $customer, provider: $provider)) {
						Image(actorType != .CUSTOMER ? "ProviderProfileIcon" : "CustomerProfileIcon")
							.resizable()
							.renderingMode(.template)
							.aspectRatio(contentMode: .fit)
							.foregroundColor(.accentColor)
							.frame(width: 30, height: 30, alignment: .trailing)
							.padding(5)
					}
				}.disabled(isModalPresented)
			}
			.sheet(isPresented: $isFiltersPresented) { ProvidersFilterView().cornerRadius(35) }
			.navigationBarTitleDisplayMode(.inline)
	}
}

struct SuccessEnrollmenrModalView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			EnrolledProfileView(actorType: .CUSTOMER)
		}.previewDevice("iPhone 6s")
	}
}
extension EnrolledProfileView {
    var infoModal: some View {
        VStack(alignment: .center) {
            Spacer()
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .lightGray, radius: 3, x: 0, y: 1)
                .overlay {
                    VStack(alignment: .center, spacing: 15) {
                        Image(actorType != .CUSTOMER ? "ProviderImage" : "CustomerImage")
                            .resizable()
                            .frame(width: 144, height: 144, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .onTapGesture {
                                isModalPresented = false
                            }
                        HStack(alignment: .center, spacing: 0) {
                            Text("You entered to QLOGA as ")
                                .foregroundColor(.secondary)
                            Text(actorType != .CUSTOMER ? "Provider" : "Customer")
                                .foregroundColor(actorType != .CUSTOMER ? .providerColor : .accentColor)
                        }
                        .font(.system(size: 19, weight: .regular, design: .rounded))
                        HStack(alignment: .center) {
                            Text("To update your profile in the future click on icon")
                                .foregroundColor(.secondary.opacity(0.8))
                                .font(.system(size: 18, weight: .regular, design: .rounded))
                            Spacer()
                            Image(actorType != .CUSTOMER ? "ProviderProfileIcon" : "CustomerProfileIcon")
                                .resizable()
                                .frame(width: 30, height: 36, alignment: .bottom)
                                .scaledToFit()
                                .foregroundColor(actorType != .CUSTOMER ? .providerColor : .accentColor)
                        }.padding(.horizontal, 15)
                        HStack(alignment: .center, spacing: 15) {
                            Image(systemName: isNotShowAgain ? "checkmark.square.fill" : "square")
                                .foregroundColor(isNotShowAgain ? Color.accentColor : Color.lightGray)
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .onTapGesture {
                                    isNotShowAgain.toggle()
                                }
                            Text("Do not show me again")
                                .foregroundColor(.lightGray).lineLimit(1)
                                .font(.system(size: 17, weight: .regular, design: .rounded))
                        }
                        NavigationLink(destination: ProfileSetupView(actorType: $actorType, customer: $customer, provider: $provider)) {
                            RoundedRectangle(cornerRadius: 10).fill(Color.accentColor)
                                .frame(width: 172, height: 40, alignment: .center)
                                .overlay {
                                    Text("Go to profile")
                                        .foregroundColor(.white).lineLimit(1)
                                        .font(.system(size: 17, weight: .regular, design: .rounded))
                                }
                        }
                    }.padding(.horizontal, 20)
                }.frame(width: UIScreen.main.bounds.width - 40, height: 375, alignment: .center)
            Spacer().onTapGesture {
                isModalPresented = false
            }
        }
    }
}
