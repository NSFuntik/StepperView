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
    var body: some View {
        //        GeometryReader { geo in
        ScrollView {

            LazyVGrid(columns: [
                grid,
                grid
            ], alignment: .center, spacing: 10) {
                ForEach(Providers, id: \.self) { provider in

                    NavigationLink(destination: ProviderOverview()) {
                        ZStack {
                            VStack(alignment: .leading) {
                                Image("WomanCleaner")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)

                                Text(provider.name)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 15,
                                                      weight: .regular,
                                                      design: .serif))
                                    .padding(.horizontal, 10)
                                    .padding(.top, -5)
                                Text("Cancellation: \(provider.cancellation) hrs")
                                    .foregroundColor(Color.secondary)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 13,
                                                      weight: .regular,
                                                      design: .serif))
                                    .padding(.horizontal, 10)
                                //                                    .padding(.horizontal)
                                Text(provider.calloutCharge ? "Callout charge" : "")
                                    .foregroundColor(Color.secondary)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 13,
                                                      weight: .regular,
                                                      design: .serif))
                                    .padding(.horizontal, 10)

                                //                                RoundedRectangle(cornerRadius: 15)//.blur(radius: 5)
                                //.stroke(Color.secondary.opacity(0.3), lineWidth: 1.0)
                                //                                    .fixedSize())
                            }.background(RoundedRectangle(cornerRadius: 15).stroke(Color.lightGray.opacity(0.5), lineWidth: 1.5)
                                .shadow(color: .secondary.opacity(0.6), radius: 3, y: 3))
                            VStack {
                                Spacer()
                                HStack{
                                    Spacer()
                                    Image("StarIcon")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 33, height: 33, alignment: .center)
                                        .padding(4)
                                        .overlay(content: {
                                            Rectangle().fill(Color.white).frame(width: 20, height: 14, alignment: .trailing).offset(x: 6.5, y: -1)
                                            Text(String(format: "%g", provider.rating))
                                                .foregroundColor(.accentColor)
                                                .font(Font.system(size: 16,
                                                                  weight: .light,
                                                                  design: .serif)).offset(x: 6.5, y: 0)
                                        })
                                }
                            }

                        }
                    }

                }
            }
        }.navigationTitle("Providers")
            .toolbar {
                HStack {
                    Spacer()
                    Button {
                        isFiltersPresented.toggle()
                    } label: {
                        Image("FilterIcon").resizable().frame(width: 30, height: 30, alignment: .center).accentColor(Color.accentColor).foregroundColor(.accentColor)
                            .padding(5)
                    }
                    NavigationLink(destination: GoogleMapView(providers: .constant([Address(postcode: "", town: "", street: "", -33.86, 151.20), Address(postcode: "", town: "", street: "", -33.26, 151.24),Address(postcode: "", town: "", street: "", -32.26, 151.34)]), pickedAddress: .constant(Address(postcode: "", town: "", street: "", locationManager.latitude, locationManager.longitude)))) {
                        Image("MapIcon").resizable().frame(width: 30, height: 30, alignment: .center)
                            .padding(5)
                    }

                }
            }
            .sheet(isPresented: $isFiltersPresented) { ProvidersFilterView().cornerRadius(35)}
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
