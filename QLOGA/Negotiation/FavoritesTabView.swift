//
//  FavoritesTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI
import Combine



struct FavoritesTabView: View {
    @Binding var actorType: ActorsEnum
    @State var providers: [Provider] = [testProvider, testProvider, testProvider, testProvider, testProvider]
    @State var customers: [Customer] = [testCustomer, testCustomer, testCustomer, testCustomer, testCustomer]
    @EnvironmentObject var tabController: TabController
    var body: some View {
        VStack {
            if actorType == .CUSTOMER {
                List($providers) { prv in
                    Section {
                        FavoriteProvidersCell(provider: prv)
                    }
                }.listStyle(.inset)
            } else {
                List($customers) { cst in
                    Section {
                        FavoriteCustomersCell(customer: cst)
                    }
                }.listStyle(.inset)
            }
            //            Text("Hello, World!")
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Favorite \(actorType == .CUSTOMER ? "Providers" : "Customers")").navigationViewStyle(.stack)
    }
}

struct FavoritesTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FavoritesTabView(actorType: .constant(.CUSTOMER))
        }.previewDevice("iPhone 6s")
    }
}

struct FavoriteProvidersCell: View {
    @Binding var provider: Provider
    //    @State var tags : RemovableTagListView?    //    @EnvironmentObject var tabController: TabController
    //    init(provider: Binding<Provider>) {
    //        self._provider = provider
    ////        self.tags.makeUIView(context: .dynamic)
    ////        self.tags..rearrangeViews()
    //    }
    var body: some View {
        NavigationLink(destination: ProfilePublicView(actorType: .PROVIDER, customer: .constant(testCustomer), provider: $provider)) {
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    Image(provider.avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 130, alignment: .center)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray)).padding(1).padding(.top, 2)

                }.padding(.trailing, 10)
                VStack(alignment: .leading, spacing: 0) {
                    Text(provider.name)
                        .foregroundColor(Color.black.opacity(0.8))
                        .multilineTextAlignment(.leading)
                        .frame(width: 200, height: 25, alignment: .topLeading)
                        .font(Font.system(size: 200,
                                          weight: .medium,
                                          design: .rounded))
                        .minimumScaleFactor(0.05)
                    Text(provider.address.town)
                        .foregroundColor(Color.black.opacity(0.8))
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 15,
                                          weight: .regular,
                                          design: .rounded))
                        .frame(width: 100, alignment: .leading).padding(.bottom, 2.5)

                    Section {
                        RemovableTagListView(selected: .constant(0.serviceTypeID.rawValue), isRemovable: .constant(false),
                                             categoriesVM: CategoriesViewModel.shared,
                                             tags:
                                .constant(Set($provider.wrappedValue.services.compactMap({ category in
                                    return "\(qServiceID[category.id]!.title)"//: \(count)"
                                }))), fontSize: 15).frame(width: 230, height: 35, alignment: .leading).ignoresSafeArea().disabled(true)
                            .layoutPriority(1)
                        Spacer()
                    }.scaleEffect(0.75).offset(x: -30)
                        .padding(.vertical, 5)

                    Button {
                        //                            dismiss()
                    } label: {
                        VStack {
                            Rectangle().foregroundColor(.clear)
                                .ignoresSafeArea(.container, edges: .horizontal)
                                .overlay {
                                    HStack {
                                        Text("Direct Inquiry")
                                            .withDoneButtonStyles(backColor: .Green, accentColor: .white, isWide: false, width: 200, height: 35, isShadowOn: true)
                                    }
                                }
                        }
                    }.frame(width: 200, height: 40, alignment: .topLeading).offset(y: -3)

                }
            }.padding(.vertical, 5)

        }.onAppear {


            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0.5)) {

                    $provider.wrappedValue.services = $provider.wrappedValue.services
                }
            }
            //            self.tags =
            //            self.tags?.fontSize = 8
            //            self.tags.frame(width: 200, height: 60, alignment: .leading)
        }
    }
    func getCategoriesFor(provider: Provider) -> [CategoryType] {
        var categories: [CategoryType] = []
        let qServiceIDDict = qServiceID
        provider.services.forEach { s in
            qServiceIDDict.keys.compactMap { qId in
                if qId == s.sortOrder {
                    categories.append(qServiceID[qId]!)
                }
            }
        }
        return categories
    }
}

struct FavoriteCustomersCell: View {
    @Binding var customer: Customer

    var body: some View {
        NavigationLink(destination: ProfilePublicView(actorType: .CUSTOMER, customer: $customer, provider: .constant(testProvider))) {
            HStack {
                VStack(alignment: .center, spacing: 0) {
                    Image(customer.avatar)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 110, alignment: .center)
                        .cornerRadius(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 1.0)
                            .foregroundColor(Color.lightGray)).padding(1).padding(.top, 2)

                }.padding(.trailing, 10)
                VStack(alignment: .leading, spacing: 5) {
                    Text(customer.name + " " + customer.surname)
                        .foregroundColor(Color.black.opacity(0.8))
                        .multilineTextAlignment(.leading)
                        .frame(width: 200, height: 25, alignment: .topLeading)
                        .font(Font.system(size: 200,
                                          weight: .medium,
                                          design: .rounded))
                        .minimumScaleFactor(0.05)
                    Text(customer.address.town)
                        .foregroundColor(Color.black.opacity(0.8))
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 15,
                                          weight: .regular,
                                          design: .rounded))
                        .frame(width: 100, alignment: .leading)
                    Text(customer.address.total)
                        .lineLimit(1)
                        .foregroundColor(Color.secondary.opacity(0.8))
                        .font(Font.system(size: 13,
                                          weight: .regular,
                                          design: .rounded))
                        .frame(width: 210, alignment: .leading)
                        .ignoresSafeArea(.container, edges: .trailing)
                        .padding(.vertical, 5)
                    Button {
                        //                            dismiss()
                    } label: {
                        VStack {
                            Rectangle().foregroundColor(.clear)
                                .ignoresSafeArea(.container, edges: .horizontal)
                                .overlay {
                                    HStack {
                                        Text("Quote")
                                            .withDoneButtonStyles(backColor: .Green, accentColor: .white, isWide: false, width: 200, height: 35, isShadowOn: true)
                                    }
                                }
                        }
                    }.frame(width: 200, height: 40, alignment: .bottomLeading)

                }
            }.padding(.vertical, 5)

        }.onAppear {

            //            self.tags =
            //            self.tags?.fontSize = 8
            //            self.tags.frame(width: 200, height: 60, alignment: .leading)
        }
    }
}
