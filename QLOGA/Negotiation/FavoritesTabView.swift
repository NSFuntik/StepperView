//
//  FavoritesTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI

struct FavoritesTabView: View {
    @Binding var provider: Provider
    var body: some View {


            VStack {

                Text("Hello, World!")
            }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Favorite providers").navigationViewStyle(.stack)
    }
}

struct FavoritesTabView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesTabView(provider: .constant(testProvider))
    }
}
