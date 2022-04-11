//
//  ProviderOrdersListTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI

struct PrvOrdersListTabView: View {
    @Binding var provider: Provider
    @Binding var customer: Customer

    var body: some View {
        VStack {
            Image("RequestsImage")
                .resizable()
                .frame(width: 300, height: 375, alignment: .center)
                .scaledToFit()
                .aspectRatio(1, contentMode: .fit)
            NavigationLink {

            } label: {
                VStack {
                    Spacer()
                    Rectangle().foregroundColor(.clear)
                        .ignoresSafeArea(.container, edges: .horizontal)
                        .overlay {
                            HStack {
                                Text("Sing In")
                                    .withDoneButtonStyles(backColor: .accentColor, accentColor: .white)
                            }
                        }.zIndex(1)
                }.padding(.bottom, 15)
            }

        }
        
    }
}

struct ProviderOrdersListTabView_Previews: PreviewProvider {
    static var previews: some View {
        PrvOrdersListTabView(provider: .constant(testProvider), customer: .constant(testCustomer))
    }
}
