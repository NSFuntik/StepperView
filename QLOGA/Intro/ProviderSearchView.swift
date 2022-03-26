//
//  ProviderSearchView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProviderSearchView: View {
    // MARK: Lifecycle

    init() {
        UITableView.appearance().backgroundColor = UIColor.white
        UITableView.appearance().separatorColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.6)
        UITableView.appearance().sectionIndexColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.6)
    }

    // MARK: Internal

    @State var selectedButton: Int = 0
    @State var isLimited = true

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
                    ForEach(Services[selectedButton].types, id: \.self) { type in
                        Section {
                            DisclosureGroup {
                                VStack(spacing: 10) {
                                    Text("Internal and external drain and sewer repair, including unblocking and cleaning and replacing drains, sewers and pipes.Internal and external drain and sewer repair, including unblocking and cleaning and replacing drains, sewers and pipes.")
                                        .foregroundColor(Color.secondary.opacity(0.7))
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                        .lineLimit(5)
                                        .padding(10)
                                    HStack(alignment: .center) {
                                        Spacer()
                                        NavigationLink(destination: SelectedServiceDetailView(serviceType: .Kitchen)) {
                                            HStack {
                                                Text("Details")
                                                    .lineLimit(1)
                                                    .font(.system(size: 20, weight: .regular, design: .default))
                                                    .foregroundColor(.infoBlue)
                                                    .frame(width: 100, height: 30)

                                                    .background(
                                                        RoundedRectangle(cornerRadius: 25)
                                                            .stroke(Color.infoBlue, lineWidth: 4)
                                                            .clipShape(RoundedRectangle(cornerRadius: 25))
                                                            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white)))
                                                    .padding(1)
                                                    .frame(width: 100, height: 30)
                                            }
                                        }
                                        Spacer()
                                        NavigationLink(destination: ProvidersView(service: Services[selectedButton])) {
                                            HStack {
                                                Text("Show providers")
                                                    .lineLimit(1)
                                                    .ignoresSafeArea(.all)
                                                    .shadow(color: Color.secondary, radius: 1, x: 1, y: 1)
                                                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                                    .foregroundColor(.white)
                                                    .frame(width: 180, height: 32)
                                                    .background(RoundedRectangle(cornerRadius: 25)
                                                        .fill(Color.accentColor))
                                                    .overlay(RoundedRectangle(cornerRadius: 25)
                                                        .stroke(Color.white, lineWidth: 2)
                                                        .shadow(color: Color.secondary.opacity(0.7), radius: 2, x: 2, y: 2.5)
                                                        .clipShape(RoundedRectangle(cornerRadius: 25))
                                                        .shadow(color: Color.lightGray.opacity(0.7), radius: 2, x: -2.5, y: -2.5)
                                                        .clipShape(RoundedRectangle(cornerRadius: 25)).padding(0.6))
                                            }
                                            .frame(width: 180, height: 33)
                                        }
                                        Spacer()
                                    }

                                }.frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(type.title)
                                                .foregroundColor(Color.black.opacity(0.9))
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                .lineLimit(1)
                                                .padding(.leading, 10)
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack {
                                            Text("Time norm: " + type.timeNorm.description + " min/room")
                                                .foregroundColor(Color.secondary.opacity(0.7))
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                .lineLimit(1)
                                                .padding(.leading, 10)
                                            Spacer()
                                        }
                                    }
                                }.padding(5).frame(height: 40)
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
                                ).padding(.bottom, -3).padding(.top, 1)

                            Text(service.name)
                                .foregroundColor(Color.black)
                                .font(.system(size: 15.0, weight: .light, design: .rounded))
                                .padding(.bottom, 5)
                        }
                        .frame(maxHeight: 90)
                        .padding(.horizontal, 10)
                    }
                }
            }.padding(.leading, 20)
        }.padding(.top, 10)
    }
}

struct ProviderSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProviderSearchView().previewDevice("iPhone 6s").navigationTitle("Provider Search")
        }
    }
}

let descr = "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning...Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home.\nResidential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning, deep cleans, disinfecting, laundry and ironing, and other general cleaning tasks in the home"
