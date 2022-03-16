//
//  ProviderVerificationsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProviderVerificationsView: View {
    var body: some View {
        VStack {
            GeometryReader { reader in
                VStack(alignment: .center, spacing: 20) {
                    Label {
                        Text("Provider verifications")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        Spacer()
                        Text("\(String(format: "%g", testProvider.rating))/5")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 15, weight: .regular, design: .monospaced))
                            .padding(5)
                    } icon: {
                        Image("VerificationsIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30, alignment: .center)
                            .padding(5)
                    }.padding(.horizontal,10).padding(.vertical,5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(Color.lightGray))

                    HStack(alignment: .top) {
                        Image(systemName: "checkmark")
                            .font(Font.system(size: 17,
                                              weight: .medium,
                                              design: .rounded))
                            .foregroundColor(.accentColor)
                        Text("Org. \nInsurance")
                            .font(Font.system(size: 16, weight: .semibold, design:.rounded))
                            .frame(width: reader.size.width / 4.5, alignment: .leading)
                        Spacer(minLength: 60)
                        Text("Hiscox professional indemnity insurance")
                            .padding(.leading, 20)
                            .frame(width: reader.size.width / 2, alignment: .leading)
                            .font(Font.system(size: 15, weight: .regular, design:.rounded))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }

                    Label {
                        Text("Provider admin verifications")
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(Font.system(size: 16, weight: .regular, design: .rounded))
                        Spacer()
                        Text("\(String(format: "%g", testProvider.rating))/5")
                            .foregroundColor(Color.white)
                            .font(Font.system(size: 15, weight: .regular, design: .monospaced))
                            .padding(5)
                    } icon: {
                        Image("VerificationsIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30, alignment: .center)
                            .padding(5)
                    }.padding(.horizontal, 10).padding(.vertical, 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 1.0)
                                .foregroundColor(Color.lightGray))

                    HStack(alignment: .top) {
                        Image(systemName: "checkmark")
                            .font(Font.system(size: 17,
                                              weight: .medium,
                                              design:.rounded))
                            .foregroundColor(.accentColor)
                        Text("Address")
                            .font(Font.system(size: 17, weight: .semibold, design:.rounded))
                            .frame(width: reader.size.width / 5, alignment: .leading)
                        Spacer(minLength: 90)
                        Text("Address verification for managing Kai's Org (10/10/2018)")
                            .frame(width: reader.size.width / 2.5, alignment: .leading)
                            .font(Font.system(size: 15, weight: .regular, design:.rounded))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        Image(systemName: "checkmark")
                            .font(Font.system(size: 17,
                                              weight: .medium,
                                              design:.rounded))
                            .foregroundColor(.accentColor)
                        Text("Phone")
                            .font(Font.system(size: 17, weight: .semibold, design:.rounded))
                            .frame(width: reader.size.width / 5, alignment: .leading)
                        Spacer(minLength: 90)
                        Text(" +44 1234567890 (10/10/2018)")
                            .frame(width: reader.size.width / 2.5, alignment: .leading)
                            .font(Font.system(size: 15, weight: .regular, design:.rounded))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                    HStack(alignment: .top) {
                        Image(systemName: "checkmark")
                            .font(Font.system(size: 17,
                                              weight: .medium,
                                              design:.rounded))
                            .foregroundColor(.accentColor)
                        Text("Passport")
                            .font(Font.system(size: 16, weight: .semibold, design:.rounded))
                            .frame(width: reader.size.width / 5, alignment: .leading)
                        Spacer(minLength: 90)
                        Text("UK passport (10/10/2018)")
                            .frame(width: reader.size.width / 2.5, alignment: .leading)
                            .font(Font.system(size: 15, weight: .regular, design:.rounded))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }
                    Spacer()
                }
            }.frame(width: .infinity)
        }.padding(.horizontal, 20).padding(.top, 10)
            .navigationTitle("Verifications")
    }
}

struct ProviderVerificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderVerificationsView()
        }
    }
}
