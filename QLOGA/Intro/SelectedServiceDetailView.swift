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
            cleaningService = CleaningService(unit: "£ / Hour",
                                              price: 15.0,
                                              subject: "Internal and external drains, sewers and pipes",
                                              description: "Internal and external drains, sewers and pipes",
                                              conditions: "Internal and external drain and sewer repair, including unblocking and cleaning.",
                                              works: "Internal and external drain and sewer repair, including unblocking and cleaning and replacing drains, sewers and pipes.",
                                              notIncluded: "The cost of pipes and other materials is an additional charge, fixing water supply pipes not included.")
        }

    }
    var body: some View {
        VStack(alignment: .center) {

            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct SelectedServiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedServiceDetailView(serviceType: .Kitchen)
    }
}



