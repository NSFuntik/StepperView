//
//  PrvRequestsTabView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/6/22.
//

import SwiftUI
import Combine
class CategoriesViewModel: ObservableObject {
    @Published var categories: Categories = []
    @StateObject var CategoryVM = CategoriesViewModel()
    var defaultCategories: Categories

    public static var shared = CategoriesViewModel()

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
    @StateObject var CategoryController = CategoriesViewModel.shared
    @StateObject var requestsController = RequestViewModel.shared
    @EnvironmentObject var tabController: TabController

    var body: some View {
        ZStack {
            VStack {
                if requestsController.requests.count > 0 {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach($requestsController.requests, id: \.self) { request in
                                Section {
                                    RequestsCell(request: request)
                                        .environmentObject(CategoryController.CategoryVM)
                                        .environmentObject(requestsController)
                                        .tag(request.wrappedValue.id)
                                        .padding(.horizontal, 10)
                                    if requestsController.requests.last!.id == request.id.wrappedValue {
                                        Spacer(minLength: 100)
                                    }
                                }
                            }

                        }.padding(.top, 15)
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
                        }
                    }
                }.frame(height: 50)
            }
        }.background(Color.white.opacity(0.7))
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
    @EnvironmentObject var requestsController: RequestViewModel
    @State var statusColor = Color.Green
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.multiplier = 0.01
        nf.numberStyle = .currency
        nf.locale = .init(identifier: "en_GB")
        return nf
    }()

    var body: some View {
        
        NavigationLink(destination: CstCreateRequestView(categories: request.services.map({$0.toCategoryService}),
                                                         cstRequest: $request.wrappedValue)
            .environmentObject(CategoryController.CategoryVM)
            .environmentObject(requestsController)) {
                VStack {
                    HStack {
                        HStack(spacing: 0)  {
                            Text("#\(request.id)")
                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Text(numberFormatter.string(from: request.offeredSum as NSNumber)!)
                            .multilineTextAlignment(.trailing)
                            .font(Font.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                            .lineLimit(1)
                    }.padding(.vertical, 5)
                    HStack {
                        Text("\(request.statusRecord.status)")
                            .font(Font.system(size: 17, weight: .regular, design: .rounded))
                            .foregroundColor(statusColor)
                        Spacer()
                        Text("\(request.visits) Visit")
                    }.padding(.top, -5.5).padding(.vertical, 5)
                    VStack(spacing: 7) {
                        HStack {
                            Text("Placed")
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
                    VStack(alignment: .leading, spacing: 5) {
                        RemovableTagListView(selected: $catID, isRemovable: .constant(false),
                                             categoriesVM: CategoriesViewModel.shared,
                                             tags:
                                .constant(Set(getCategoriesFor(request: request)
                                    .frequency.map({ category, count in
                                        return "\(category.title): \(count)"
                                    }))))
                        .disabled(true)
                        HStack {
                            Spacer()
                            Image("Magnifier")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 10, height: 10)
                                .scaledToFit()
                                .foregroundColor(Color.infoBlue)
                            Text("1")
                                .padding(.trailing, 5)
                                .foregroundColor(.secondary)
                            Image("Eye")
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: 10, height: 10)
                                .scaledToFit()
                                .foregroundColor(Color.infoBlue)
                            Text("10")
                                .padding(.trailing, 5)
                                .foregroundColor(.secondary)
                        }.padding([.top], 10)
                    }
                }
            }
            .padding(15).background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 13))
            .overlay(RoundedRectangle(cornerRadius: 13).stroke(lineWidth: 1).fill(Color.lightGray))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring()) {
                        $request.wrappedValue.services = $request.wrappedValue.services
                    }
                }
                if request.statusRecord.status == "CANCELED" {
                    statusColor = Color.red
                } else if request.statusRecord.status == "STOPPED" {
                    statusColor = Color.yellow
                } else {
                    statusColor = Color.accentColor
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
