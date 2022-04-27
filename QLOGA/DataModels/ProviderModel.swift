//
//  ProviderModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Foundation
import SwiftUI
struct Provider: Hashable, Identifiable {
    // MARK: Lifecycle

    init(id: Int, isActive: Bool = true, name: String, greetings: String? = "", phone: String = "", email: String = "",
         address: Address = Address(postcode: "", town: "", street: ""), cancellation: Int, coverage: String = "", avatar: String = "Avatar",
         calloutCharge: Bool, distance: Double = 0.0, rating: Double, employment: ProviderType,
         portfolio: ProviderPublicPortfolio = ProviderPublicPortfolio(images: [], description: ""), verifications: [VerificationType] = [], reviews: [Review] = [],
         languages: [Language] = [], website: String = "", registrationDetails: String = "", businesInsuranceDetails: String = "", description: String = "",
         isPhoneVisible: Bool = true, isOffTimeVisible: Bool = true, choicedServices: [Service] = [],
         workingHours: [WorkHours] = defaultWorkingHours, offTime: [OffTime] = [OffTime(from: "11/02/22 11:00", to: "11/02/22 21:00")],
         portfolioFolders: [PortfolioFolder] = [], services: [CategoryService] = [])
    {
        self.id = id
        self.isActive = isActive
        self.greetings = greetings
        self.avatar = avatar
        self.name = name
        self.phone = phone
        self.email = email
        self.address = address
        self.cancellation = cancellation.description
        self.coverage = coverage
        self.calloutCharge = calloutCharge
        self.rating = rating
        self.distance = distance
        self.employment = employment
        self.portfolio = portfolio
        self.verifications = verifications
        self.reviews = reviews
        self.languages = languages
        self.website = website
        self.registrationDetails = registrationDetails
        self.businesInsuranceDetails = businesInsuranceDetails
        self.description = description
        self.isPhoneVisible = isPhoneVisible
        self.isOffTimeVisible = isOffTimeVisible
        self.choicedServices = choicedServices
        self.workingHours = workingHours
        self.offTime = offTime
        self.portfolioFolders = portfolioFolders
        self.services = services
    }
    typealias ID = Int
    // MARK: Internal
    var id: Int
    var isActive: Bool
    var greetings: String?
    var avatar: String
    var name: String
    var phone: String
    var email: String
    var address: Address
    var cancellation: String
    var coverage: String
    var calloutCharge: Bool
    var rating: Double
    var distance: Double
    var employment: ProviderType
    var portfolio: ProviderPublicPortfolio
    var verifications: [VerificationType]
    var reviews: [Review]
    var languages: [Language]
    var website: String
    var registrationDetails: String
    var businesInsuranceDetails: String
    var description: String
    var isPhoneVisible: Bool
    var isOffTimeVisible: Bool
//    var choicedCleaningServices: Set<ServiceCleaningType>
    var choicedServices: [Service]
    var workingHours: [WorkHours]
    var offTime: [OffTime]
    var portfolioFolders: [PortfolioFolder]
    var services: [CategoryService]

    func getPosition(item: Service) -> Int {

        for i in 0..<choicedServices.count {

            if (choicedServices[i].id == item.id){
                return i
            }

        }

        return 0
    }
}

extension Array {

    func mapToSet<T: Hashable>(_ transform: (Element) -> T) -> Set<T> {
        var result = Set<T>()
        for item in self {
            result.insert(transform(item))
        }
        return result
    }

}

extension RandomAccessCollection {
    func element(at index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }

        return self[index]
    }
}

struct ProviderPublicPortfolio: Hashable {
    // MARK: Lifecycle

    init(images: [String] = [], description: String = "") {
        self.images = images
        self.description = description
    }

    // MARK: Internal

    var images: [String]
    var description: String
}

enum VerificationType: String, CaseIterable, Identifiable, Hashable {
    case IDs
    case Address
    case Avatar
    case RegistrationCertificate
    case ProfessionalInsurance
    case Email
    case Phone
    case Passport

