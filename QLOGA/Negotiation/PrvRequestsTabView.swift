//
//  PrvRequestsTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI

struct PrvRequestsTabView: View {
    @Binding var provider: Provider
    @Binding var customer: Customer

    var body: some View {
        VStack {
            Spacer(minLength: 150)
            Image("RequestsImage")
                .resizable()
                .frame(width: 300, height: 375, alignment: .center)
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
            Spacer(minLength: 50)
            NavigationLink {
                CstOpenRequestsView(customer: $customer)
            } label: {
                VStack {
                    Spacer()
                    Rectangle().foregroundColor(.clear)
                        .ignoresSafeArea(.container, edges: .horizontal)
                        .overlay {
                            HStack {
                                Text("Create Open Request")
                                    .withDoneButtonStyles(backColor: .Green, accentColor: .white)
                            }
                        }.zIndex(1)
                }.padding(.bottom, 15)
            }

        }.background(Color.lightGray.opacity(0.2))

    }
}

struct PrvRequestsTabView_Previews: PreviewProvider {
    static var previews: some View {
        PrvRequestsTabView(provider: .constant(testProvider), customer: .constant(testCustomer))
    }
}
