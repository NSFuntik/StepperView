//
//  ProviderRatesView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/6/22.
//

import SwiftUI

struct ProviderRatingView: View {

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Label {
                Text("Rating")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                Text("\(String(format: "%g", testProvider.rating))/5")
                    .foregroundColor(Color.accentColor)
                    .font(Font.system(size: 15, weight: .regular, design: .monospaced)).padding(5)
            } icon: {
                Image("RatingIcon")
                    .resizable().aspectRatio( contentMode: .fit).frame(height: 30, alignment: .center)
                    .padding(5)
            }.padding(10)

                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray)
                    .shadow(color: .secondary.opacity(0.5), radius: 3)).padding()

            HStack {
                Text("Comminications")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                StarsView(rating: 4.0)
            }.padding()
            HStack {
                Text("Prompt payment")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                StarsView(rating: 3.0)
            }.padding()
            HStack {
                Text("Sufficient enough chemicals and materials")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                StarsView(rating: 4.0)
            }.padding()
            HStack {
                Text("Appriciative")
                    .foregroundColor(Color.secondary)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                StarsView(rating: 2.5)
            }.padding()
            Spacer()
        }.navigationTitle("Rating")
    }
}

struct ProviderRatingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderRatingView()
        }
    }
}
