//
//  CustomerRequestView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/15/22.
//

import SwiftUI

struct CustomerRequestInfoView: View {
    @Binding var customer: Customer
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {

                    Group  {
                        VStack {
                            //        if actorType != .CUSTOMER {}
                            NavigationLink(destination: ProfilePublicView(actorType: .CUSTOMER, customer: $customer, provider: .constant(testProvider))) {
                                HStack {
                                    Text(customer.name + " " + customer.surname)
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                }.padding(7)
                            }.frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            Section {
                                HStack {
                                    Text("Rating")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(String(format: "%g", customer.rating) + "/5")
                                        .lineLimit(1)
                                        .foregroundColor(Color.secondary)
                                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                }.padding(7)
                            }.frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            Section {
                                HStack {
                                    Text("Parking")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(customer.address.isBussinessOnly ? "£" + String(format: "%g", customer.distance) + "/hour" : "none")
                                        .lineLimit(1)
                                        .foregroundColor(Color.secondary)
                                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                }.padding(7)
                            }.frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            Section {
                                HStack {
                                    Text("Distance")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(String(format: "%g", customer.distance) + " miles")
                                        .lineLimit(1)
                                        .foregroundColor(Color.Orange)
                                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                }.padding(7)
                            }.frame(height: 40)
                        }.padding(10)
                    }.overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundColor(Color.lightGray)
                    ).padding(1)
                    HStack(alignment: .top) {
                        Text(customer.address.total)
                            .lineLimit(2)
                            .foregroundColor(Color.secondary.opacity(0.8))
                            .font(Font.system(size: 17,
                                              weight: .regular,
                                              design: .rounded))
                        Spacer()
                        Image("MapSymbol")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit().aspectRatio(contentMode: .fit)
                            .foregroundColor(.accentColor)
                            .frame(width: 25, height: 25, alignment: .center)
                    }.padding(10)
                    Group {
                        VStack {
                            Section {
                                HStack {
                                    Text("Budget")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(poundsFormatter.string(from: Int(customer.address.building)! * 100 as NSNumber)!)
                                        .multilineTextAlignment(.trailing)
                                        .font(Font.system(size: 17, weight: .semibold, design: .rounded))
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                }.padding(7)
                            }.frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            Section {
                                HStack {
                                    Text("Date")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(getString(from: Date(), "dd/MM/yy HH:MM"))
                                        .foregroundColor(Color.secondary).lineLimit(1)
                                        .font(.system(size: 17.0, weight: .light, design: .rounded))
                                }.padding(7)
                            }.frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            Section {
                                HStack {
                                    Text("Placed date")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(getString(from: Date(), "dd/MM/yy HH:MM"))
                                        .foregroundColor(Color.secondary).lineLimit(1)
                                        .font(.system(size: 17.0, weight: .light, design: .rounded))
                                }.padding(7)
                            }.frame(height: 40)
                            Divider().background(Color.secondary).padding(.leading, 50)
                            Section {
                                HStack {
                                    Text("Valid until")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text(getString(from: Date(), "dd/MM/yy HH:MM"))
                                        .foregroundColor(Color.secondary).lineLimit(1)
                                        .font(.system(size: 17.0, weight: .light, design: .rounded))
                                }.padding(7)
                            }.frame(height: 40)
                        }.padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray)
                        ).padding(1)
                    }
                    VStack {
                        HStack {
                            Text("Requested services")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            Spacer()
                            Text("\(customer.services.count.description)")
                                .foregroundColor(Color.secondary)
                                .font(Font.system(size: 15, weight: .medium, design: .monospaced))
                        }.padding(15)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(Color.lightGray))
                            .padding(1)
                        ForEach($customer.services, id: \.self) { service in
                            HStack(alignment: .center, spacing: 15) {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color.accentColor)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 7, weight: .regular, design: .rounded))
                                Text(service.name.wrappedValue ?? "")
                                    .foregroundColor(Color.secondary)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .light, design: .rounded))
                                Spacer()
                            }.padding(2)
                        }.padding(.top, 10)
                    }
                }.ignoresSafeArea(.container, edges: .bottom)
                Spacer(minLength: 100)
            }.ignoresSafeArea(.container, edges: .bottom)
            VStack {
                Spacer()
                NavigationLink(destination: CategoriesChooserView(customer: $customer, amount: Double(Int(customer.address.building)! * 100))) {
                    Text("Quote").withDoneButtonStyles(backColor: .accentColor, accentColor: .white)
                }.background(.clear)

//                .zIndex(1)//.opacity($tags.wrappedValue.count > 0 ? 1 : 0)
            }.padding(.bottom, 20).background(.clear)
        }.ignoresSafeArea(.container, edges: .bottom)
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Customer")
    }
}

struct CustomerRequestView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomerRequestInfoView(customer: .constant(Customers[0]))
        }.navigationTitle("Provider Search").previewDevice("iPhone 6s")
    }

}
