//
//  CustomerModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/16/22.
//

import Foundation

struct Customer: Hashable, Identifiable {
	// MARK: Lifecycle

    init(id: Int, name: String = "", middleMame: String = "", surname: String = "", maidenName: String = "", birthday: Date = Date(timeIntervalSince1970: .zero), phone: String = "", email: String = "", address: Address = Address(postcode: "", town: "", street: ""), languages: [Language] = [], verifications: [VerificationType] = [], familyRole: FamilyRole = .Single, avatar: String = "Avatar", reviews: [Review] = [], rating: Double = 5.0, distance: Double = 0.0, services: [CategoryService] = []
) {
        self.id = id
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
        self.distance = distance
        self.services = services
	}

	// MARK: Internal
    typealias ID = Int
    // MARK: Internal
    var id: Int
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
    var distance: Double
    var services: [CategoryService]

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

var testCustomer = Customer(id: 0, name: "Duncan",
                            middleMame: "",
                            surname: "McCleod",
                            maidenName: "",
                            birthday: getDate(from: "11/02/81")!,
                            phone: "+44 123456789",
                            email: "orgpork@mail.com",
                            address: Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "309", apt: "32", 55.95207, -3.19768),
                            languages: [Language.English, Language.French, Language.Germany],
                            verifications: [.IDs, .Phone, .Address], familyRole: FamilyRole.Brother, avatar: "ReviewAvatar",
                            reviews: testReviews,
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

let Customers: [Customer] = [
    Customer(id: 1, name: "Nat", middleMame: "", surname: "Bluesky", maidenName: "", birthday: getDate(from: "27/11/99")!, phone: "89990006666", email: "", address: Address(isBussinessOnly: true, postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "160", apt: "21", 55.95207, -3.19768), languages: [Language.English, Language.French, Language.Germany], verifications: [.IDs, .Phone, .Address], familyRole: .Brother, avatar: "ReviewAvatar", reviews: testReviews, rating: 4.7, distance: 12.5, services: [StaticCategories[10]!, StaticCategories[20]!, StaticCategories[30]!, StaticCategories[40]!, StaticCategories[50]!]),
    Customer(id: 2, name: "Rivka", middleMame: "", surname: "Zilberg", maidenName: "", birthday: getDate(from: "27/01/91")!, phone: "89990006666", email: "", address: Address(isBussinessOnly: true, postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "39", apt: "32", 55.95207, -3.19768), languages: [Language.English, Language.French, Language.Germany], verifications: [.IDs, .Phone, .Address], familyRole: .Brother, avatar: "ReviewAvatar", reviews: testReviews, rating: 4.7, distance: 0.3, services: [StaticCategories[10]!, StaticCategories[20]!, StaticCategories[30]!, StaticCategories[40]!, StaticCategories[50]!]),
    Customer(id: 3, name: "Shoshanna", middleMame: "", surname: "Dreyfus", maidenName: "", birthday: getDate(from: "27/11/99")!, phone: "89990006666", email: "", address: Address(isBussinessOnly: false, postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "100", apt: "", 55.95207, -3.19768), languages: [Language.English, Language.French, Language.Germany], verifications: [.IDs, .Phone, .Address], familyRole: .Brother, avatar: "ReviewAvatar", reviews: testReviews, rating: 4.7, distance: 1.2, services: [StaticCategories[10]!, StaticCategories[20]!, StaticCategories[30]!, StaticCategories[40]!, StaticCategories[50]!]),
    Customer(id: 4, name: "Rivka", middleMame: "", surname: "Zilberg", maidenName: "", birthday: getDate(from: "27/11/99")!, phone: "89990006666", email: "", address: Address(isBussinessOnly: true, postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "50", apt: "32", 55.95207, -3.19768), languages: [Language.English, Language.French, Language.Germany], verifications: [.IDs, .Phone, .Address], familyRole: .Brother, avatar: "ReviewAvatar", reviews: testReviews, rating: 4.7, distance: 11, services: [StaticCategories[10]!, StaticCategories[20]!, StaticCategories[30]!, StaticCategories[40]!, StaticCategories[50]!]),
    Customer(id: 5, name: "Avi", middleMame: "", surname: "Patishon", maidenName: "", birthday: getDate(from: "27/11/99")!, phone: "89990006666", email: "", address: Address(isBussinessOnly: false, postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "90", apt: "", 55.95207, -3.19768), languages: [Language.English, Language.French, Language.Germany], verifications: [.IDs, .Phone, .Address], familyRole: .Brother, avatar: "ReviewAvatar", reviews: testReviews, rating: 4.7, distance: 4, services: [StaticCategories[10]!, StaticCategories[20]!, StaticCategories[30]!, StaticCategories[40]!, StaticCategories[50]!]),
    Customer(id: 6, name: "Pavel", middleMame: "", surname: "Richagov", maidenName: "", birthday: getDate(from: "27/11/99")!, phone: "89990006666", email: "", address: Address(isBussinessOnly: true, postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "75", apt: "32", 55.95207, -3.19768), languages: [Language.English, Language.French, Language.Germany], verifications: [.IDs, .Phone, .Address], familyRole: .Brother, avatar: "ReviewAvatar", reviews: testReviews, rating: 4.7, distance: 2.5, services: [StaticCategories[10]!, StaticCategories[20]!, StaticCategories[30]!, StaticCategories[40]!, StaticCategories[50]!]),



]
