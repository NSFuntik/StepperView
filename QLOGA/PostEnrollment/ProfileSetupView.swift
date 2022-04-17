//
//  ProviderAccountSetupView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProfileSetupView: View {
	// MARK: Lifecycle

	init(actorType: Binding<ActorsEnum>, customer: Binding<Customer>, provider: Binding<Provider>) {
		UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "Accent Color")!
		self._customer = customer
		self._provider = provider
		self._actorType = actorType
//        self.selectedActor = self.actorType
	}
    @EnvironmentObject var tabController: TabController
	// MARK: Internal
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    @State var defaultActor: ActorsEnum = .QLOGA
	@Binding var actorType: ActorsEnum
	@Binding var customer: Customer
	@Binding var provider: Provider

	var body: some View {
		VStack {
			Picker("", selection: $actorType, content: {
				Text("Customer")
					.padding(5)
					.tag(ActorsEnum.CUSTOMER)
//					.onTapGesture {
//                        selectedActor = .CUSTOMER
//					}
				Text("Provider")
					.padding(5)
					.tag(ActorsEnum.PROVIDER)
//					.onTapGesture {
//                        selectedActor = .PROVIDER
//					}
			}).padding(2)
//				.onChange(of: $selectedActor.wrappedValue, perform: { newValue in
//					$actorType.wrappedValue = newValue
//                    $selectedActor.wrappedValue = newValue
//					print(selectedActor)
//				})
				.pickerStyle(SegmentedPickerStyle()) // <1>
			Image(actorType != .CUSTOMER ? "ProviderImage" : "CustomerImage")
				.resizable()
				.frame(width: 144, height: 144, alignment: .center)
				.aspectRatio(contentMode: .fit)
				.padding(20)
			ScrollView(showsIndicators: false) {
				VStack(alignment: .center, spacing: 20) {
					NavigationLink(destination: ProfileSettingsView(actorType: $actorType.wrappedValue, customer: $customer, provider: $provider)) {
						Label {
							Text("Settings")
								.foregroundColor(Color.black)
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded))
							Spacer()
							Image(systemName: "chevron.right")
								.foregroundColor(Color.accentColor)
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 20, weight: .regular, design: .rounded))
								.padding(.leading, 10)
						} icon: {
							Image("SettingsIcon")
								.resizable().aspectRatio(contentMode: .fit)
								.frame(height: 30, alignment: .center)
						}.padding(10)
							.overlay(RoundedRectangle(cornerRadius: 10)
								.stroke(lineWidth: 1.0)
								.foregroundColor(Color.lightGray))
							.padding(1)
					}

					if actorType != .CUSTOMER {
                        NavigationLink(destination: ProviderServicesView(provider: $provider).environmentObject(SelectService.shared)) {
							Label {
								Text("Services")
									.foregroundColor(Color.black)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 17, weight: .regular, design: .rounded))
								Spacer()
                                Text($provider.choicedServices.filter({ !$0.services.isEmpty }).count.description)
									.foregroundColor(Color.secondary)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 17, weight: .regular, design: .rounded))
								Image(systemName: "chevron.right")
									.foregroundColor(Color.accentColor)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 20, weight: .regular, design: .rounded))
									.padding(.leading, 10)
							} icon: {
								Image("ServicesIcon")
									.resizable().aspectRatio(contentMode: .fit)
									.frame(height: 30, alignment: .center)
							}.padding(10)
								.overlay(RoundedRectangle(cornerRadius: 10)
									.stroke(lineWidth: 1.0)
									.foregroundColor(Color.lightGray))
								.padding(1)
						}

						NavigationLink(destination: ProviderWorkingSceduleView(provider: $provider)) {
							Label {
								Text("Working hours & off time")
									.foregroundColor(Color.black)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 17, weight: .regular, design: .rounded))
								Spacer()
								Image(systemName: "chevron.right")
									.foregroundColor(Color.accentColor)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 20, weight: .regular, design: .rounded))
									.padding(.leading, 10)
							} icon: {
								Image("WorkHoursIcon")
									.resizable().aspectRatio(contentMode: .fit)
									.frame(height: 30, alignment: .center)
							}.padding(10)
								.overlay(RoundedRectangle(cornerRadius: 10)
									.stroke(lineWidth: 1.0)
									.foregroundColor(Color.lightGray))
								.padding(1)
						}

						NavigationLink(destination: ProviderPortfolioAlbumView(provider: $provider).padding(20)) {
							Label {
								Text("Portfolio")
									.foregroundColor(Color.black)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 17, weight: .regular, design: .rounded))
								Spacer()
								Image(systemName: "chevron.right")
									.foregroundColor(Color.accentColor)
									.multilineTextAlignment(.leading)
									.font(Font.system(size: 20, weight: .regular, design: .rounded))
									.padding(.leading, 10)
							} icon: {
								Image("PortfolioIcon-1")
									.resizable().aspectRatio(contentMode: .fit)
									.frame(height: 30, alignment: .center)
							}.padding(10)
								.overlay(RoundedRectangle(cornerRadius: 10)
									.stroke(lineWidth: 1.0)
									.foregroundColor(Color.lightGray))
								.padding(1)
						}
					}

                    NavigationLink(destination: ProfilePublicView(actorType: $actorType.wrappedValue, customer: $customer, provider: $provider)) {
						Label {
							Text("Show public profile")
								.foregroundColor(Color.black)
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 17, weight: .regular, design: .rounded))
							Spacer()
							Image(systemName: "chevron.right")
								.foregroundColor(Color.accentColor)
								.multilineTextAlignment(.leading)
								.font(Font.system(size: 20, weight: .regular, design: .rounded))
								.padding(.leading, 10)
						} icon: {
							Image("PublicProfileIcon")
								.resizable().aspectRatio(contentMode: .fit)
								.frame(height: 30, alignment: .center)
						}.padding(10)
							.overlay(RoundedRectangle(cornerRadius: 10)
								.stroke(lineWidth: 1.0)
								.foregroundColor(Color.lightGray))
							.padding(1)
					}
                    NavigationLink(destination: FAQView(provider: $provider, customer: $customer, actorType: .QLOGA)) {

                        Label {
                            Text("Frequently Asked Questions")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.accentColor)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                .padding(.leading, 10)
                        } icon: {
                            Image("QuestionsIcon")
                                .resizable().aspectRatio(contentMode: .fit)
                                .frame(height: 30, alignment: .center)
                        }.padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(Color.lightGray))
                            .padding(1)
                    }
                    NavigationLink(destination: ProfileTermsConditionsView(actorType: $actorType, customer: $customer, provider: $provider)) {
                        Label {
                            Text("\(actorType != .CUSTOMER ? "Provider" : "Customer")`s Terms & Conditions")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.accentColor)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                .padding(.leading, 10)
                        } icon: {
                            Image("TermsIcon")
                                .resizable().aspectRatio(contentMode: .fit)
                                .frame(height: 30, alignment: .center)
                        }.padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(Color.lightGray))
                            .padding(1)
                    }
				}
                Spacer(minLength: 50)
            }.ignoresSafeArea(.container, edges: .bottom)
		}.ignoresSafeArea(.container, edges: .bottom).padding(.horizontal, 20).padding(.top, 10)
			.onAppear {
                defaultActor = actorType
			}

			.navigationBarTitleDisplayMode(.inline)
			.navigationTitle("Your account")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                if defaultActor == actorType {
//                    actorType = selectedActor
                    self.mode.wrappedValue.dismiss()
                } else {
                    self.tabController.open(.orders)
//                    actorType = selectedActor
                    self.mode.wrappedValue.dismiss()
                }
            }){
                HStack {
                    Image(systemName: "chevron.left").foregroundColor(.accentColor)
                        .aspectRatio(contentMode: .fit)
                    if defaultActor == actorType {
                        Text("Back").foregroundColor(.accentColor)
                    } else {
                        Text("Orders").foregroundColor(.accentColor).bold()

                    }
//                    Text(defaultActor == actorType ? "Back" : "Orders").foregroundColor(.accentColor)
                }
            })
            .gesture(DragGesture().updating($dragOffset, body: { (value, state, transaction) in
                if(value.startLocation.x < 20 && value.translation.width > 100) {
                    self.mode.wrappedValue.dismiss()
                }

            }))
	}

	// MARK: Private

//	@State var selectedActor = ActorsEnum.QLOGA
}

struct ProviderAccountSetupView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ProfileSetupView(actorType: Binding(projectedValue: .constant(.PROVIDER)), customer: Binding(projectedValue: .constant(testCustomer)), provider: Binding(projectedValue: .constant(testProvider)))
		}.previewDevice("iPhone 6s")
	}
}
