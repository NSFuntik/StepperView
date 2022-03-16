//
//  ProviderAccountSetupView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProfileSetupView: View {
    @State var actorType: ActorsEnum

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ProviderAccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSetupView(actorType: .PROVIDER)
    }
}
