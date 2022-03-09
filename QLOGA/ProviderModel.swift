//
//  ProviderModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/5/22.
//

import Foundation
struct Provider: Hashable {
    let greetings: String?
    var avatar: String?
    let name: String
    let cancellation: Int
    let calloutCharge: Bool
    let rating: Double
    let distance: Double?
    var employment: ProviderType
    let portfolio: ProviderPortfolio?
    let verifications: [VerificationTypes]?
    let reviews: [Review]?

    init(name: String, greetings: String? = "", cancellation: Int, avatar: String? = "Avatar", calloutCharge: Bool, distance: Double? = 0.0, rating: Double, employment: ProviderType, portfolio: ProviderPortfolio? = nil, verifications: [VerificationTypes]? = [],  reviews: [Review]? = []) {
        //        self.hashValue = hashValue

        self.greetings = greetings
        self.avatar = avatar
        self.name = name
        self.cancellation = cancellation
        self.calloutCharge = calloutCharge
        self.rating = rating
        self.distance = distance
        self.employment = employment
//        self.services = services
        self.portfolio = portfolio
        self.verifications = verifications
        self.reviews = reviews
    }
}

struct ProviderPortfolio: Hashable {
    let images: [String]?
    let description: String?
    init(images: [String]? = nil, description: String = "") {
        self.images = images
        self.description = description
    }
}

enum VerificationTypes: String, CaseIterable, Identifiable, Hashable {
    case IDs
    case Address
    case Avatar
    case RegistrationCertificate
    case ProfessionalInsurance
    case Email
    case Phone
    case Passport
    var id: String { self.rawValue }

}

enum CertificationTypes: String, CaseIterable, Identifiable {
    case BasicDisclosure
    case ProtectingVulnerableGroups
    case DBS
    case RegistrationCertificate
    case AccessNI
    case none
    var id: String { self.rawValue }

}

//let testProvider: Provider = Provider(name: "Kai's Elderly",
//                                      cancellation: 6,
//                                      calloutCharge: true,
//                                      distance: 12.5,
//                                      rating: 4.4,
//                                      employment: .Individual,
//                                      services: [Service.init(id: 0, image: "Cleaning", name: "Cleaning", description: "", types: ["Windows cleaning", "Complete home cleaning", "Kitchen cleaning", "Bathroom and toilet cleaning", "Bedroom or living room cleaning", "Deep upholstery and carpet cleaning" ])],
//                                      portfolio: ([Image("PortfolioImage1"),Image("PortfolioImage2"),Image("PortfolioImage3"),Image("PortfolioImage4")], """
//Internal and external drain and sewer repair, including unblocking and cleaning and replacing drains, sewers and pipes.cleaning and replacing drains
//Internal and external drain and sewer repair, including unblocking and cleaning and replacing drains, sewers and pipes.cleaning and replacing drains
//Internal and external drain and sewer  pipes.cleaning and replacing drains
//"""),
//                                      verifications: [.IDs, .ProfessionalInsurance, .Phone, .Address],
//                                      reviews: [(4.1, "Prompt payment, polite and respectful")])

var Providers: [Provider] = [
    Provider( name: "Kai's Elderly Care",
              greetings: "Help with daily cleaning", cancellation: 6, avatar: "WomanCleaner",
              calloutCharge: true,
              distance: 12.5,
              rating: 4.4,
              employment: .Individual,
              portfolio: ProviderPortfolio(images: [("PortfolioImage1"),
                                                    ("PortfolioImage2"),
                                                    ("PortfolioImage3"),
                                                    ("PortfolioImage4")], description: portfolioDesc) ,
              verifications: [.IDs, .Phone, .Address],
              reviews: [Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 3.9, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.6, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 1.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 3.7, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 2.2, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful")]),
    Provider( name: "Kai's Elderly care", cancellation: 1, avatar: "WomanCleaner", calloutCharge: true, rating: 2.1, employment: .Individual),
    Provider( name: "The gardener", cancellation: 0, calloutCharge: false, rating: 4.9, employment: .Agency),
    Provider( name: "Special nails services", cancellation: 3, avatar: "WomanCleaner", calloutCharge: true, rating: 4.3, employment: .Individual),
    Provider( name: "Kai's Elderly care ...", cancellation: 5, calloutCharge: true, rating: 4.1, employment: .Agency),
    Provider( name: "The gardener", cancellation: 4, calloutCharge: true, rating: 3.9, employment: .Individual),
    Provider(name: "Kai's Hills therapy", cancellation: 2, avatar: "WomanCleaner", calloutCharge: false, rating: 4.3, employment: .Agency)
]

enum ProviderType: String, CaseIterable, Identifiable  {
    case All
    case Individual
    case Agency
    var id: String { self.rawValue }
}

var testProvider: Provider = Provider( name: "Kai's Elderly Care",
                                              greetings: "Help with daily cleaning", cancellation: 6, avatar: "WomanCleaner",
                                              calloutCharge: true,
                                              distance: 12.5,
                                              rating: 4.4,
                                              employment: .Individual,
                                       portfolio: ProviderPortfolio(images: [("PortfolioImage1"),
                                                                             ("PortfolioImage2"),
                                                                             ("PortfolioImage3"),
                                                                             ("PortfolioImage4")], description: portfolioDesc) ,
                                       verifications: [.IDs, .Phone, .Address],
                                       reviews: [Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 3.9, description: "Prompt payment, polite and respectful"),Review(image: "Avatar", rate: 2.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.6, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 1.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 3.7, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 2.2, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful"),Review(image: "ReviewAvatar", rate: 4.1, description: "Prompt payment, polite and respectful")])
                                               // [ 4.1 : "Prompt payment, polite and respectful"])
struct Review: Hashable, Identifiable {
    var id: Self { self }
    let image: String?
    let rate: Float
    let description: String?

    init(image: String = "Avatar", rate: Float, description: String = "") {
        self.image = image
        self.rate = rate
        self.description = description
    }
}

let portfolioDesc =
"""
I am so appreciated about our small talk in your cafe, that I wanna take a part in marketing assistance to your brand.  After some market research, I came up with a couple given strategies, which can promote your business.
First of all, I decided to offer you to develop a new product and come to market with some new more specific and deep taste, which can possibly enhance company’s makeover, but it reliable only with intensive marketing company that can increase your market share.
Secondly, as the most reliable,  it is a price reduction that will attract more customers, but will lead to lower profits and lower audience quality.
The last ones I prefers to merge in the same topic, because they way much expensive in time and money resources, but they certainly bring more profit. These are advertising and brand awareness campaigns that will have to attract a major amount of costumers and proposals.
On this basis, I want to conclude, that the most effective solution ffor the return of the former lost glory of  Caferoma will be the introduction of new product in the market, which it’s competitors in the market haven’t thought of yet, something original and one of exclusive offers, that will suppose to enticing  new opportunities and ideas to launch new successful products as well.
"""
