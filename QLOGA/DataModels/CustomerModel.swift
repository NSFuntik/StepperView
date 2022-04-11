//
//  CustomerModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/16/22.
//

import Foundation

struct Customer: Hashable {
	// MARK: Lifecycle

	init(name: String = "", middleMame: String = "", surname: String = "", maidenName: String = "", birthday: Date = Date(timeIntervalSince1970: .zero), phone: String = "", email: String = "", address: Address = Address(postcode: "", town: "", street: ""), languages: [Language] = [], verifications: [VerificationType] = [], familyRole: FamilyRole = .Single, avatar: String = "Avatar", reviews: [Review] = [], rating: Double = 5.0) {
		self.name = name
		self.middleMame = middleMame
		self.surname = surname
		self.maidenName = maidenName
		self.phone = phone
		self.email = email
		self.birthday = birthday
		self.address = address
		self.languages = languages
		self.verifications = verifications
		self.familyRole = familyRole
		self.avatar = avatar
		self.reviews = reviews
		self.rating = rating
	}

	// MARK: Internal

	var name: String
	var middleMame: String
	var surname: String
	var maidenName: String
	var birthday: Date
	var phone: String
	var email: String
	var address: Address
	var languages: [Language]
	var verifications: [VerificationType]
	var familyRole: FamilyRole
	var avatar: String
	var reviews: [Review]
	var rating: Double
}

let userCalendar = Calendar.current

// March 10, 1876: The day Alexander Graham Bell
// made the first phone call
// ---------------------------------------------
// 2
// DateComponents' full initializer method is very thorough, but very long.
let firstLandLineCallDateComponents = DateComponents(
	calendar: nil,
	timeZone: TimeZone(abbreviation: "GMT+3"),
	year: 1981,
	month: 2,
	day: 11)

// 309 Princes Street, , GB
var birthday = userCalendar.date(from: firstLandLineCallDateComponents)!

var testCustomer = Customer(name: "Duncan",
                            middleMame: "",
                            surname: "McCleod",
                            maidenName: "",
                            birthday: getDate(from: "11/02/81")!,
                            phone: "+44 123456789",
                            email: "orgpork@mail.com",
                            address: Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "309", apt: "", 55.95207, -3.19768),
                            languages: [Language.English, Language.French, Language.Germany],
                            verifications: [.IDs, .Phone, .Address], familyRole: FamilyRole.Brother, avatar: "ReviewAvatar",
                            reviews: [Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "Avatar", rate: 3.9, description: "Prompt payment, polite and respectful"),
                                      Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "WomanCleaner", rate: 4.6, description: "Prompt payment, polite and respectful"),
                                      Review(image: "Avatar", rate: 1.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "WomanCleaner", rate: 3.7, description: "Prompt payment, polite and respectful"),
                                      Review(image: "Avatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "Avatar", rate: 2.2, description: "Prompt payment, polite and respectful"),
                                      Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "Avatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                      Review(image: "WomanCleaner", rate: 4.1, description: "Prompt payment, polite and respectful")],
                            rating: 4.2)

enum Language: String, CaseIterable, Identifiable, Hashable {
	case English
	case French
	case Germany
	case Dutch
	case Spain
	case Hebrow

	// MARK: Internal

	var id: String { self.rawValue }
}

func getDate(from dateString: String) -> Date? {
	let formatter = DateFormatter()
	formatter.dateFormat = "dd/MM/yy"
	return formatter.date(from: dateString)
}

func getString(from date: Date) -> String {
	let formatter = DateFormatter()
	formatter.dateFormat = "dd/MM/yy"
	return formatter.string(from: date)
}

enum FamilyRole: String, CaseIterable, Identifiable, Hashable {
	case Mother
	case Dad
	case Sister
	case Brother
	case Single

	// MARK: Internal

	var id: String { self.rawValue }
}
