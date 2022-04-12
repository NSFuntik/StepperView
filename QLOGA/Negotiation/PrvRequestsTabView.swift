//
//  PrvRequestsTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI
import Combine
class CategoriesViewModel: ObservableObject {
    //    typealias OffTime = OrderTime
    @Published var categories: Categories = []
    @StateObject var CategoryVM = CategoriesViewModel()
    //    @Published var totalPrice: NSNumber?
    var defaultCategories: Categories
    static let shared = CategoriesViewModel()
    //    @Published var OrderTime: OffTime = OffTime(from: "11/02/22 11:00", to: "11/02/22 21:00")
    @Published var pickedService: Category.ID {
        willSet {
            objectWillChange.send()
        }
    }
    init() {
        self.pickedService = CategoryService.init().id
        self.defaultCategories = try! newJSONDecoder().decode(Categories.self, from: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "categories", ofType: "json")!)))
        categories.append(contentsOf: defaultCategories)
    }
}


struct PrvRequestsTabView: View {
    @Binding var provider: Provider
    @Binding var customer: Customer
    @StateObject var CategoryController = CategoriesViewModel()
    @StateObject var requestsController = RequestViewModel()

    var body: some View {
        VStack {

            ScrollView {

                VStack {
                    if requestsController.requests.count > 0 {

                        ForEach($requestsController.requests.projectedValue.indices) { i in
                            RequestsCell(request: $requestsController.requests.element(at: i)!, category: $CategoryController.categories[i].wrappedValue)
                                .background(.white).padding(10)
                            Divider().foregroundColor(.secondary)
                        }
                    } else {
                        Spacer(minLength: 100)
                        Image("RequestsImage")
                            .resizable()
                            .frame(width: 300, height: 375, alignment: .center)
                            .scaledToFit()
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.lightGray.opacity(0.2))
                    }
                    Spacer()
                }
            }
            HStack {
                NavigationLink {
                    CstOpenRequestsView(CategoryVM: CategoryController)
                } label: {
                    VStack {
                        Rectangle().foregroundColor(.clear)
                            .ignoresSafeArea(.container, edges: .horizontal)
                            .overlay {
                                HStack {
                                    Text("Create Open Request")
                                        .withDoneButtonStyles(backColor: .Green, accentColor: .white)
                                }
                            }.zIndex(1)
                    }.padding(.bottom, 15)
                }
            }.frame(height: 50)
        }
        .padding(20)
    }
}

struct PrvRequestsTabView_Previews: PreviewProvider {
    static var previews: some View {
        PrvRequestsTabView(provider: .constant(testProvider), customer: .constant(testCustomer))
    }
}

struct RequestsCell: View {
    typealias Int = ServiceType.ID
    @Binding var request: CstRequest
    @State var category: Category
    var body: some View {
            NavigationLink(destination: CstCreateRequestView(bottomSheetPosition: .hidden, showInfo: false, text: "", category: $category, cstRequest: request)) {
                VStack {
                HStack {
                    Text("#\(request.id)(\(request.statusRecord.status))")
//                        .multilineTextAlignment(.leading)
//                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
//                        .foregroundColor(.black)
//                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
//                        .lineLimit(1)
                    Spacer()
                    Text("£\(request.offeredSum).00")                     .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
                    Divider().padding(.horizontal, -10).padding(.leading, 10)                            .ignoresSafeArea(.container, edges: .horizontal)

                HStack {
                    Text("Placed")
                        .multilineTextAlignment(.leading)

                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(getString(from: request.placedDate, "dd/MM/yy HH:mm"))
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
                    Divider().foregroundColor(.black)
                HStack {
                    Text("Ordered:")
                        .multilineTextAlignment(.leading)

                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(getString(from: request.placedDate, "dd/MM/yy HH:mm"))
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
                    Divider().padding(.horizontal, -10).padding(.leading, 10)                            .ignoresSafeArea(.container, edges: .horizontal)

                HStack {
                    Text("Valid until:")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(getString(from: request.validDate, "dd/MM/yy HH:mm"))
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
                    Divider().padding(.horizontal, -10).padding(.leading, 10)                            .ignoresSafeArea(.container, edges: .horizontal)

                HStack {
                    Text("Looked")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(request.visits.description)
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.black)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
//                HStack {
//                    RemovableTagListView(selected: $category.id, isRemovable: .constant(false),
//                                         categoriesVM: CategoriesViewModel.shared,
//                                         tags:
//                            .constant(Set($category.projectedValue.services.filter({$0.unitsCount.wrappedValue > 0})
//                                .compactMap {_ in return "\(category.name.wrappedValue!): \(request.services.filter {$0.unitsCount.wrappedValue > 0}.count)"
//                                })))
//                }

//                Divider().padding(.horizontal, -10).padding(.leading, 10)
//                HStack {
//                    Text("\(request.visits) Visit")
//                    Spacer()
//                    Image("Magnifier")
//                        .resizable()
//                        .frame(width: 10, height: 10)
//                        .scaledToFit()
//                        .foregroundColor(Color.infoBlue)
//                    Text("1")
//                        .padding(.trailing, 5)
//                    Image("Eye")
//                        .resizable()
//                        .frame(width: 10, height: 10)
//                        .scaledToFit()
//                        .foregroundColor(Color.infoBlue)
//                    Text("10")
//                        .padding(.trailing, 5)
//                }
            }
        }
    }
}
