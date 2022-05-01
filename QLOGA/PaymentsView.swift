//
//  PaymentsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/21/22.
//

import SwiftUI

struct PaymentsView: View {
    @Binding var actorType: ActorsEnum
    @Binding var order: OrderContent
    var body: some View {
        ScrollView (showsIndicators: false){
            LazyVStack(spacing: 15) {
                PaymentsCell(status: .APPROVED, order: $order)
                PaymentsCell(status: .PAYMENT_REFUSED, order: $order)
                PaymentsCell(status: .AUTH_IN_PROGRESS, order: $order)
                PaymentsCell(status: .PAID, order: $order)
                HStack {
                    Spacer()
                    NavigationLink(destination: TermsConditionsView(actorType: actorType)) {
                        Text("Terms&Conditions")
                            .underline()
                            .foregroundColor(.accentColor)
                            .font(.system(size: 15, weight: .regular, design: .rounded))
                    }
                }

            }
            Spacer(minLength: 50)
        }.padding(.horizontal, 20)
            .navigationTitle("Payments")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 10)
    }
}


struct PaymentsCell: View {
    @State var status: StatusesEnum
    @Binding var order: OrderContent
    var body: some View {
        VStack {
            VStack( spacing: 10) {
                HStack {
                    ZStack {
                        Text(status.display)
                            .foregroundColor(Color(hex: status.colors[0]))
                            .colorMultiply(Color(hex: status.colors[0])!)
                            .colorMultiply(Color(hex: status.colors[0])!)
                            .colorMultiply(Color(hex: status.colors[0])!)
                            .colorMultiply(Color(hex: status.colors[0])!)
                            .colorMultiply(Color(hex: status.colors[0])!)
                            .colorMultiply(Color(hex: status.colors[0])!)
                    }
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
//                    Text(status.display)
//                        .foregroundColor(Color(hex: status.colors[0]))
                    .shadow(color: Color(hex: status.colors[0]) ?? .lightGray, radius: 0.2, x: 0.2, y: 0.2)

                    Spacer()
                    Text(getString(from: order.serviceDate, "YYYY/MM/DD HH:mm"))
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Payer:")
                        .foregroundColor(.black)
                    Spacer()
                    Text(order.cstPerson.name ?? "")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("MasterCard:")
                        .foregroundColor(.black)
                    Spacer()
                    Text("**** **** **** 9322")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Amount:")
                        .foregroundColor(.black)
                    Spacer()
                    Text(poundsFormatter.string(from: order.amount as NSNumber)!)
                        .foregroundColor(.secondary)
                }
            }.font(.system(size: 17, weight: .regular, design: .rounded))
                .padding(15)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray))
                .padding(1)
        }
    }
}
