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
        UITableView.appearance().tintColor = .secondaryLabel
        UITableView.appearance().separatorColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.6)
        UITableView.appearance().sectionIndexColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.6)


    }
    var body: some View {
        VStack(alignment: .center, spacing: 5) {

            ServicesScrollView
            Divider()
            HStack {
                Text("Description").foregroundColor(Color.black).multilineTextAlignment(.leading).font(Font.system(size: 20, weight: .medium, design: .rounded)).padding(.horizontal)
                Spacer()
            }
            Text(Services[selectedButton].description ?? descr).foregroundColor(Color.black.opacity(0.8)).multilineTextAlignment(.leading).font(Font.system(size: 14, weight: .light, design: .rounded)).padding(.horizontal).lineLimit(isLimited ? 4 : 10)
            HStack {
                Text(isLimited ? "Learn more" : "Show less").foregroundColor(Color.accentColor).multilineTextAlignment(.leading).font(Font.system(size: 13, weight: .light, design: .rounded)).padding(.horizontal).padding(.top, -3)
                    .onTapGesture {
                        isLimited.toggle()
                    }
                Spacer()
            }
            List {
                ForEach(Services[selectedButton].types ?? [], id: \.self) {
                    type in
                    NavigationLink {
                        ProvidersView(service: Services[selectedButton])
                    } label: {
                        HStack {
                            Text(type).foregroundColor(Color.black.opacity(0.9)).multilineTextAlignment(.leading).font(Font.system(size: 17, weight: .regular, design: .rounded)).padding(.horizontal).lineLimit(1)
                            Spacer()
                        }
                    }

                }.listStyle(InsetListStyle())
            }
                .background(Color(red: 0.949, green: 0.949, blue: 0.971)
                    .cornerRadius(10)
                    .ignoresSafeArea(.all, edges: .bottom))
                .overlay(RoundedRectangle(cornerRadius: 16).fill(Color.clear).shadow(color: .lightGray.opacity(0.6), radius: 3, y: 3))
//                    RoundedRectangle(cornerRadius: 16)
//                        .stroke(Color.secondary.opacity(0.6), lineWidth: 1)
//                        .shadow(color: .secondary.opacity(0.5), radius: 5).padding(.horizontal, 18).padding(.bottom, -5))
                .navigationBarTitle("Provider Search").font(Font.system(size: 16, weight: .medium, design: .serif))
        }
    }
}

extension ProviderSearchView {
    private var ServicesScrollView: some View {
        ScrollView(.horizontal, showsIndicators: true) {
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
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(selectedButton == service.id ? Color.accentColor : Color.lightGray.opacity(0.6), lineWidth: selectedButton == service.id ? 2.0 : 1.5)
                                ).padding(.bottom, -3).padding(.top,1)
                            Text(service.name).foregroundColor(Color.black)
                                .font(.system(size: 13.0, weight: .light, design: .rounded))
                                .padding(.bottom, 5)
                        }
                        .frame( maxHeight: 80)
                    }
                }
            }.padding(.leading)
        }
    }
}

struct ProviderSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderSearchView().previewDevice("iPhone 6s").navigationTitle("Provider Search")
        }.previewDevice("iPhone 12")
    }
}
 let descr = "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning..."
