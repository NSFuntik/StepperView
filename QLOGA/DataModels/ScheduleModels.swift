//
//  DayOfWeek.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/18/22.
//

import Foundation

enum DayOfWeek: Int, CaseIterable, Identifiable, Hashable, Equatable {
	case MONDAY
	case TUESDAY
	case WEDNESDAY
	case THURSDAY
	case FRIDAY
	case SATURDAY
	case SUNDAY

	// MARK: Internal

	var id: Int { self.rawValue }
	var title: String {
		switch self {
			case .MONDAY:
				return "MONDAY"
			case .TUESDAY:
				return "TUESDAY"
			case .WEDNESDAY:
				return "WEDNESDAY"
			case .THURSDAY:
				return "THURSDAY"
			case .FRIDAY:
				return "FRIDAY"
			case .SATURDAY:
				return "SATURDAY"
			case .SUNDAY:
				return "SUNDAY"
		}
	}

	var shortTitle: String {
		get {
			switch self {
				case .MONDAY:
					return "MON"
				case .TUESDAY:
					return "TUE"
				case .WEDNESDAY:
					return "WED"
				case .THURSDAY:
					return "THU"
				case .FRIDAY:
					return "FRI"
				case .SATURDAY:
					return "SAT"
				case .SUNDAY:
					return "SUN"
			}
		} set {

			if !newValue.isEmpty { self.shortTitle = newValue }
		}
	}
}

struct WorkHours: Identifiable, Hashable, Equatable {
	// MARK: Lifecycle

	init(weekDay: DayOfWeek, from: String = "09:00", to: String = "17:00", isMultipleRange: Bool = false, isActive: Bool = true) {
		self.weekDay = weekDay
		self.id = self.weekDay.id
		self.from = from
		self.to = to
		self.isMultipleRange = isMultipleRange
		self.isActive = isActive
	}

	// MARK: Internal

	var id: Int

	var weekDay: DayOfWeek
	var from: String
	var to: String
	var isMultipleRange: Bool
	var isActive: Bool
}

var defaultWorkingHours = [
	WorkHours(weekDay: .MONDAY, from: "09:00", to: "17:00"),
	WorkHours(weekDay: .TUESDAY, from: "09:00", to: "17:00"),
	WorkHours(weekDay: .WEDNESDAY, from: "09:00", to: "17:00"),
	WorkHours(weekDay: .THURSDAY, from: "09:00", to: "17:00"),
	WorkHours(weekDay: .FRIDAY, from: "09:00", to: "17:00"),
	WorkHours(weekDay: .SATURDAY, from: "09:00", to: "17:00"),
	WorkHours(weekDay: .SUNDAY, from: "09:00", to: "17:00")
]

struct OffTime: Identifiable, Hashable, Equatable {
	// MARK: Lifecycle

	init(from: String, to: String, isMultipleRange: Bool = false, isActive: Bool = true) {
		self.from = from
		self.to = to
		self.isMultipleRange = isMultipleRange
		self.isActive = isActive
	}

	// MARK: Internal

	var from: String
	var to: String
	var isMultipleRange: Bool
	var isActive: Bool

	var id: Int {
		let fotmatter = DateFormatter()
		fotmatter.dateFormat = "dd/MM/yy HH:mm"
		let fromDate = fotmatter.date(from: self.from)!
//		let toDate = fotmatter.date(from: self.to)!
		fotmatter.dateFormat = "MMdd"
		let fromDay = Int(fotmatter.string(from: fromDate))!
		//            let toDay = Int(fotmatter.string(from: toDate))!

		return fromDay
	}
}




// extension Int {
//    func update(_ offTime:  Binding<OffTime>) -> Binding<OffTime> {
//        let fotmatter = DateFormatter()
//        fotmatter.dateFormat = "dd/MM/yy HH:mm"
//        let fromDate = fotmatter.date(from: offTime.from.wrappedValue)!
//        let toDate = fotmatter.date(from: offTime.to.wrappedValue)!
//        fotmatter.dateFormat = "MMdd"
//        let fromDay = Int(fotmatter.string(from: fromDate))!
//        let toDay = Int(fotmatter.string(from: toDate))!
//        offTime.id.wrappedValue = fromDay
//        offTime.wrappedValue =  OffTime(from: offTime.from.wrappedValue, to: fromDay > toDay ? offTime.from.wrappedValue : offTime.to.wrappedValue, isMultipleRange: offTime.isMultipleRange.wrappedValue, isActive: offTime.isMultipleRange.wrappedValue)
//        //        let updated:  Binding<OffTime>? = Binding.init(get: {
//        //            OffTime(from: offTime.from.wrappedValue, to: fromDay > toDay ? offTime.from.wrappedValue : offTime.to.wrappedValue, isMultipleRange: offTime.isMultipleRange.wrappedValue, isActive: offTime.isMultipleRange.wrappedValue)
//        //
//        //        }, set: {_ in })
//        return offTime
//    }
// }
