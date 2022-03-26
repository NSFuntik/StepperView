//
//  ProviderWorkingSceduleView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProviderWorkingSceduleView: View {
	@Binding var provider: Provider
	@State var isPickedDate = false
	@State private var addNewValue = false
	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		VStack {
			ScrollView(showsIndicators: false) {
				HStack {
					Text("WORKING HOURS")
						.foregroundColor(Color.pickerTitle)
						.font(Font.system(size: 17,
						                  weight: .regular,
						                  design: .rounded))
						.padding(.leading, 15)
					Spacer()
				}.padding(.bottom, -5)

				Group {
					VStack {
						ForEach($provider.workingHours, id: \.self) { day in
							if day.wrappedValue == $provider.workingHours.wrappedValue.first {
								Section {
									VStack(alignment: .center) {
										HStack {
											HStack {
												Button {
													if day.isActive.wrappedValue {
														if day.isMultipleRange.wrappedValue == false {
															$provider.workingHours.wrappedValue.append(WorkHours(weekDay: day.weekDay.wrappedValue, from: "00:00", to: "00:00", isMultipleRange: false, isActive: false))
															$provider.workingHours.wrappedValue = $provider.workingHours.wrappedValue.filter { subday in
																if subday.isMultipleRange == true {
																	return subday.weekDay != day.weekDay.wrappedValue
																} else {
																	return true
																}
															}
														}
														$provider.workingHours.wrappedValue = $provider.workingHours.wrappedValue.filter { $0 != day.wrappedValue }
														$provider.workingHours.wrappedValue = $provider.workingHours.wrappedValue.sorted(by: { $0.id < $1.id })
														addNewValue = true
													}
													//                                                }
												} label: {
													Image(systemName: "minus.circle")
														.resizable()
														.scaledToFit()
														.foregroundColor(.yellow.opacity(0.9))
														.frame(width: 20, height: 20, alignment: .center)
														.padding(5)
												}
												if day.isMultipleRange.wrappedValue == false {
													Text("\(day.weekDay.shortTitle.wrappedValue)")
														.foregroundColor(Color.black.opacity(0.9))
														.multilineTextAlignment(.center)
														.font(Font.system(size: 20, weight: .regular, design: .rounded))
														.lineLimit(1)
														.frame(width: 50, alignment: .leading)
												} else {
													Text("\(day.weekDay.shortTitle.wrappedValue)")
														.foregroundColor(Color.white.opacity(0.9))
														.multilineTextAlignment(.center)
														.font(Font.system(size: 20, weight: .regular, design: .rounded))
														.lineLimit(1)
														.frame(width: 50, alignment: .leading)
												}
												Spacer()
												//
												ZStack(alignment: .center) {
													HStack {
														Spacer()
														Text("from")
															.foregroundColor(Color.secondary.opacity(0.9))
															.multilineTextAlignment(.leading)
															.font(Font.system(size: 20, weight: .semibold, design: .rounded)).frame(width: 60, alignment: .center)
															.offset(x: 0, y: -40)
														Spacer()
													}.padding(.top, 10)
													DatePicker(
														"",
														selection: Binding(get: {
															getDate(from: day.from, "HH:mm").wrappedValue
														}, set: { newValue in
															day.from.wrappedValue = getString(from: newValue, "HH:mm")
														}),
														displayedComponents: .hourAndMinute).disabled(!day.wrappedValue.isActive)
												}
												Spacer()
												ZStack(alignment: .center) {
													HStack {
														Spacer()
														Text(" to  ")
															.foregroundColor(Color.secondary.opacity(0.9))
															.multilineTextAlignment(.center)
															.font(Font.system(size: 20, weight: .semibold, design: .rounded)).frame(width: 60, alignment: .leading).offset(x: -1, y: -40)
														Spacer()
													}.padding(.top, 10)
													DatePicker(
														"",
														selection: Binding(get: {
															getDate(from: day.to, "HH:mm").wrappedValue
														}, set: { newValue in
															day.to.wrappedValue = getString(from: newValue, "HH:mm")
														}),
														displayedComponents: .hourAndMinute).disabled(!day.wrappedValue.isActive)
												}
											}.opacity(day.isActive.wrappedValue ? 1.0 : 0.2)
											Button {
												if day.isActive.wrappedValue == true {
													$provider.workingHours.wrappedValue.append(WorkHours(weekDay: day.weekDay.wrappedValue, from: day.to.wrappedValue, to: "20:00", isMultipleRange: true))
													$provider.workingHours.wrappedValue = $provider.workingHours.wrappedValue.sorted(by: { $0.id < $1.id })
													addNewValue = true
												} else {
													day.isActive.wrappedValue = true
												}

											} label: {
												Image(systemName: "plus.circle")
													.resizable()
													.scaledToFit()
													.frame(width: 20, height: 20, alignment: .center)
													.padding(5).padding(.trailing, -5).transition(.identity)
											}

										}.padding(.horizontal, 5).padding(.top, 5).frame(height: 40)
									}
								}
							} else {
								Section {
									if day.isMultipleRange.wrappedValue == false {
										Divider().padding(.horizontal, -10).padding(.leading, 15)
									}
									HStack {
										HStack {
											Button {
												if day.isActive.wrappedValue {
													if day.isMultipleRange.wrappedValue == false {
														$provider.workingHours.wrappedValue.append(WorkHours(weekDay: day.weekDay.wrappedValue, from: "00:00", to: "00:00", isMultipleRange: false, isActive: false))
														$provider.workingHours.wrappedValue = $provider.workingHours.wrappedValue.filter { subday in
															if subday.isMultipleRange == true {
																return subday.weekDay != day.weekDay.wrappedValue
															} else {
																return true
															}
														}
													}
													$provider.workingHours.wrappedValue = $provider.workingHours.wrappedValue.filter { $0 != day.wrappedValue }
													$provider.workingHours.wrappedValue = $provider.workingHours.wrappedValue.sorted(by: { $0.id < $1.id })
													addNewValue = true
												}
												//                                                }
											} label: {
												Image(systemName: "minus.circle")
													.resizable()
													.scaledToFit()
													.foregroundColor(.yellow.opacity(0.9))
													.frame(width: 20, height: 20, alignment: .center)
													.padding(5)
											}
											if day.isMultipleRange.wrappedValue == false {
												Text("\(day.weekDay.shortTitle.wrappedValue)")
													.foregroundColor(Color.black.opacity(0.9))
													.multilineTextAlignment(.leading)
													.font(Font.system(size: 20, weight: .regular, design: .rounded))
													.lineLimit(1)
													.frame(width: 50, alignment: .leading)
											} else {
												Text("\(day.weekDay.shortTitle.wrappedValue)")
													.foregroundColor(Color.white.opacity(0.9))
													.multilineTextAlignment(.leading)
													.font(Font.system(size: 20, weight: .regular, design: .rounded))
													.lineLimit(1)
													.frame(width: 50, alignment: .leading)
											}
											Spacer()
											DatePicker(
												"",
												selection: Binding(get: {
													getDate(from: day.from, "HH:mm").wrappedValue
												}, set: { newValue in
													day.from.wrappedValue = getString(from: newValue, "HH:mm")
												}),
												displayedComponents: .hourAndMinute).disabled(!day.isActive.wrappedValue)
											Spacer()
											DatePicker(
												"",
												selection: Binding(get: {
													getDate(from: day.to, "HH:mm").wrappedValue
												}, set: { newValue in
													day.to.wrappedValue = getString(from: newValue, "HH:mm")
												}),
												displayedComponents: .hourAndMinute).disabled(!day.isActive.wrappedValue)
										}.opacity(day.isActive.wrappedValue ? 1.0 : 0.2)
										Button {
											if day.isActive.wrappedValue == true {
												$provider.workingHours.wrappedValue.append(WorkHours(weekDay: day.weekDay.wrappedValue, from: day.to.wrappedValue, to: "20:00", isMultipleRange: true))
												$provider.workingHours.wrappedValue = $provider.workingHours.wrappedValue.sorted(by: { $0.id < $1.id })
												addNewValue = true
											} else {
												day.isActive.wrappedValue = true
											}

										} label: {
											Image(systemName: "plus.circle")
												.resizable()
												.scaledToFit()
												.frame(width: 20, height: 20, alignment: .center)
												.padding(5).padding(.trailing, -5).transition(.identity)
										}

									}.padding(.horizontal, 5).frame(height: 40)
								}
							}
						}
					}
				}.padding(10).padding(.top, 20)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))

				HStack {
					Text("TIME OFF")
						.foregroundColor(Color.pickerTitle)
						.font(Font.system(size: 17,
						                  weight: .regular,
						                  design: .rounded))
						.padding(.leading, 15)
					Spacer()
					Button {
						if $provider.offTime.last?.isActive.wrappedValue == true {
							$provider.offTime.wrappedValue.append(OffTime(from: $provider.offTime.wrappedValue.last?.to ?? "01/01/22 00:00", to: $provider.offTime.wrappedValue.last?.to ?? "01/01/22 12:00", isMultipleRange: true))
							$provider.offTime.wrappedValue = $provider.offTime.wrappedValue.sorted(by: { $0.id < $1.id })
							addNewValue = true
						} else {
							$provider.offTime.last?.isActive.wrappedValue = true
						}
					} label: {
						Text("ADD")
							.foregroundColor(Color.accentColor)
							.font(Font.system(size: 17,
							                  weight: .regular,
							                  design: .rounded))
							.padding(.trailing, 15)
					}
				}.padding(.bottom, -5).padding(.top, 10)
				Group {
					VStack {
						ForEach($provider.offTime, id: \.self) { offTime in
							Section {
								VStack {
									VStack {
										Section {
											HStack {
												Text("from")
													.foregroundColor(Color.black.opacity(0.9))
													.multilineTextAlignment(.leading)
													.font(Font.system(size: 20, weight: .medium, design: .rounded)).padding(.leading, 37)
												Spacer()
												DatePicker(
													"",
													selection: Binding(get: {
														getDate(from: offTime.from, "dd/MM/yy HH:mm").wrappedValue
													}, set: { newValue in
														offTime.from.wrappedValue = getString(from: newValue, "dd/MM/yy HH:mm")
														let toDate = getDate(from: offTime.to, "dd/MM/yy HH:mm").wrappedValue
														let fotmatter = DateFormatter()
														fotmatter.dateFormat = "MMdd"
														let fromDay = Int(fotmatter.string(from: newValue))!
														let toDay = Int(fotmatter.string(from: toDate))!
														if toDay < fromDay {
															offTime.to.wrappedValue = getString(from: newValue, "dd/MM/yy HH:mm")
														}
														//                                                        offTime.wrappedValue = offTime.id.update(offTime).wrappedValue
														$provider.offTime.wrappedValue = $provider.offTime.wrappedValue.sorted(by: { $0.id < $1.id })
													}),
													displayedComponents: [.date, .hourAndMinute])
											}.padding(.horizontal, 5).frame(height: 40).disabled(!offTime.isActive.wrappedValue)
											ZStack {
												Divider().padding(.horizontal, -10).padding(.leading, 25)
												HStack {
													Button {
														if offTime.isActive.wrappedValue {
															if offTime.isMultipleRange.wrappedValue == false {
																if $provider.offTime.wrappedValue.count == 1 {
																	$provider.offTime.wrappedValue.append(OffTime(from: $provider.offTime.wrappedValue.last?.to ?? getString(from: Date(), "dd/MM/yy HH:mm"), to: $provider.offTime.wrappedValue.last?.to ?? getString(from: Date(), "dd/MM/yy HH:mm"), isMultipleRange: false, isActive: false))
																} else {
																	$provider.offTime[1].wrappedValue.isMultipleRange = false
																}
															}
															$provider.offTime.wrappedValue = $provider.offTime.wrappedValue.filter { $0 != offTime.wrappedValue }
															$provider.offTime.wrappedValue = $provider.offTime.wrappedValue.sorted(by: { $0.id < $1.id })
															addNewValue = true
														}
													} label: {
														Image(systemName: "minus.circle")
															.resizable()
															.scaledToFit()
															.foregroundColor(.yellow.opacity(0.9))
															.frame(width: 20, height: 20, alignment: .trailing)
															.background(.white)
													}
													Spacer()
												}.padding(.horizontal, 10).padding(.vertical, -5)
											}
										}
										Section {
											HStack {
												Text("to")
													.foregroundColor(Color.black.opacity(0.9))
													.multilineTextAlignment(.leading)
													.font(Font.system(size: 20, weight: .medium, design: .rounded)).padding(.leading, 37)
												Spacer()
												DatePicker(
													"",
													selection: Binding(get: {
														getDate(from: offTime.to, "dd/MM/yy HH:mm").wrappedValue
													}, set: { newValue in
														offTime.to.wrappedValue = getString(from: newValue, "dd/MM/yy HH:mm")
														//                                                        offTime.wrappedValue = offTime.id.update(offTime).wrappedValue
														//                                                        $provider.offTime.wrappedValue = $provider.offTime.wrappedValue.sorted(by: {return $0.id < $1.id})

													}),
													in: getDate(from: offTime.from, "dd/MM/yy HH:mm").wrappedValue...,
													displayedComponents: [.date, .hourAndMinute])

											}.padding(.horizontal, 5).frame(height: 40).disabled(!offTime.isActive.wrappedValue)
										}
									}

									Divider().padding(.horizontal, -9).padding(.trailing, -20)
								}

							}.opacity(offTime.isActive.wrappedValue ? 1.0 : 0.2)
								.transition(.opacity)
								.animation(Animation.easeInOut, value: offTime.wrappedValue)
						}
					}.padding(.bottom, -11)
				}.padding(10)
					.clipShape(RoundedRectangle(cornerRadius: 10))
					.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))
				Spacer()
			}
		}.padding(.horizontal, 20).padding(.top, 10)
			.toolbar {
				Button("Save", role: .destructive) {
					self.presentationMode.wrappedValue.dismiss()
				}
			}
			.navigationTitle("Working schedule").navigationBarTitleDisplayMode(.inline)
	}
}

func getDate(from dateString: Binding<String>, _ dateFormat: String) -> Binding<Date> {
	let formatter = DateFormatter()
	formatter.dateFormat = dateFormat
	formatter.amSymbol = ""
	formatter.pmSymbol = ""
	let date: Binding<Date> = Binding(projectedValue: State(initialValue: formatter.date(from: dateString.wrappedValue)!).projectedValue)

	return date
}

func getString(from date: Date, _ dateFormat: String) -> String {
	let formatter = DateFormatter()
	formatter.dateFormat = dateFormat
	let string: String = formatter.string(from: date)

	return string
}

struct ProviderWorkingSceduleView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ProviderWorkingSceduleView(provider: .constant(testProvider))
		}.previewDevice("iPhone 6s")
	}
}

// "dd/MM/yyyy HH:mm"
