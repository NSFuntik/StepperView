//
//  PrvRequestsTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI

struct PrvRequestsTabView: View {
    @Binding var provider: Provider

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PrvRequestsTabView_Previews: PreviewProvider {
    static var previews: some View {
        PrvRequestsTabView(provider: .constant(testProvider))
    }
}
