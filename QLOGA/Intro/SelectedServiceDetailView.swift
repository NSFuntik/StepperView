//
//  SelectedServiceDetailView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct SelectedServiceDetailView: View {
    @State var serviceType: ServiceType
    var cleaningService: CleaningService

    init(serviceType: ServiceType) {
        self.serviceType = serviceType
        switch serviceType {
        case .Windows, .Kitchen, .BedroomLivingroom, .CompleteHome:
            cleaningService = CleaningService(title: "Kitchen Cleaning",
                                              unit: "£ / Hour",
                                              price: 15.0,
                                              subject: "Internal and external drains, sewers and pipes",
                                              description: "Internal and external drains, sewers and pipes",
                                              conditions: "Internal and external drain and sewer repair, including unblocking and cleaning.",
                                              works: "Internal and external drain and sewer repair, including unblocking and cleaning and replacing drains, sewers and pipes.",
                                              notIncluded: "The cost of pipes and other materials is an additional charge, fixing water supply pipes not included.")
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(cleaningService.title)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                .padding()
                .frame(width: UIScreen.main.bounds.width - 42, alignment: .leading)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray)
                ).frame(height: 40).padding(1).padding(.vertical, 10)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Label {
                        Text(cleaningService.unit)
                            .foregroundColor(Color.lightGray)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    } icon: {
                        Text("Unit:")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    }
                    Label {
                        Text(String(format: "%g.0", cleaningService.price))
                            .foregroundColor(Color.lightGray)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    } icon: {
                        Text("Price:")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    }
                    Text("Subject of service:")
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                    Text(cleaningService.subject)
                        .foregroundColor(Color.lightGray)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                }
                Spacer()
                Image("KitchenCleaner")
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Description:")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Text(cleaningService.description)
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Conditions:")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Text(cleaningService.conditions)
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Works:")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

                Text(cleaningService.works)
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

            }
            VStack(alignment: .leading, spacing: 3) {
                Text("Not included:")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)

                Text(cleaningService.notIncluded)
                    .foregroundColor(Color.lightGray)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
            }
            Spacer()
        }.padding(.horizontal, 20)
        .navigationTitle("Selected service").navigationBarTitleDisplayMode(.inline)
    }
}

struct SelectedServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectedServiceDetailView(serviceType: .Kitchen)
        }
    }
}