    // MARK: Internal

    var id: String { self.rawValue }
}

enum CertificationType: String, CaseIterable, Identifiable {
    case BasicDisclosure
    case ProtectingVulnerableGroups
    case DBS
    case RegistrationCertificate
    case AccessNI
    case none

    // MARK: Internal

    var id: String { self.rawValue }
}


enum ProviderType: String, CaseIterable, Identifiable {
    case All
    case Individual
    case Agency

    // MARK: Internal

    var id: String { self.rawValue }
}

var testProvider: Provider = .init(id: 0, isActive: true,
                                   name: "Duncan McCleod Cleaning",
                                   greetings: "Help with daily cleaning",
                                   phone: "+44 123456789",
                                   email: "orgpork@mail.com",
                                   address: Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "309", apt: "", 55.95207, -3.19768),
                                   cancellation: 6,
                                   avatar: "WomanCleaner",
                                   calloutCharge: true,
                                   distance: 12.5,
                                   rating: 4.4,
                                   employment: .Individual,
                                   portfolio: ProviderPublicPortfolio(images: ["PortfolioImage0",
                                                                               "PortfolioImage1",
                                                                               "PortfolioImage2",
                                                                               "PortfolioImage3",
                                                                               "PortfolioImage4",
                                                                               "PortfolioImage5"],
                                                                      description: portfolioDesc),
                                   verifications: [.IDs, .Phone, .Address],
                                   reviews: [
                                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 3.9, description: "Prompt payment, polite and respectful"),
                                    Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 4.6, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 1.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 3.7, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 2.2, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                                    Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful")
                                   ],
                                   languages: [Language.English, Language.French, Language.Germany],
                                   choicedServices: providerServices,
                                   portfolioFolders: [
                                    PortfolioFolder(title: "Kitchen", images: [
                                        PortfolioImage(image: "PortfolioImage0", title: "Kitchen 0", uploadDate: "21/02/22 11:33"),
                                        PortfolioImage(image: "PortfolioImage1", title: "Kitchen 1", uploadDate: "22/02/22 04:20"),
                                        PortfolioImage(image: "PortfolioImage2", title: "Kitchen 2", uploadDate: "22/02/22 09:41"),
                                        PortfolioImage(image: "PortfolioImage3", title: "Kitchen 3", uploadDate: "23/02/22 06:06")
                                    ]),
                                    PortfolioFolder(title: "Bathroom", images: [
                                        PortfolioImage(image: "PortfolioImage5", title: "Kitchen 0", uploadDate: "21/02/22 11:33"),
                                        PortfolioImage(image: "PortfolioImage1", title: "Kitchen 1", uploadDate: "22/02/22 04:20"),
                                        PortfolioImage(image: "PortfolioImage2", title: "Kitchen 2", uploadDate: "22/02/22 09:41"),
                                        PortfolioImage(image: "PortfolioImage3", title: "Kitchen 3", uploadDate: "23/02/22 06:06")
                                    ]),
                                    PortfolioFolder(title: "Garage", images: [
                                        PortfolioImage(image: "PortfolioImage4", title: "Kitchen 0", uploadDate: "21/02/22 11:33"),
                                        PortfolioImage(image: "PortfolioImage2", title: "Kitchen 2", uploadDate: "22/02/22 09:41"),
                                        PortfolioImage(image: "PortfolioImage3", title: "Kitchen 3", uploadDate: "23/02/22 06:06")
                                    ])
                                   ],
                                   services: [
                                    StaticCategories[10]!,
                                    StaticCategories[30]!,
                                    StaticCategories[40]!,
                                    StaticCategories[1010]!,
                                    StaticCategories[1020]!,
                                    StaticCategories[700]!,
                                    StaticCategories[720]!,
                                    StaticCategories[320]!,
                                    StaticCategories[330]!
                                   ]
)

