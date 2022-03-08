//
//  InquiryServicesView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI
//import LabeledStepper
struct InquiryServicesView: View {
    @State var windowsCount = 4
    @State var kitchenCount = 1
    @State var bedroomCount = 1
    @State var homeCount = 0

    var windowCleaningPrice = 40.0
    var kitchenCleaningPrice = 60.0
    var bedroomCleaningPrice = 40.0
    var homeCleaningPrice = 100.0
    var body: some View {
        VStack {
            Divider()//.padding(.horizontal, 20)
            HStack {
                    ServiceSpecificationCell(count: $windowsCount, price: windowCleaningPrice, serviceType: .Windows)
            }.fixedSize(horizontal: false, vertical: true)
            Divider().padding(.horizontal, 20)
            HStack {
                ServiceSpecificationCell(count: $kitchenCount, price: kitchenCleaningPrice, serviceType: .Kitchen)
            }.fixedSize(horizontal: false, vertical: true)
            Divider().padding(.horizontal, 20)
            HStack {

                ServiceSpecificationCell(count: $bedroomCount, price: bedroomCleaningPrice, serviceType: .BedroomLivingroom)
            }.fixedSize(horizontal: false, vertical: true)
            Divider().padding(.horizontal, 20)
            HStack {

                ServiceSpecificationCell(count: $homeCount, price: homeCleaningPrice, serviceType: .CompleteHome)
            }.fixedSize(horizontal: false, vertical: true)
            Divider().padding(.horizontal, 20)
            Spacer()
        }
        .toolbar(content: {
            NavigationLink(destination: InquiryOverview()) {
                Text("Add")
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))

            }
        })
        .foregroundColor(.accentColor)
        .navigationTitle("Services")

    }
}

struct InquiryServicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {

            InquiryServicesView()
        }
    }
}

struct ServiceSpecificationCell: View {
    @Binding var count: Int
    var price: Double
    @State var serviceType: ServiceType
    var title: String

    init(count: Binding<Int>, price: Double, serviceType: ServiceType) {
        self._count = count
        self.price = price
        self.serviceType = serviceType
        switch serviceType {
        case .Windows:
            title = "Windows cleaning"
        case .Kitchen:
            title = "Kitchen cleaning"
        case .BedroomLivingroom:
            title = "Bedroom or living room cleaning"
        case .CompleteHome:
            title = "Complete home cleaning"
        }
    }

    var body: some View {
        VStack {
            NavigationLink(destination: SelectedServiceDetailView(serviceType: serviceType).navigationTitle(Text(title).font(.subheadline))) {
                HStack(alignment: .center) {
                LabeledStepper(title, description: "£\(Double(count) * price)", value: $count, in: 0...10, longPressInterval: 1.0, repeatOnLongPress: true, style: .init())
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.accentColor)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 20, weight: .regular, design: .rounded)).padding(.leading, 10)
                }
            }

        }.fixedSize(horizontal: false, vertical: true).padding(.horizontal, 20)
    }
}

