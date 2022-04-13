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
        self.defaultCategories = try! newJSONDecoder().decode(Categories.self, from: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "categories", ofType: "json")!)))
        self.pickedService = defaultCategories.first!.id 
        self.categories.append(contentsOf: defaultCategories)
    }
}


struct CstRequestsTabView: View {
    @Binding var provider: Provider
    @Binding var customer: Customer
    @StateObject var CategoryController = CategoriesViewModel.init()
    @StateObject var requestsController = RequestViewModel()
    @EnvironmentObject var tabController: TabController
  
    var body: some View {
        ZStack {
                VStack {
                    if requestsController.requests.count > 0 {
                        List($requestsController.requests.projectedValue, id: \.self) { request in

                                Section {

                                    RequestsCell(request: request).environmentObject(CategoryController.CategoryVM)
                                       .padding(10)
                                        .tag(request.wrappedValue.id)
                                    //                                Divider().foregroundColor(.secondary)


                                if requestsController.requests.last!.id == request.id.wrappedValue {
                                    Spacer(minLength: 100)
                                }
                            }
                        }.listStyle(InsetListStyle())

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
            VStack {
                Spacer()
                HStack {
                    NavigationLink {
                        CstOpenRequestsView(CategoryVM: CategoryController)
                            .environmentObject(requestsController)
                            .environmentObject(tabController)
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
                        }//.padding(.bottom, 15)
                    }
                }.frame(height: 50)
            }
        }.onAppear {
//            tabController.activeActor = actorType
        }
//        .padding(.horizontal , 20)
    }
}

struct PrvRequestsTabView_Previews: PreviewProvider {
    static var previews: some View {
        CstRequestsTabView(provider: .constant(testProvider), customer: .constant(testCustomer))
    }
}

struct RequestsCell: View {
    typealias Int = CategoryType.ID
    @Binding var request: CstRequest
    @State var catID: CategoryType.ID = 0
    @EnvironmentObject var CategoryController: CategoriesViewModel
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.multiplier = 0.01
        nf.numberStyle = .currency
        nf.locale = .init(identifier: "en_GB")
        return nf
    }()

//    @State var services: [CategoryService]
    var body: some View {
        
        NavigationLink(destination: CstCreateRequestView(categories: request.services.map({$0.toCategoryService}), cstRequest: $request.wrappedValue).environmentObject(CategoryController.CategoryVM)) {
                VStack {
                HStack {
                    HStack(spacing: 0)  {
                        Text("#\(request.id)") .font(Font.system(size: 17, weight: .regular, design: .rounded)).foregroundColor(.black)
                        Text("(\(request.statusRecord.status))")
                            .font(Font.system(size: 17, weight: .regular, design: .rounded)).foregroundColor(.lightGray)
                    }
                    Spacer()
                    Text(numberFormatter.string(from: request.offeredSum as NSNumber)!)
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.accentColor)
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 15, weight: .regular, design: .rounded))
                        .padding(.horizontal, 5)
                        .padding(.trailing, -10)
                }.padding(.vertical, 5)
//                    Divider().background(Color.lightGray.opacity(0.2))
                    VStack(spacing: 7) {

                        HStack {
                            Text("Placed")
                                .multilineTextAlignment(.leading)

                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                                .foregroundColor(.black)
                            //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                                .lineLimit(1)
                            Spacer()
                            Text(getString(from: request.placedDate, "dd/MM/yy HH:mm"))
                                .multilineTextAlignment(.trailing)
                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                                .foregroundColor(.black)
                            //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                                .lineLimit(1)
                        }
                        Divider().background(Color.lightGray.opacity(0.2))
                        HStack {
                            Text("Ordered:")
                                .multilineTextAlignment(.leading)

                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                                .foregroundColor(.black)
                                .lineLimit(1)
                            Spacer()
                            Text(getString(from: request.placedDate, "dd/MM/yy HH:mm"))
                                .multilineTextAlignment(.trailing)
                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                                .foregroundColor(.black)
                                .lineLimit(1)
                        }
                        Divider().background(Color.lightGray.opacity(0.2))
                        HStack {
                            Text("Valid until:")
                                .multilineTextAlignment(.leading)
                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                                .foregroundColor(.black)
                                .lineLimit(1)
                            Spacer()
                            Text(getString(from: request.validDate, "dd/MM/yy HH:mm"))
                                .multilineTextAlignment(.trailing)
                                .font(Font.system(size: 17, weight: .light, design: .rounded))
                                .foregroundColor(.black)
                                .lineLimit(1)
                        }
                    }
//                    Divider().background(Color.lightGray.opacity(1))
                    VStack(alignment: .leading, spacing: 5) {
                    RemovableTagListView(selected: $catID, isRemovable: .constant(false),
                                         categoriesVM: CategoriesViewModel.shared,
                                         tags:
                            .constant(Set(getCategoriesFor(request: request).frequency.map({ category, count in
                                return "\(category.title): \(count)"
                            })))).disabled(true)

                    HStack {
                        Text("\(request.visits) Visit")
                        Spacer()
                        Image("Magnifier")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 10, height: 10)
                            .scaledToFit()
                            .foregroundColor(Color.infoBlue)
                        Text("1")
                            .padding(.trailing, 5)
                        Image("Eye")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 10, height: 10)
                            .scaledToFit()
                            .foregroundColor(Color.infoBlue)
                        Text("10")
                            .padding(.trailing, 5)
                    }.padding([.top], 10)
                }

            }
        }
    }
    func getCategoriesFor(request: CstRequest) -> [CategoryType] {
        var categories: [CategoryType] = []
        let qServiceIDDict = qServiceID
        request.services.forEach { s in
            qServiceIDDict.keys.compactMap { qId in
                if qId == s.qserviceId {
                    categories.append(qServiceID[qId]!)
                }
            }
        }
        return categories
    }
}

extension Sequence where Element: Hashable {
    var frequency: [Element: Int] { reduce(into: [:]) { $0[$1, default: 0] += 1 } }
}
//HStack {
//    Text("Looked")
//        .multilineTextAlignment(.leading)
//        .font(Font.system(size: 17, weight: .regular, design: .rounded))
//        .foregroundColor(.black)
//    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
//        .lineLimit(1)
//    Spacer()
//    Text(request.visits.description)
//        .multilineTextAlignment(.trailing)
//        .font(Font.system(size: 17, weight: .regular, design: .rounded))
//        .foregroundColor(.black)
//    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
//        .lineLimit(1)
//    }