let portfolioDesc =
    """
    I am so appreciated about our small talk in your cafe, that I wanna take a part in marketing assistance to your brand.  After some market research, I came up with a couple given strategies, which can promote your business.
    First of all, I decided to offer you to develop a new product and come to market with some new more specific and deep taste, which can possibly enhance company’s makeover, but it reliable only with intensive marketing company that can increase your market share.
    Secondly, as the most reliable,  it is a price reduction that will attract more customers, but will lead to lower profits and lower audience quality.
    The last ones I prefers to merge in the same topic, because they way much expensive in time and money resources, but they certainly bring more profit. These are advertising and brand awareness campaigns that will have to attract a major amount of costumers and proposals.
    On this basis, I want to conclude, that the most effective solution ffor the return of the former lost glory of  Caferoma will be the introduction of new product in the market, which it’s competitors in the market haven’t thought of yet, something original and one of exclusive offers, that will suppose to enticing  new opportunities and ideas to launch new successful products as well.
    """

func getVerifications(verifications: [VerificationType]) -> String {
    var verifics = ""
    //    print(testProvider.verifications)
    for verification in verifications {
        if verification == .ProfessionalInsurance {
            verifics = verifics + "Professional Insurance" + ", "

        } else if verification == .RegistrationCertificate {
            verifics = verifics + "Registration Certificate" + ", "

        } else if verification != verifications.last {
            verifics = verifics + verification.rawValue + ", "
        } else {
            verifics = verifics + verification.rawValue
        }
    }

    return verifics
}

func getLanguages(languages: [Language]) -> String {
    var verifics = ""
    //    print(testProvider.verifications)
    for language in languages {
        if language != languages.last {
            verifics = verifics + language.rawValue + ", "
        } else {
            verifics = verifics + language.rawValue
        }
    }

    return verifics
}
var Providers: [Provider] = [
    Provider(id: 10, isActive: true,
             name: "Duncan McCleod Cleaning",
             greetings: "Help with daily cleaning",
             phone: "+44 123456789",
             email: "orgpork@mail.com",
             address: Address(postcode: "EH2 2ER", town: "Edinburgh", street: "Princes Street", building: "309", apt: "", 55.95207, -3.19768),
             cancellation: 6,
             avatar: "WomanCleaner",
             calloutCharge: true,
             distance: 12.5,
             rating: 4.4,
             employment: .Individual,
             portfolio: ProviderPublicPortfolio(images: ["PortfolioImage0",
                                                         "PortfolioImage1",
                                                         "PortfolioImage2",
                                                         "PortfolioImage3",
                                                         "PortfolioImage4",
                                                         "PortfolioImage5"],
                                                description: portfolioDesc),
             verifications: [.IDs, .Phone, .Address],
             reviews: [Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 3.9, description: "Prompt payment, polite and respectful"),
                       Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 4.6, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 1.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 3.7, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 2.2, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),
                       Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful")],
             languages: [Language.English, Language.French, Language.Germany], services: []),
    Provider(id: 11, name: "Kai's Elderly care", cancellation: 1, avatar: "WomanCleaner", calloutCharge: true, rating: 2.1, employment: .Individual),
    Provider(id: 12, name: "The gardener", cancellation: 0, calloutCharge: false, rating: 4.9, employment: .Agency),
    Provider(id: 13, name: "Special nails services", cancellation: 3, avatar: "WomanCleaner", calloutCharge: true, rating: 4.3, employment: .Individual),
    Provider(id:14, name: "Kai's Elderly care ...", cancellation: 5, calloutCharge: true, rating: 4.1, employment: .Agency),
    Provider(id: 15, name: "The gardener", cancellation: 4, calloutCharge: true, rating: 3.9, employment: .Individual),
    Provider(id: 16, name: "Kai's Hills therapy", cancellation: 2, avatar: "WomanCleaner", calloutCharge: false, rating: 4.3, employment: .Agency)
]
