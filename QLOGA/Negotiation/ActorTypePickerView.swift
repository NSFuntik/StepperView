//
//  ActorTypePickerView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/8/22.
//

import SwiftUI
import Combine

struct ActorTypePickerView: View {
    @State var selectedService: Int = 1
    @State var actorType: ActorsEnum = .CUSTOMER
    @State var selectedActor: ActorsEnum = .CUSTOMER
    @StateObject var viewRouter = TabController()

    @State var isPicked = true
    var body: some View {

        ZStack {

            VStack(alignment: .center, spacing: 10) {
                HStack(alignment: .center) {
                    ServicesScrollView
                        .padding([.top])
                        .ignoresSafeArea(.all, edges: .bottom)
                        .offset(x: 10, y: 0)

                        .background(
                            HStack {

                                RoundedRectangle(cornerRadius: 16, style: .circular)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .circular))
                                    .padding([.horizontal, .bottom], -7.5)

                                    .padding(.trailing,  -20)
                                    .ignoresSafeArea(.all, edges: .bottom)
                                    .foregroundColor(selectedService >= 0 ? Color.accentColor.opacity(0.2) : .white)
                                    .frame(maxWidth: 90)
                            }).offset(x: selectedService >= 0 ? 10 : 0)
                        .zIndex(1)
                                        if UIScreen.main.nativeBounds.height < 2436 {
                    Spacer(minLength: 35)

                                        } else {
                                            Spacer(minLength: 50)
                                        }


                    ProfileChooserView
                        .frame(width: .infinity, alignment: .trailing)
                        .padding(.bottom, 10)
                                    }
                }.padding(.top, 10).padding(.horizontal, 20).offset(x: -7.5)
//            VStack {
//                Spacer(minLength: UIScreen.main.bounds.height - 130)
//                Button {
//                    isPicked = true
//
//                } label: {
//                    VStack {
//                        Spacer()
//                        Rectangle().foregroundColor(.clear)
//                            .ignoresSafeArea(.container, edges: .horizontal)
//                            .overlay {
//                                HStack {
//                                    Text("Sing In")
//                                        .withDoneButtonStyles(backColor: .white, accentColor: .Green)
//                                }
//                            }.zIndex(1)
//                    }.padding(.bottom, 15)
//                }
//
//
//
//
//                    }.frame(height: 55).zIndex(1)


                .fullScreenCover(isPresented: $isPicked, content: {
                    ProfileHomeTabBarView(actorType: $actorType, tabController: viewRouter)
                })
        }

        .navigationBarTitle("")
        .navigationBarHidden(true)
        .environment(\.colorScheme, .light)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("").navigationViewStyle(.stack)


    }
}

struct ActorTypePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ActorTypePickerView()
            .previewDevice("iPhone 6s")
    }
}

extension ActorTypePickerView {

