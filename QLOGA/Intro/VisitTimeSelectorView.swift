//
//  VisitTimeSelectorView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct VisitTimeSelectorView: View {
    // MARK: Lifecycle

    init(date: Binding<Date>, pickedFVT: Binding<String>, pickedSecondVVT: Binding<String>, pickedThirdVT: Binding<String>) {
        self._date = date
        self._pickedFirstVisitTimeline = pickedFVT
        self._pickedSecondVisitTimeline = pickedSecondVVT
        self._pickedThirdVisitTimeline = pickedThirdVT
    }

    // MARK: Internal

    var dateFormatter = DateFormatter()
    @State var isDropFirst = false
    @State var isDropSecond = false
    @State var isDropThird = false
    @State var isSelectedHalfHour = false

    @State var isSelectedFirstVisit = false
    @State var isSelectedSecondVisit = false
    @State var isSelectedThirdVisit = false

    @State var selectedFirstVisit = ""
    @State var selectedSecondVisit = ""
    @State var selectedThirdVisit = ""
    @State var pickedVisit = ""

    @Binding var pickedFirstVisitTimeline: String
    @Binding var pickedSecondVisitTimeline: String
    @Binding var pickedThirdVisitTimeline: String
    var workingHours = 8 ... 17

    @Binding var date: Date
    @State var dateString: String = ""

    var hours: [String] {
        if $isSelectedHalfHour.wrappedValue {
            return ["00:30-01:30", "01:30-02:30", "02:30-03:30",
                    "03:30-04:30", "04:30-05:30", "05:30-06:30",
                    "05:30-06:30", "06:30-07:30", "07:30-08:30",
                    "08:30-09:30", "09:30-10:30", "10:30-11:30",
                    "11:30-12:30", "12:30-13:30", "13:30-14:30",
                    "14:30-15:30", "15:30-16:30", "16:30-17:30",
                    "17:30-18:30", "18:30-19:30", "20:30-21:30",
                    "21:30-22:30", "22:30-23:30", "23:30-00:30"]
        } else {
            return ["00:00-01:00", "01:00-02:00", "02:00-03:00",
                    "03:00-04:00", "04:00-05:00", "05:00-06:00",
                    "05:00-06:00", "06:00-07:00", "07:00-08:00",
                    "08:00-09:00", "09:00-10:00", "10:00-11:00",
                    "11:00-12:00", "12:00-13:00", "13:00-14:00",
                    "14:00-15:00", "15:00-16:00", "16:00-17:00",
                    "17:00-18:00", "18:00-19:00", "20:00-21:00",
                    "21:00-22:00", "22:00-23:00", "23:00-00:00"]
        }
    }

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text(dateString.capitalized)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .default))
                    .padding(15)
                Spacer()
                Text("● - Off Time")
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 15, weight: .regular, design: .default))
                    .padding(15)
            }.overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))
            HStack(alignment: .bottom) {
                Text("VISITS")
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .default))
                    .padding(.leading, 5)
                Spacer()
                if isDropFirst || isDropSecond || isDropThird {
                    Text(isSelectedHalfHour ? "SELECT AN HOUR" : "SELECT HALF AN HOUR")
                        .foregroundColor(Color.accentColor)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 15, weight: .regular, design: .default))
                        .onTapGesture {
                            $isSelectedHalfHour.wrappedValue.toggle()
                        }
                }
            }.padding(.horizontal, 15).padding(.bottom, -15)
            Group {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        DisclosureGroup(isExpanded: $isDropFirst) {
                            buttons.padding(.vertical, 10)
                        } label: {
                            HStack {
                                Text("First visit: ")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 18, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                                Spacer()
                                if selectedFirstVisit != "", isSelectedSecondVisit == false {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.red)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                        .onTapGesture {
                                            selectedFirstVisit = ""
                                            isSelectedFirstVisit = false
                                        }
                                }
                                Text(selectedFirstVisit)
                                    .foregroundColor(Color.lightGray)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 18, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                            }
                        }
                        Divider().padding(.horizontal, -10).padding(.leading, 25)

                        DisclosureGroup(isExpanded: $isDropSecond) {
                            buttonsSecondVisit.padding(.vertical, 10)
                        } label: {
                            HStack {
                                Text("Second visit: ")
                                    .foregroundColor(isSelectedFirstVisit ? Color.black : Color.lightGray)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 18, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                                Spacer()
                                if selectedSecondVisit != "", isSelectedThirdVisit == false {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.red)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                        .onTapGesture {
                                            selectedSecondVisit = ""
                                            isSelectedSecondVisit = false
                                        }
                                }
                                Text(selectedSecondVisit)
                                    .foregroundColor(Color.lightGray)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 18, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                            }
                        }.disabled(!isSelectedFirstVisit)
                        Divider().padding(.horizontal, -10).padding(.leading, 25)

                        DisclosureGroup(isExpanded: $isDropThird) {
                            buttonsThirdVisit.padding(.vertical, 10)
                        } label: {
                            HStack {
                                Text("Third visit: ")
                                    .foregroundColor(isSelectedSecondVisit ? Color.black : Color.lightGray)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                                Spacer()
                                if selectedThirdVisit != "" {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.red)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                        .onTapGesture {
                                            selectedThirdVisit = ""
                                            isSelectedThirdVisit = false
                                        }
                                }
                                Text(selectedThirdVisit)
                                    .foregroundColor(Color.lightGray)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 18, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                            }
                        }.disabled(!isSelectedSecondVisit)
                            .padding(.bottom, 10)
                    }.padding(10).padding(.bottom, -10)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))

                    HStack(alignment: .top, spacing: 20) {
                        Image(systemName: "info.circle")
                            .foregroundColor(Color.infoBlue)
                            .font(Font.system(size: 25, weight: .regular, design: .rounded))
                        Text("You can schedule 3 visits per day, within two weeks")
                            .foregroundColor(Color.infoBlue)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    }
                }
            }
        }.padding(.horizontal, 20).padding(.top, 10)
            .navigationTitle("Visits")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                dateFormatter.dateFormat = "dd/MM/yyyy EEEE"
                dateString = dateFormatter.string(from: date)
            }
            .onDisappear {
                if pickedFirstVisitTimeline == "" {
                    dateFormatter.dateFormat = "dd/MM/yyyy "
                    dateString = dateFormatter.string(from: date)
                    pickedFirstVisitTimeline.append(dateString)
                    pickedFirstVisitTimeline.append(contentsOf: selectedFirstVisit)
                    if selectedSecondVisit != "" {
                        pickedFirstVisitTimeline.append(contentsOf: ", ")
                        pickedFirstVisitTimeline.append(contentsOf: selectedSecondVisit)
                    }
                    if selectedThirdVisit != "" {
                        pickedFirstVisitTimeline.append(contentsOf: ", ")
                        pickedFirstVisitTimeline.append(contentsOf: selectedThirdVisit)
                    }
                } else if pickedSecondVisitTimeline == "" {
                    dateFormatter.dateFormat = "dd/MM/yyyy "
                    dateString = dateFormatter.string(from: date)
                    pickedSecondVisitTimeline.append(dateString)
                    pickedSecondVisitTimeline.append(contentsOf: selectedFirstVisit)
                    if selectedSecondVisit != "" {
                        pickedSecondVisitTimeline.append(contentsOf: ", ")
                        pickedSecondVisitTimeline.append(contentsOf: selectedSecondVisit)
                    }
                    if selectedThirdVisit != "" {
                        pickedSecondVisitTimeline.append(contentsOf: ", ")
                        pickedSecondVisitTimeline.append(contentsOf: selectedThirdVisit)
                    }
                } else if pickedThirdVisitTimeline == "" {
                    dateFormatter.dateFormat = "dd/MM/yyyy "
                    dateString = dateFormatter.string(from: date)
                    pickedThirdVisitTimeline.append(dateString)
                    pickedThirdVisitTimeline.append(contentsOf: selectedFirstVisit)
                    if selectedSecondVisit != "" {
                        pickedThirdVisitTimeline.append(contentsOf: ", ")
                        pickedThirdVisitTimeline.append(contentsOf: selectedSecondVisit)
                    }
                    if selectedThirdVisit != "" {
                        pickedThirdVisitTimeline.append(contentsOf: ", ")
                        pickedThirdVisitTimeline.append(contentsOf: selectedThirdVisit)
                    }
                }
            }
    }

    // MARK: Private

    private var buttons: some View {
        VStack {
            ForEach(0..<8) { x in
                HStack(alignment: .center, spacing: 10) {
                    ForEach(0..<3) { y in
                        Button {
                            if workingHours.contains(y + x*3) {
                                if isSelectedFirstVisit == false {
                                    isSelectedFirstVisit.toggle()
                                    selectedFirstVisit = hours[y + x*3]
                                    pickedVisit.append(selectedFirstVisit)
                                } else if isSelectedFirstVisit == true {
                                    pickedVisit = pickedVisit.replacingOccurrences(of: selectedFirstVisit, with: "")
                                    selectedFirstVisit = hours[y + x*3]
                                    pickedVisit.append(selectedFirstVisit)
                                }
                                self.$isDropFirst.wrappedValue.toggle()
                            }
                        } label: {
                            Text(hours[y + x*3])
                                .foregroundColor(workingHours.contains(y + x*3) ? Color.secondary : Color.white)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                .padding(5).padding(.vertical, 10)
                        }.frame(width: 105)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(workingHours.contains(y + x*3) ? Color.white : Color.lightGray))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedFirstVisit == hours[y + x*3] ? Color.Green.opacity(0.7) : Color.lightGray.opacity(0.7),
                                        lineWidth: 1.5).padding(1))
                    }
                }
            }
        }
    }

    private var buttonsSecondVisit: some View {
        VStack {
            ForEach(0..<8) { x in
                HStack(alignment: .center, spacing: 10) {
                    ForEach(0..<3) { y in
                        Button {
                            if workingHours.contains(y + x*3) {
                                if isSelectedSecondVisit == false {
                                    isSelectedSecondVisit.toggle()
                                    selectedSecondVisit = hours[y + x*3]
                                    pickedVisit.append(selectedSecondVisit)
                                } else if isSelectedSecondVisit == true {
                                    pickedVisit = pickedVisit.replacingOccurrences(of: selectedSecondVisit, with: "")
                                    selectedSecondVisit = hours[y + x*3]
                                    pickedVisit.append(selectedSecondVisit)
                                }
                                $isDropSecond.wrappedValue = false
                            }
                        } label: {
                            Text(hours[y + x*3])
                                .foregroundColor(workingHours.contains(y + x*3) ? Color.secondary : Color.white)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                .padding(5).padding(.vertical, 10)
                        }.frame(width: 105)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(workingHours.contains(y + x*3) ? Color.white : Color.lightGray))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedSecondVisit == hours[y + x*3] ? Color.Green.opacity(0.7) : Color.lightGray.opacity(0.7),
                                        lineWidth: 1.5).padding(1))
                    }
                }
            }
        }
    }

    private var buttonsThirdVisit: some View {
        VStack {
            ForEach(0..<8) { x in
                HStack(alignment: .center, spacing: 10) {
                    ForEach(0..<3) { y in
                        Button {
                            if workingHours.contains(y + x*3) {
                                if isSelectedThirdVisit == false {
                                    isSelectedThirdVisit.toggle()
                                    selectedThirdVisit = hours[y + x*3]
                                    pickedVisit.append(selectedThirdVisit)
                                } else if isSelectedThirdVisit == true {
                                    pickedVisit = pickedVisit.replacingOccurrences(of: selectedThirdVisit, with: "")
                                    selectedThirdVisit = hours[y + x*3]
                                    pickedVisit.append(selectedThirdVisit)
                                }
                                $isDropThird.wrappedValue = false
                            }
                        } label: {
                            Text(hours[y + x*3])
                                .foregroundColor(workingHours.contains(y + x*3) ? Color.secondary : Color.white)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                .padding(5).padding(.vertical, 10)
                        }.frame(width: 105)
                            .background(RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(workingHours.contains(y + x*3) ? Color.white : Color.lightGray))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedThirdVisit == hours[y + x*3] ? Color.Green.opacity(0.7) : Color.lightGray.opacity(0.7),
                                        lineWidth: 1.5).padding(1))
                    }
                }
            }
        }
    }
}

struct VisitTimeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VisitTimeSelectorView(date: .constant(Date()),
                                  pickedFVT: .constant(""),
                                  pickedSecondVVT: .constant(""),
                                  pickedThirdVT: .constant(""))
        }.previewDevice("iPhone 6s")
    }
}
