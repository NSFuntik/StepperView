//
//  CstOpenRequestsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/9/22.
//

import SwiftUI
import Combine

struct CstOpenRequestsView: View {
    @State var opacity = 0
    @State var isLimited = true
    @State var tags: Set<String> = []
    @ObservedObject var CategoryVM: CategoriesViewModel
    @EnvironmentObject var requestsController: RequestViewModel
    @EnvironmentObject var tabController: TabController
    @Environment(\.dismiss) var dismiss
    @State var CatTags: [(String, Int)] = []

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            ZStack {
                VStack {
                    ServicesScrollView.padding(.horizontal, -30)
                    CstCatServiceCells
                }.padding(.horizontal, 20).padding(.top, 10)
                if $CategoryVM.categories.wrappedValue.filter({cat in cat.services.filter({$0.unitsCount > 0}).count > 0}).count > 0 {
                    VStack {
                        Spacer(minLength: UIScreen.main.bounds.height - 150)
                        NavigationLink(destination: CstCreateRequestView(categories: CategoryVM.categories.flatMap({cat in
                            cat.services.filter({$0.unitsCount > 0})}))
                            .environmentObject(CategoryVM)
                            .environmentObject(requestsController)
                            .environmentObject(tabController)
                        ) {
                            VStack {
                                Spacer()
                                Rectangle().foregroundColor(.clear)
                                    .ignoresSafeArea(.container, edges: .horizontal)
                                    .overlay {
                                        HStack {
                                            Text("Add services")
                                                .withDoneButtonStyles(backColor: .accentColor, accentColor: .white)
                                        }
                                    }.zIndex(1)//.opacity($tags.wrappedValue.count > 0 ? 1 : 0)
                            }.padding(.bottom, 20)
                        }
                    }
                }
            }
        }.onChange(of: requestsController.saved) { i in
            withAnimation {
                dismiss()
            }
        }
        .onAppear {
            requestsController.$saved.sink(receiveValue: { saved in
                guard saved else { return }
                requestsController.saved = false
                dismiss()
            })
        }
    }
}
//                        CatTags.append(contentsOf: tags.compactMap { tag in
//                            (tag.filter({$0.isLetter}), Int(tag.filter({$0.isNumber}))!)
//                        })