    private var ServicesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Services) { service in
                Button {
                    selectedService = service.id
                } label: {
                    VStack {
                        Image(service.image)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedService == service.id ? Color.accentColor : Color.lightGray.opacity(0.6),
                                            lineWidth: selectedService == service.id ? 2.0 : 1.5)
                            ).padding(.bottom, -3).padding(.top, 2)
                        Text(service.name)
                            .foregroundColor(Color.black)
                            .font(.system(size: 12.0, weight: .light, design: .rounded))
                    }.padding([.bottom, .horizontal], 1)
                        .frame(maxWidth: 70)
                }
            }
            Spacer(minLength: 70)
        }
    }

    private var ProfileChooserView: some View {
        GeometryReader { geometry in

            VStack(alignment: .center, spacing: 30) {
                Button {
                    $actorType.wrappedValue = ActorsEnum.CUSTOMER
                        isPicked = true

                } label: {
                    VStack(alignment: .center, spacing: 10) {
                        Image("CustomerImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.horizontal, .top], 5)
                        Text("Customer")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium,
                                          design: .rounded))

                    }
                    .padding(.bottom, 10).padding(.horizontal, 25)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(selectedActor != ActorsEnum.CUSTOMER ? Color.lightGray.opacity(0.5) : .accentColor, lineWidth: 2)).padding(0).clipShape(RoundedRectangle(cornerRadius: 16))
                }.offset( y: 2.5)

                    .background(ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(selectedActor == ActorsEnum.PROVIDER ? Color.accentColor.opacity(0.2) : .white)
                            .padding(.horizontal, 25)
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(selectedActor == ActorsEnum.PROVIDER ? Color.accentColor.opacity(0.2) : .white)
                            .padding(.leading, -20).padding( -15)
                            .clipShape(Rectangle().offset(x: -17.5, y: 15))
                        RoundedRectangle(cornerRadius: 16, style: .continuous).padding(.leading,selectedActor == ActorsEnum.PROVIDER ? -12.5 : -45)
                            .padding([.vertical, .trailing], -15)
                            .foregroundColor(selectedActor == ActorsEnum.CUSTOMER ? Color.accentColor.opacity(0.2) : .white)

                    }).zIndex(1)

                Button {

                    $actorType.wrappedValue = ActorsEnum.PROVIDER

                        isPicked = true


                } label: {
                    VStack(alignment: .center, spacing: 10) {
                        Image("ProviderImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.horizontal, .top], 5)

                        Text("Become a provider")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .lineLimit(1)
                            .padding(.horizontal, -20)
                    }
                    .padding(.bottom, 10).padding(.horizontal, 25)
                    .background(Color.white)
                    .overlay( RoundedRectangle(cornerRadius: 16)
                        .stroke(selectedActor != ActorsEnum.PROVIDER ? Color.lightGray.opacity(0.5) : .accentColor, lineWidth: 2)).clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .background(
                    ZStack
                    {   RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(selectedActor == ActorsEnum.CUSTOMER ? Color.accentColor.opacity(0.2) : .white)
                            .padding(.horizontal, 25)
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(selectedActor == ActorsEnum.CUSTOMER ? Color.accentColor.opacity(0.2) : .white)
                            .padding(.leading, -20).padding( -15)
                            .clipShape(Rectangle().offset(x: -17.5, y: -15))
                        RoundedRectangle(cornerRadius: 16, style: .continuous).padding(.leading,selectedActor == ActorsEnum.CUSTOMER ? -12.5 : -30)
                            .padding([.vertical, .trailing], -15)
                            .foregroundColor(selectedActor == ActorsEnum.PROVIDER ? Color.accentColor.opacity(0.2) : .white)

                    }).zIndex(1)
                Button {
//                    selectedActor = ActorsEnum.CUSTOMER
//                    isPicked = true

                } label: {
                    VStack(alignment: .center, spacing: 10) {
                        Image("CustomerImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.horizontal, .top], 5)
                        Text("Customer")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .medium,
                                          design: .rounded))

                    }
                    .padding(.bottom, 10).padding(.horizontal, 25)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(selectedActor != ActorsEnum.CUSTOMER ? Color.lightGray.opacity(0.5) : .accentColor, lineWidth: 2)).padding(0).clipShape(RoundedRectangle(cornerRadius: 16))
                }.offset( y: 2.5).hidden()

                    .background(ZStack {
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(selectedActor == ActorsEnum.PROVIDER ? Color.accentColor.opacity(0.2) : .white)
                            .padding(.horizontal, 25)
                        RoundedRectangle(cornerRadius: 16, style: .circular)
                            .foregroundColor(selectedActor == ActorsEnum.PROVIDER ? Color.accentColor.opacity(0.2) : .white)
                            .padding(.leading, -20).padding( -15)
                            .clipShape(Rectangle().offset(x: -17.5, y: -15))
                        RoundedRectangle(cornerRadius: 16, style: .continuous).padding(.leading,selectedActor == ActorsEnum.PROVIDER ? -12.5 : -15)
                            .padding([.vertical, .trailing], -15)
                            .foregroundColor(selectedActor == ActorsEnum.CUSTOMER ? Color.white.opacity(0.2) : .white)

                    }).zIndex(1)


            }.frame(maxWidth: geometry.size.width).padding([.top], 15)

        }.frame(maxWidth: .infinity)
    }
}
