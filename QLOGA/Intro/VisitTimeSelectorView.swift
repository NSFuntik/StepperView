//
//  VisitTimeSelectorView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct VisitTimeSelectorView: View {
    var dateFormatter = DateFormatter()
    @State var isDropFirst = false
    @State var isDropSecond = false
    @State var isDropThird = false

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
    
    var hours = ["00:00-01:00", "01:00-02:00", "02:00-03:00",
                 "03:00-04:00", "04:00-05:00", "05:00-06:00",
                 "05:00-06:00", "06:00-07:00", "07:00-08:00",
                 "08:00-09:00", "09:00-10:00", "10:00-11:00",
                 "11:00-12:00", "12:00-13:00", "13:00-14:00",
                 "14:00-15:00", "15:00-16:00", "16:00-17:00",
                 "17:00-18:00", "18:00-19:00", "20:00-21:00",
                 "21:00-22:00", "22:00-23:00", "23:00-00:00"]
    var workingHours = 8...17

    @Binding var date: Date
    @State var dateString: String = ""

    init(date: Binding<Date>, pickedFVT: Binding<String>, pickedSecondVVT: Binding<String>, pickedThirdVT: Binding<String>) {
        self._date = date
        self._pickedFirstVisitTimeline = pickedFVT
        self._pickedSecondVisitTimeline = pickedSecondVVT
        self._pickedThirdVisitTimeline = pickedThirdVT
    }
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            HStack {
                Text(dateString.capitalized)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 19, weight: .regular, design: .default))
                    .padding(15)
                Spacer()
            }.overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary.opacity(0.7), lineWidth: 1).padding(1))
            HStack(alignment: .bottom) {
                Text("Visit Time")
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .default))
                Spacer()
                if isDropFirst || isDropSecond || isDropThird {
                    Text("● - Off time")
                        .foregroundColor(Color.lightGray)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 15, weight: .regular, design: .default))
                }
            }.padding(.horizontal, 5).padding(.bottom, -15)
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
                            .foregroundColor(Color(hex: "#4184B2"))
                            .font(Font.system(size: 25, weight: .regular, design: .rounded))
                        Text("You can schedule 3 visits per day, within two weeks")
                            .foregroundColor(Color(hex: "#4184B2"))
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    }
                }
            }
        }.padding(.horizontal, 20)
            .navigationTitle("Visits")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                dateFormatter.dateFormat = "dd/MM/yyyy EEEE"
                dateString = dateFormatter.string(from: date)

            }
            .onDisappear{
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
                                    isSelectedFirstVisit.toggle()
                                    pickedVisit = pickedVisit.replacingOccurrences(of: selectedFirstVisit, with: "")
                                    selectedFirstVisit = ""
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
                                .stroke(selectedFirstVisit == hours[y + x*3] ? Color.Green .opacity(0.7) : Color.lightGray .opacity(0.7),
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
                                    isSelectedSecondVisit.toggle()
                                    pickedVisit.replacingOccurrences(of: selectedSecondVisit, with: "")
                                    selectedSecondVisit = ""
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
                                .stroke(selectedSecondVisit == hours[y + x*3] ? Color.Green .opacity(0.7) : Color.lightGray .opacity(0.7),
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
                                    isSelectedThirdVisit.toggle()
                                    pickedVisit.replacingOccurrences(of: selectedThirdVisit, with: "")
                                    selectedThirdVisit = ""
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
                                .stroke(selectedThirdVisit == hours[y + x*3] ? Color.Green .opacity(0.7) : Color.lightGray .opacity(0.7),
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
            VisitTimeSelectorView(date: .constant( Date()),pickedFVT: .constant(""), pickedSecondVVT: .constant(""),pickedThirdVT: .constant(""))
        }
    }
}