//                        $CategoryVM.pickedService.wrappedValue.append($CategoryVM.categories.first(where: {$0.name == CatTags[$0.id].0}))
extension CstOpenRequestsView {
    private var CstCatServiceCells: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                RemovableTagListView(selected: $CategoryVM.pickedService , isRemovable: .constant(true),
                                     categoriesVM: CategoryVM,
                                     tags:
                                        Binding {
                    Set($CategoryVM.categories.sorted(by: { $0.id.wrappedValue < $1.id.wrappedValue })
                        .compactMap { cat in
                            if cat.services.filter({$0.unitsCount.wrappedValue > 0}).count > 0 {
                                //                                    $CategoryVM.pickedCategories.first(where: { $0.id == cat.id})?.services.wrappedValue = cat.services.wrappedValue
                                return "\(cat.name.wrappedValue!): \( cat.services.filter {$0.unitsCount.wrappedValue > 0}.count)"
                            }
                            return "\(cat.name.wrappedValue!): \( cat.services.filter {$0.unitsCount.wrappedValue > 0}.count)" })
                } set: { tags in
                    self.tags = tags
                })

            }.animation(.easeInOut(duration: 0.5), value: tags).transition(.slide).padding(.bottom, 20)
            ScrollView(showsIndicators: false) {
                VStack {
                    Divider().padding(.horizontal, -10).padding(.leading, 10)

                    ForEach($CategoryVM.categories[CategoryVM.pickedService].services, id: \.self) { service in
                        Section {
                            DisclosureGroup(isExpanded: service.isEditable) {
                                VStack(spacing: 10) {
                                    Text(service.descr.wrappedValue ?? "nil")
                                        .foregroundColor(Color.secondary.opacity(0.7))
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                                        .lineLimit(5)
                                        .padding(10)
                                    HStack(alignment: .center, spacing: 10) {

                                        CategoryServiceCell(count: service.unitsCount,
                                                            price: service.price.wrappedValue, serviceType: service.wrappedValue)
                                        .padding(1)

                                        Spacer()
                                        NavigationLink(destination: CategoryServiceDetailView(service: service)) {
                                            HStack {

                                                Text("Details")
                                                    .lineLimit(1)
                                                    .font(.system(size: 20, weight: .regular, design: .default))
                                                    .foregroundColor(.infoBlue)
                                                    .frame(width: 100, height: 34)

                                                    .padding(1)
                                                    .background(
                                                        RoundedRectangle(cornerRadius: 8)
                                                            .stroke(Color.infoBlue, lineWidth: 2)
                                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white)))
                                                    .transition(.move(edge: .leading))
                                            }
                                            .frame(width: 100, height: 35)
                                        }
                                    }.padding(.horizontal, 10)

                                }.frame(width: UIScreen.main.bounds.width - 40, alignment: .center)
                            } label: {
                                HStack {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(service.name.wrappedValue ?? "nil")
                                                .foregroundColor(Color.black.opacity(0.9))
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                .lineLimit(1)
                                            //                                            .padding(.leading, 10)
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack(alignment: .bottom, spacing: 5) {
                                            VStack {
                                                HStack {
                                                    Text("Time norm: " + (service.timeNorm.wrappedValue?.description ?? "0") + " min/room")
                                                        .foregroundColor(Color.secondary)
                                                        .multilineTextAlignment(.leading)
                                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                        .lineLimit(1)
                                                    Spacer()

                                                }

                                                if !service.isEditable.wrappedValue {
                                                    CategoryServiceCell(count: service.unitsCount,
                                                                        price: service.price.wrappedValue, serviceType: service.wrappedValue).padding(1)
                                                }

                                            }
                                            Spacer()
                                            Text("£" + "\(service.unitsCount.wrappedValue.double * service.price.wrappedValue)")
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .medium, design: .rounded))
                                                .lineLimit(1)
                                        }
                                    }

                                }.padding(5)
                            }
                            Divider().padding(.horizontal, -10).padding(.leading, 10)
                        }
                    }
                }//.padding(10)
                //            .padding(10).padding(.bottom, -10)
                //                .overlay(RoundedRectangle(cornerRadius: 10)
                //                    .stroke(Color.secondary
                //                        .opacity(0.7), lineWidth: 1).padding(1))
            }.layoutPriority(1)
        }
    }







    private var ServicesScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                HStack {
                    ForEach($CategoryVM.categories.sorted(by: { $0.sortOrder.wrappedValue ?? $0.id.wrappedValue < $1.sortOrder.wrappedValue ?? $1.id.wrappedValue })) { service in
                        Button {
                            $CategoryVM.pickedService.wrappedValue = service.id.wrappedValue
                        } label: {
                            VStack {
                                Image(service.name.wrappedValue ?? "Default")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke($CategoryVM.pickedService.wrappedValue == service.id.wrappedValue ? Color.accentColor : Color.lightGray.opacity(0.6),
                                                    lineWidth: CategoryVM.pickedService == service.id ? 2.0 : 1.5)
                                    ).padding(.bottom, -3).padding(.top, 1)

                                Text(service.name.wrappedValue ?? "")
                                    .foregroundColor(Color.black)
                                    .font(.system(size: 15.0, weight: .light, design: .rounded))
                                    .padding(.bottom, 5)
                            }//.environmentObject($CategoryVM.pickedService)
                            .id($CategoryVM.pickedService.wrappedValue)
                            .frame(maxHeight: 90)
                            .padding(.horizontal, 10)
                        }
                    }.onChange(of: $CategoryVM.pickedService.wrappedValue) { i in
                        withAnimation {
                            value.scrollTo($CategoryVM.pickedService.wrappedValue, anchor: .center)
                        }
                    }
                }
            }.padding(.leading, 20)
        }.padding(.top, 10)
    }
}

struct CstOpenRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        CstOpenRequestsView( CategoryVM: .init())
    }
}


struct CategoryServiceCell: View {
    // MARK: Lifecycle

    init(count: Binding<Int>, price: Double = 30, serviceType: CategoryService) {
        _count = count
        self.price = price
        self.serviceType = serviceType
        title = serviceType.name ?? ""
    }

    // MARK: Internal

    @Binding var count: Int
    var price: Double
    @State var serviceType: CategoryService
    var title: String

    var body: some View {
        VStack {

            //            NavigationLink(destination: CategoryServiceDetailView(service: $serviceType).navigationTitle(title)) {
            HStack(alignment: .top) {
                LabeledStepper("", description: "",
                               value: $count, in: 0 ... 10,
                               longPressInterval: 1.0,
                               repeatOnLongPress: true, style: .init()).padding(1)
                //                    Image(systemName: "chevron.right")
                //                        .foregroundColor(Color.accentColor)
                //                        .multilineTextAlignment(.leading)
                //                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                //                        .padding(.leading, 10)
            }
            //            }
        }
    }
}



