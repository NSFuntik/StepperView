//
//  ProviderVerificationsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProviderVerificationsView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Label {
                Text("Provider verifications")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                Text("\(String(format: "%g", testProvider.rating))/5")
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 15, weight: .regular, design: .monospaced)).padding(5)
            } icon: {
                Image("VerificationsIcon")
                    .resizable().aspectRatio( contentMode: .fit).frame(height: 30, alignment: .center)
                    .padding(5)
            }.padding(10)

                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray)
                    .shadow(color: .secondary.opacity(0.5), radius: 3)).padding()
            HStack(alignment: .top) {
                Image(systemName: "checkmark")
                    .font(Font.system(size: 17,
                                      weight: .medium,
                                      design:.rounded))
                    .foregroundColor(.accentColor)
                Text("Org. \nInsurance").font(Font.system(size: 17, weight: .semibold, design:.rounded))
                Spacer()
                Text("Hiscox professional indemnity insurance").alignmentGuide(.leading){ _ in  50 }.font(Font.system(size: 15, weight: .regular, design:.rounded)).multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)

            }.padding(.horizontal, 20)

            Label {
                Text("Provider admin verifications")
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                Spacer()
                Text("\(String(format: "%g", testProvider.rating))/5")
                    .foregroundColor(Color.white)
                    .font(Font.system(size: 15, weight: .regular, design: .monospaced)).padding(5)
            } icon: {
                Image("VerificationsIcon")
                    .resizable().aspectRatio( contentMode: .fit).frame(height: 30, alignment: .center)
                    .padding(5)
            }.padding(10)

                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 1.0)
                    .foregroundColor(Color.lightGray)
                    .shadow(color: .secondary.opacity(0.5), radius: 3)).padding()
            HStack(alignment: .top) {
                Image(systemName: "checkmark")
                    .font(Font.system(size: 17,
                                      weight: .medium,
                                      design:.rounded))
                    .foregroundColor(.accentColor)
                Text("Address").font(Font.system(size: 17, weight: .semibold, design:.rounded))//.padding(.trailing, 80)
                Spacer()
                Text("Address verification for managing Kai's Org (10/10/2018)").alignmentGuide(.leading){ _ in  -220 }.font(Font.system(size: 15, weight: .regular, design:.rounded)).multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)
            }.padding(.horizontal, 20)
            HStack(alignment: .top) {
                Image(systemName: "checkmark")
                    .font(Font.system(size: 17,
                                      weight: .medium,
                                      design:.rounded))
                    .foregroundColor(.accentColor)
                Text("Phone").font(Font.system(size: 17, weight: .semibold, design:.rounded))//.padding(.trailing, 80)
                Spacer()
                Text(" +44 1234567890 (10/10/2018)").alignmentGuide(.leading){ _ in  50 }.font(Font.system(size: 15, weight: .regular, design:.rounded)).multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)
            }.padding(.horizontal, 20)
            HStack(alignment: .top) {
                Image(systemName: "checkmark")
                    .font(Font.system(size: 17,
                                      weight: .medium,
                                      design:.rounded))
                    .foregroundColor(.accentColor)
                Text("Passport").font(Font.system(size: 17, weight: .semibold, design:.rounded))//.padding(.trailing, 80)
                Spacer()
                Text("UK passport (10/10/2018)")
                    .alignmentGuide(.leading){ _ in  50 }
                    .font(Font.system(size: 15, weight: .regular, design:.rounded)).multilineTextAlignment(.leading)
                    .foregroundColor(Color.secondary)
            }.padding(.horizontal, 20)
            Spacer()
        }.navigationTitle("Verifications")
    }
}

struct ProviderVerificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderVerificationsView()
        }
    }
}
