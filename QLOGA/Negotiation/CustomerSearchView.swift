//
//  CustomerSearchView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/14/22.
//

import SwiftUI

struct CustomerSearchView: View {
    @State var customers: [Customer] = Customers
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach($customers) { cst in
                    Section {
                        CustomerRequestCell(customer: cst)
                    }.padding(.vertical, 5)
                }
                Spacer(minLength: 100)
            }
        }
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Customer Search")
    }
}
var poundsFormatter: NumberFormatter = {
    var nf = NumberFormatter()
    nf.multiplier = 0.01
    nf.numberStyle = .currency
    nf.locale = .init(identifier: "en_GB")
    return nf
}()

struct CustomerRequestCell: View {
    @Binding var customer: Customer
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(" " + customer.name + " " + customer.middleMame + " " + customer.surname)
                    .foregroundColor(Color.secondary).lineLimit(1)
                    .font(.system(size: 17.0, weight: .regular, design: .rounded))
                    .multilineTextAlignment(.leading)
                Spacer()
                NavigationLink(destination: GoogleMapView(providers: .constant([]), pickedAddress: $customer.address)) {
                    Text("\(String(format: "%g", customer.distance)) mls")
                        .underline()
                        .foregroundColor(Color.accentColor).lineLimit(1)
                        .font(.system(size: 15.0, weight: .light, design: .rounded))
                }
            }.frame(width: UIScreen.main.bounds.width - 150).padding(4)
            NavigationLink(destination: CustomerRequestInfoView(customer: $customer)) {
                HStack {
                    Text(getString(from: Date(), "dd/MM/yy HH:MM"))
                        .foregroundColor(Color.black).lineLimit(1)
                        .font(.system(size: 17.0, weight: .regular, design: .rounded))
                    Spacer()
                    Spacer()
                    Image(customer.address.isBussinessOnly ? "ParkingIcon" : "NoParkingIcon")
                        .renderingMode(.template)
                        .resizable().frame(width: 20, height: 20, alignment: .center)
                        .scaledToFit().aspectRatio(contentMode: .fit)
                        .foregroundColor(customer.address.apt != "" ? .infoBlue : .clear)
                    Spacer()
                    Text(poundsFormatter.string(from: Int(customer.address.building)! * 100 as NSNumber)!)
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 17, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.accentColor)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .padding(.horizontal, 2)
                }.frame(width: UIScreen.main.bounds.width - 60)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1.0)
                        .foregroundColor(Color.lightGray))
                    .padding(1)
                    .frame(height: 45)
            }
        }
    }
}


struct CustomerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomerSearchView()
                .previewDevice("iPhone 6s").navigationTitle("Customer Search")
        }
    }
}
