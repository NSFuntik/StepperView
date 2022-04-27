//
//  VisitsScedulerView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct VisitsScedulerView: View {
    // MARK: Lifecycle

    init() {
        week = Date().daysOfWeek
        dateFormatter.dateFormat = "dd/MM/yyyy"
    }

    // MARK: Internal

    @State var pickedTimeline: String = ""
    @State var pickedFirstVisitTimeline: String = ""
    @State var pickedSecondVisitTimeline: String = ""
    @State var pickedThirdVisitTimeline: String = ""
    @State var weekOffset: Int = 0
    @State var week: [Date]
    @State var showTwoWeeks = false

    var dateFormatter = DateFormatter()
    var weekDays = ["M", "T", "W", "T", "F", "S", "S", "M", "T", "W", "T", "F", "S", "S"]

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 30) {
                VStack {
                    HStack(alignment: .center, spacing: 20) {
                        Button {
                            weekOffset = weekOffset - 1
                            week = (0...13).compactMap {
                                Calendar.current.date(byAdding: .day,
                                                      value: $0,
                                                      to: Calendar.iso8601.date(
                                                        from: Calendar.iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                                                              from: Calendar.current.date(
                                                                                                byAdding: .weekOfYear,
                                                                                                value: weekOffset, to: Date())!))!)
                            }
                        } label: {
                            Image(systemName: "chevron.up")
                                .foregroundColor(Color.accentColor)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 25, weight: .regular, design: .rounded))
                                .padding(.leading, 10)
                        }
                        Button {
                            weekOffset = weekOffset + 1
                            week = (0...13).compactMap {
                                Calendar.current.date(byAdding: .day,
                                                      value: $0,
                                                      to: Calendar.iso8601.date(
                                                        from: Calendar.iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear],
                                                                                              from: Calendar.current.date(
                                                                                                byAdding: .weekOfYear,
                                                                                                value: weekOffset, to: Date())!))!)
                            }
                        } label: {
                            Image(systemName: "chevron.down")
                                .foregroundColor(Color.accentColor)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 25, weight: .regular, design: .rounded))
                                .padding(.leading, 10)
                        }
                        Spacer()
                        Text("Show two weeks")
                            .foregroundColor(Color.lightGray.opacity(0.9))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 14, weight: .regular, design: .rounded))
                        Toggle("", isOn: $showTwoWeeks)
                            .frame(width: 30)
                            .padding(.trailing, 15)
                    }.padding(5).frame(height: 50)
                    Divider().padding(.horizontal, -10).padding(.leading, 25)

                    weekView

                }.padding(10).padding(.bottom, -10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))
                Group {
                    VStack {
                        HStack {
                            Text("First visit: ")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 18, weight: .regular, design: .rounded))
                                .padding(.leading, 10)
                            Spacer()
                            Text(pickedFirstVisitTimeline)
                                .foregroundColor(Color.lightGray)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                        }.padding(5)
                        Divider().padding(.horizontal, -10).padding(.leading, 25)
                        HStack {
                            Text("Last visit: ")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                .padding(.leading, 10)
                            Spacer()
                            Text(pickedSecondVisitTimeline == "" ? pickedThirdVisitTimeline : pickedSecondVisitTimeline)
                                .foregroundColor(Color.lightGray)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                        }.padding(5).padding(.bottom, 10)
                    }.padding(10).padding(.bottom, -10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))
                }

                HStack(alignment: .top, spacing: 20) {
                    Image(systemName: "info.circle")
                        .foregroundColor(Color.infoBlue)
                        .font(Font.system(size: 25, weight: .regular, design: .rounded))
                    Text("You can schedule 3 visits per day, within two weeks")
                        .foregroundColor(Color.infoBlue)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                }

            }.padding(20)
            Spacer(minLength: 100)
        }.navigationBarTitle("Visits").navigationBarTitleDisplayMode(.inline)
            .toolbar {
                HStack {
                    Spacer()
                    Button {
                        pickedFirstVisitTimeline = ""
                        pickedSecondVisitTimeline = ""
                        pickedThirdVisitTimeline = ""
                    } label: {
                        Text("Clear All")
                            .foregroundColor(Color.orange)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    }
                }
            }
    }

    var weekView: some View {
        ForEach(showTwoWeeks ? 0..<week.count : 0..<7, id: \.self) { i in
            Section {
                NavigationLink {
                    VisitTimeSelectorView(date: Binding(projectedValue: $week[i].projectedValue),
                                          pickedFVT: $pickedFirstVisitTimeline,
                                          pickedSecondVVT: $pickedSecondVisitTimeline,
                                          pickedThirdVT: $pickedThirdVisitTimeline)
                } label: {
                    HStack {
                        Text(week[i].formatted()
                            .replacingOccurrences(of: ", 0:00", with: ""))
                        .foregroundColor(Color.black.opacity(0.9))
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .lineLimit(1)
                        .padding(.leading, 10)
                        .frame(width: 120, alignment: .leading)

                        Text(weekDays[i])
                            .foregroundColor(Color.black.opacity(0.9))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            .lineLimit(1)
                            .padding(.leading, 10)
                        Spacer()
                        if pickedFirstVisitTimeline.contains(dateFormatter.string(from: week[i])) {
                            Text(pickedFirstVisitTimeline
                                .replacingOccurrences(of: dateFormatter.string(from: week[i]), with: ""))
                            .foregroundColor(Color.lightGray.opacity(0.9))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            .lineLimit(1)
                            .padding(.leading, 10)
                        } else if pickedSecondVisitTimeline.contains(dateFormatter.string(from: week[i])) {
                            Text(pickedSecondVisitTimeline
                                .replacingOccurrences(of: dateFormatter.string(from: week[i]), with: ""))
                            .foregroundColor(Color.lightGray.opacity(0.9))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            .lineLimit(1)
                            .padding(.leading, 10)
                        } else if pickedThirdVisitTimeline.contains(dateFormatter.string(from: week[i])) {
                            Text(pickedThirdVisitTimeline
                                .replacingOccurrences(of: dateFormatter.string(from: week[i]), with: ""))
                            .foregroundColor(Color.lightGray.opacity(0.9))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            .lineLimit(1)
                            .padding(.leading, 10)
                        }
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.accentColor)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                            .padding(.leading, 10)
                    }.padding(5)
                }
                Divider().padding(.horizontal, -10).padding(.leading, 25)
            }
        }
    }
}

struct VisitsScedulerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VisitsScedulerView()
        }
    }
}

extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}

extension Date {
    var startOfWeek: Date {
        return Calendar.iso8601.date(from: Calendar.iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }

    var daysOfWeek: [Date] {
        let startOfWeek = self.startOfWeek
        return (0...13).compactMap {
            Calendar.current.date(byAdding: .day, value: $0, to: startOfWeek)
        }
    }
}
