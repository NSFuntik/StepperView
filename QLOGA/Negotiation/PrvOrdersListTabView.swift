//
//  ProviderOrdersListTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI

struct PrvOrdersListTabView: View {
    @Binding var provider: Provider
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProviderOrdersListTabView_Previews: PreviewProvider {
    static var previews: some View {
        PrvOrdersListTabView(provider: .constant(testProvider))
    }
}
