//
//  ProvidersView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/4/22.
//

import SwiftUI

struct ProvidersView: View {
    //    @State var bottomSheetPosition: BottomSheetPosition = .middle

    @ObservedObject var locationManager = LocationManager()
    var grid = GridItem(.fixed(UIScreen.main.bounds.size.width / 2 - 20))
    @State var isFiltersPresented = false
    var service: Service
    init(service: Service) {
        self.service = service
        UINavigationBar.appearance().prefersLargeTitles = false

    }
    var body: some View {
        ScrollView {
            ScrollViewReader{ proxy in

                VStack {
                    ForEach(Providers, id: \.self) { provider in
                        NavigationLink(destination: ProviderOverview()) {
                            HStack(alignment: .top, spacing: 20) {
                                VStack(alignment: .center, spacing: 0) {
                                    Image(provider.avatar!).resizable().aspectRatio(contentMode: .fill).frame(width: 100, height: 110, alignment: .center).cornerRadius(10).overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 1.0)
                                        .foregroundColor(Color.lightGray)).padding(1).padding(.top, 2)
                                    //                        .shadow(color: .secondary.opacity(0.5), radius: 3, y: 3)

                                    Text(provider.employment.rawValue)
                                        .foregroundColor(Color.secondary)
                                        .multilineTextAlignment(.center)
                                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                }
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack(alignment: .top) {
                                        Text(provider.name ?? "")
                                            .foregroundColor(Color.black.opacity(0.8))
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 20,
                                                              weight: .medium,
                                                              design: .rounded))
                                        Spacer()
                                        Image("StarIcon")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 33, height: 33, alignment: .center)
                                            .overlay(content: {
                                                Rectangle().fill(Color.white).frame(width: 20, height: 14, alignment: .trailing).offset(x: 6.5, y: -1)
                                                Text(String(format: "%g", provider.rating))
                                                    .foregroundColor(.accentColor)
                                                    .font(Font.system(size: 16,
                                                                      weight: .light,
                                                                      design: .serif)).offset(x: 6.5, y: 0)
                                            })
                                    }
                                    HStack(alignment: .center) {
                                        Text("Callout charge:")
                                            .foregroundColor(Color.lightGray)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                        Spacer()
                                        Image(systemName: provider.calloutCharge ? "checkmark" : "minus").font(Font.system(size: 17, weight: .medium,
                                                                                                                           design: .rounded)).foregroundColor(.accentColor)
                                    }
                                    HStack(alignment: .center) {
                                        Text("Cancellation (hrs):")
                                            .foregroundColor(Color.lightGray)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text(provider.cancellation.description)
                                            .foregroundColor(Color.black.opacity(0.8))
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 15,
                                                              weight: .medium,
                                                              design: .rounded))    }
                                    HStack(alignment: .center) {
                                        Text("Distance (miles):")
                                            .foregroundColor(Color.lightGray)
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                        Spacer()
                                        Text(String(describing: provider.distance!))
                                            .foregroundColor(Color.black.opacity(0.8))
                                            .multilineTextAlignment(.leading)
                                            .font(Font.system(size: 15,
                                                              weight: .medium,
                                                              design: .rounded))
                                    }
                                }

                            }
                        }
                        Divider()

                    }
                }.padding(.horizontal, 20).padding(.top, 5)
            }
        }
        .navigationTitle("Providers")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            HStack {
                Spacer()
                Button {
                    isFiltersPresented.toggle()
                } label: {
                    Image("FilterIcon").resizable().aspectRatio(contentMode: .fit).frame(width: 30, height: 30, alignment: .center).accentColor(Color.accentColor).foregroundColor(.accentColor)
                        .padding(5)
                }
                NavigationLink(destination: GoogleMapView(providers: .constant([Address(postcode: "", town: "", street: "", -33.86, 151.20), Address(postcode: "", town: "", street: "", -33.26, 151.24),Address(postcode: "", town: "", street: "", -32.26, 151.34)]), pickedAddress: .constant(Address(postcode: "", town: "", street: "", locationManager.latitude, locationManager.longitude)))) {
                    Image("MapIcon").resizable().frame(width: 30, height: 30, alignment: .center)
                        .padding(5)
                }

            }
        }
        .sheet(isPresented: $isFiltersPresented) { ProvidersFilterView().cornerRadius(35) }
    }
}


struct ProvidersView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ProvidersView(service:  Service(id: 0, image: "Cleaning", name: "Cleaning", description: "Residential cleaning services for all parts of your home. With tasks covering dishwashing, cleaning bathrooms, waste removal, furniture cleaning, window cleaning...", types: ["Complete home cleaning","Bathroom and toilet cleaning","Kitchen cleaning","Bedroom or living room cleaning","Clothes laundry and ironing","Garrage cleaning","Swimming pool cleaning","Owen cleaning"]))
                    .navigationTitle("Providers")
            }.previewDevice("iPhone 6s")

        }
    }
}


/*

 HStack {
 NavigationLink(destination: ProviderOverview()) {
 VStack(alignment: .leading) {
 HStack {
 Image("WomanCleaner")
 .resizable().scaledToFill()
 .aspectRatio(contentMode: .fill)
 .frame(width: geo.size.width, height:  geo.size.height / 3, alignment: .top)
 HStack {
 VStack(alignment: .leading) {
 Spacer()
 Text(Providers[index].name)
 .foregroundColor(Color.black)
 .multilineTextAlignment(.leading)
 .font(Font.system(size: 15,
 weight: .regular,
 design: .serif))
 //                                            .padding(.horizontal, 10)
 //                                            .padding(.top, -5)
 Text("Cancellation: \(Providers[index].cancellation) hrs")
 .foregroundColor(Color.secondary)
 .multilineTextAlignment(.leading)
 .font(Font.system(size: 13,
 weight: .regular,
 design: .serif))
 //                                            .padding(.horizontal, 10)
 //                                    .padding(.horizontal)
 Text(Providers[index].calloutCharge ? "Callout charge" : "")
 .foregroundColor(Color.secondary)
 .multilineTextAlignment(.leading)
 .font(Font.system(size: 13,
 weight: .regular,
 design: .serif))
 //                                            .padding(.horizontal, 10)

 }
 Spacer()
 VStack {
 Spacer()
 Image("StarIcon")
 .resizable()
 .aspectRatio(contentMode: .fit)
 .frame(width: 33, height: 33, alignment: .center)
 .overlay(content: {
 Rectangle().fill(Color.white).frame(width: 20, height: 14, alignment: .trailing).offset(x: 6.5, y: -1)
 Text(String(format: "%g", Providers[index].rating))
 .foregroundColor(.accentColor)
 .font(Font.system(size: 16,
 weight: .light,
 design: .serif)).offset(x: 6.5, y: 0)
 })
 }

 }.frame(width: geo.size.width / 2 - 40,height:  geo.size.height / 6)


 }

 //                                RoundedRectangle(cornerRadius: 15)//.blur(radius: 5)
 //.stroke(Color.secondary.opacity(0.3), lineWidth: 1.0)
 //                                    .fixedSize())
 }//.frame(width: geo.size.width / 2 - 40, height:  geo.size.height / 3)
 //                            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGray.opacity(0.5), lineWidth: 1.5)
 //                                .shadow(color: .secondary.opacity(0.6), radius: 3, y: 3)
 //                            )


 }

 }.padding(10)

 */
