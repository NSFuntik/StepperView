//
//  ProviderSearchView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProviderSearchView: View {
    @State var selectedButton: Int = 0
    @State var isLimited = true
    init() {
        UITableView.appearance().backgroundColor = UIColor.white
        UITableView.appearance().separatorColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.6)
        UITableView.appearance().sectionIndexColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.6)
    }
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            ServicesScrollView.padding(.horizontal, -30)
            VStack {
                HStack {
                    Text("Description")
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .medium, design: .rounded))
                    Spacer()
                }.padding(.vertical, 5)
                Text(Services[selectedButton].description ?? descr)
                    .foregroundColor(Color.black.opacity(0.8))
                    .multilineTextAlignment(.leading)
                    .font(Font.system(size: 14, weight: .light, design: .rounded))
                    .lineLimit(isLimited ? 4 : 10)
                HStack {
                    Text(isLimited ? "Show more" : "Show less")
                        .foregroundColor(Color.accentColor)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 13, weight: .light, design: .rounded))
                        .padding(.top, -5)
                        .onTapGesture {
                            isLimited.toggle()
                        }
                    Spacer()
                }
            }.padding(.bottom, 20)
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(Services[selectedButton].types ?? [], id: \.self) { type in
                        Section {
                            NavigationLink {
                                ProvidersView(service: Services[selectedButton])
                            } label: {
                                HStack {
                                    Text(type)
                                        .foregroundColor(Color.black.opacity(0.9))
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                        .lineLimit(1)
                                        .padding(.leading, 10)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                }.padding(5)
                                
                            }
                            Divider().padding(.horizontal, -10).padding(.leading, 25)
                        }
                    }
                }.padding(10).padding(.bottom, -10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary
                            .opacity(0.7), lineWidth: 1).padding(1))
            }
            Spacer()
        }.padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Provider Search")
    }
}

extension ProviderSearchView {
    private var ServicesScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(Services) { service in
                    Button {
                        selectedButton = service.id
                    } label: {
                        VStack {
                            Image(service.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedButton == service.id ? Color.accentColor : Color.lightGray.opacity(0.6),
                                                lineWidth: selectedButton == service.id ? 2.0 : 1.5)
                                ).padding(.bottom, -3).padding(.top,1)
                            
                            Text(service.name)
                                .foregroundColor(Color.black)
                                .font(.system(size: 15.0, weight: .light, design: .rounded))
                                .padding(.bottom, 5)
                        }
                        .frame( maxHeight: 90)
                        .padding(.horizontal, 10)
                    }
                }
            }.padding(.leading, 20)
        }
    }
}

struct ProviderSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderSearchView().previewDevice("iPhone 6s").navigationTitle("Provider Search")
        }
    }
}
let descr = "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning..."
