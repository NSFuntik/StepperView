//
//  CstCreateRequestView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/10/22.
//
import Combine
import SwiftUI
import AnyFormatKitSwiftUI
import BottomSheetSwiftUI
class RequestViewModel: ObservableObject {
    public let objectWillChange = PassthroughSubject<Void, Never>()
    @Published var requests: CstRequests = [] {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var saved = false // This can store any value.

    static let shared = RequestViewModel()

//    @Published var notes = ""
    init() {
        let requestsMeta: CstRequestMeta = try! newJSONDecoder().decode(CstRequestMeta.self, from: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "requests", ofType: "json")!)))
        self.requests = requestsMeta.requests
        print(self.requests)
        print(requestsMeta)
    }

    func createRequest(request: CstRequest, completion: @escaping () -> ()) {
        self.requests.append(request)
            //.requests.append(request)
        completion()
    }

}
enum RequestBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 0.4
    case hidden = 0.0
}
struct CstCreateRequestView: View {
    @State var bottomSheetPosition: RequestBottomSheetPosition = .hidden
    @State var showInfo = false
    @State var text = ""
    @State private var lastText = ""
    @EnvironmentObject var requestsController: RequestViewModel
    @EnvironmentObject var tabController: TabController
    @EnvironmentObject var CategoryVM: CategoriesViewModel
    @State var requestInfo: CstRequest? = nil
   

//    @StateObject var RequestVM = RequestViewModel()
//    @FocusState private var focusedField: Field?
//    @ObservedObject var CategoryVM: CategoriesViewModel
//    @State var categories: [Category]
    @State var categories: [CategoryService]

    @State var cstRequest = CstRequest(
        statusRecord: .init(date: getString(from: Date(), "YYYY-MM-DDTHH:MM:SS") + ".312336Z", actor: "CUSTOMER", actorId: 1002, action: "CREATE", status: "LIVE", display: "LIVE"),
        id: 0, offeredSum: 0, placedDate: Date(), orderedDate: Date(),
        validDate: Date(timeInterval: TimeInterval(1), since: Date()),
        visits: 1, address: testProvider.address.defaultAddress, services: [],
        cstActions: [CstCstAction.cancel, .stop, .update], notes: "Enter your note")
//    @FocusState var isEditingPrice: Bool
    @Environment(\.dismiss) var dismiss
    @State private var totalChars = 1

    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.multiplier = 0.01
        nf.numberStyle = .currency
        nf.locale = .init(identifier: "en_GB")
        return nf
    }()

    var body: some View {//.filter{$0.unitsCount.wrappedValue > 0}.sorted(by: {$0.id < $1.id})
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 10) {
                    VStack {
                        ForEach($categories.sorted(by: {$0.id.wrappedValue < $1.id.wrappedValue}))//$categories.flatMap({$0.}).sorted(by: {$0.id.wrappedValue < $1.id.wrappedValue}))
                        { service in
                            Section {
                                NavigationLink(destination: CategoryServiceDetailView(service: service)) {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            Text(service.name.wrappedValue ?? "nil")
                                                .foregroundColor(Color.black.opacity(0.9))
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                .lineLimit(1)
                                            //                                            .padding(.leading, 10)
                                            Spacer()
                                            Text(service.unitsCount.wrappedValue.description)
                                                .foregroundColor(Color.lightGray.opacity(0.9))
                                                .multilineTextAlignment(.trailing)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                .lineLimit(1)
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color.Green)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                                .padding(.horizontal, 10)
                                        }
                                    }
                                }.padding(.horizontal, 5).frame(height: 40)
                                Divider().padding(.horizontal, -10).padding(.leading, 50)
                            }
                        }
                    }
                    .padding(10).padding(.bottom, -10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.secondary
                            .opacity(0.7), lineWidth: 1).padding(1))
                    VStack {
                        Section {

                            HStack(alignment: .center) {
                                Text("Ordered:")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 17,
                                                      weight: .regular,
                                                      design: .rounded))
                                //                            .padding(.horizontal, 25)
                                Spacer()
                                DatePicker("",
                                           selection: $cstRequest.orderedDate
//                                            Binding(get: {
//                                    getDate(from: $cstRequest.orderedDate,"YYYY-MM-DDTHH:MM:SSZ").wrappedValue
//                                }, set: { newValue in
//                                    $CategoryVM.OrderTime.from.wrappedValue = getString(from: newValue, "YYYY-MM-DDTHH:MM:SSZ")
//                                    let toDate = getDate(from: $cstRequest.orderedDate, "YYYY-MM-DDTHH:MM:SSZ").wrappedValue
//                                    let fotmatter = DateFormatter()
//                                    fotmatter.dateFormat = "YYYY-MM-DDTHH:MM:SSZ"
//                                    let fromDay = Int(fotmatter.string(from: newValue))!
//                                    let toDay = Int(fotmatter.string(from: toDate))!
//                                    if toDay < fromDay {
//                                        $CategoryVM.OrderTime.to.wrappedValue = getString(from: newValue, "YYYY-MM-DDTHH:MM:SSZ")
//                                    }
//                                })
                                           , displayedComponents: [.date, .hourAndMinute])

                            }.padding(.horizontal, 5).frame(height: 40)
                            Divider().padding(.horizontal, -10).padding(.leading, 25)
                        }
                        Section {
                            HStack(alignment: .center) {
                                Text("Total:")
                                    .foregroundColor(Color.black)
                                    .font(Font.system(size: 17,
                                                      weight: .regular,
                                                      design: .rounded))
                                //                                .padding(.horizontal, 25)
                                Spacer()
                                VStack(alignment: .trailing) {
                                    //                                FormatSumTextField(numberValue: $CategoryVM.totalPrice, textPattern: "£###.##")
                                    TextField("Total price:", value: $cstRequest.offeredSum, formatter: numberFormatter, prompt: Text("£80.00"))

//                                    Text("£80.00")

                                        .font(Font.system(size: 17,
                                                          weight: .semibold,
                                                          design: .rounded))
                                        .foregroundColor(Color.black)
                                        .keyboardType(.decimalPad)
                                        .gesture(DragGesture()
                                        .onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
                                        .toolbar{
                                            ToolbarItem(placement: .keyboard, content: {
                                                Button(role: ButtonRole.destructive) {
                                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                                } label: {
                                                    Text("Done")
                                                }})
                                        }
                                        .multilineTextAlignment(.trailing)
                                }
                            }.padding(.horizontal, 5).frame(height: 40)
                        }
                    }.padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary
                                .opacity(0.7), lineWidth: 1).padding(1))


                    VStack {
                        Button {
                            dismiss()
                        } label: {
                            VStack {
                                Rectangle().foregroundColor(.clear)
                                    .ignoresSafeArea(.container, edges: .horizontal)
                                    .overlay {
                                        HStack {
                                            Text("Add services")
                                                .withDoneButtonStyles(backColor: .white, accentColor: .accentColor, isWide: false, width: UIScreen.main.bounds.width - 50, height: 50, isShadowOn: false)
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.vertical, 20)

                    //            Spacer()

                    VStack {
                        //        if actorType != .CUSTOMER {}
                        NavigationLink(destination: AddressPickerView(pickedAddress: $cstRequest.address)) {
                            Label {
                                Text("Address")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Spacer()
//                                Text($RequestVM.requests[0].address.wrappedValue.total ?? "")
                                Text(cstRequest.address.total ?? "")
                                    .lineLimit(2)
                                    .foregroundColor(Color.secondary)
                                    .font(Font.system(size: 13, weight: .regular, design: .rounded))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.accentColor)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                    .padding(.leading, 10)
                            } icon: {
                                Image("RequestAddressIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(5)
                            }.padding(7)
                        }.frame(height: 40)
                        Divider().background(Color.secondary).padding(.leading, 50)
                        Section {
                            DisclosureGroup {
                                Picker("Visits count", selection: $cstRequest.visits) {
                                    ForEach(0 ..< 20) {
                                     if   $0 > 0 { Text("\($0)") }
                                    }.frame( height: 60, alignment: .center)
                                }.pickerStyle(.wheel)
                            } label: {
                                Label {
                                    Text("Visits")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("\(cstRequest.visits)")
                                        .lineLimit(2)
                                        .foregroundColor(Color.secondary)
                                        .font(Font.system(size: 13, weight: .regular, design: .rounded))

//                                    Image(systemName: "chevron.right")
//                                        .foregroundColor(Color.accentColor)
//                                        .multilineTextAlignment(.leading)
//                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
//                                        .padding(.leading, 10)
                                } icon: {
                                    Image("RequestVisitsIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                }.frame(height: 40)
                            }
                        }
                        Divider().background(Color.secondary).padding(.leading, 50)
                        Section {
                            Button {
                                //                                showInfo = true
                                $bottomSheetPosition.wrappedValue = .middle
                            } label: {
                                Label {
                                    Text("Details")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("Placed & Untill")
                                        .lineLimit(2)
                                        .foregroundColor(Color.secondary)
                                        .font(Font.system(size: 13, weight: .regular, design: .rounded))

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                } icon: {
                                    Image("RequestDetailsIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                }.frame(height: 40)
                            }
                        }
                        Divider().background(Color.secondary).padding(.leading, 50)
                        Section {
                            NavigationLink(destination: EditorView(note: $cstRequest.notes)) {
                                Label {
                                    Text("Notes")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("\(cstRequest.notes)")
                                        .lineLimit(2)
                                        .foregroundColor(Color.secondary)
                                        .font(Font.system(size: 13, weight: .regular, design: .rounded))

                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color.accentColor)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                                        .padding(.leading, 10)
                                } icon: {
                                    Image("RequestNotesIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                }.frame(height: 40)
                            }
                        }
                        Divider().background(Color.secondary).padding(.leading, 50)
                        Section {

                                DisclosureGroup {
                                    Picker("Visits count", selection: $totalChars) {
                                        ForEach(0 ..< 20) {
                                            if   $0 > 0 { Text("\($0)") }
                                        }.frame( height: 60, alignment: .center)
                                    }.pickerStyle(.wheel)
                                } label: {
                                Label {
                                    Text("Valid")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("\(totalChars.description)")
                                        .lineLimit(2)
                                        .foregroundColor(Color.secondary)
                                        .font(Font.system(size: 13, weight: .regular, design: .rounded))

//                                    Image(systemName: "chevron.right")
//                                        .foregroundColor(Color.accentColor)
//                                        .multilineTextAlignment(.leading)
//                                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
//                                        .padding(.leading, 10)
                                } icon: {
                                    Image("RequestScheduleIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25, alignment: .center)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(5)
                                }.frame(height: 40)
                            }
                        }
                    }.padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary
                                .opacity(0.7), lineWidth: 1).padding(1))
                    Spacer()

                }

                VStack {
                    Button {
                        cstRequest.validDate = Date(timeIntervalSinceNow: TimeInterval(totalChars * 604800))
                        let services: [CategoryService] = categories
                        cstRequest.services = services.map({$0.toCstService()})
                        cstRequest.id = (requestsController.requests.last?.id ?? requestsController.requests.count) + 1
                        requestsController.createRequest(request: cstRequest) {
//                            requestsController.$requests.sink(receiveValue: { _ in
                                requestsController.saved = true
                                dismiss()
//                                dismiss()
////                            })
                        }

                    } label: {
                        VStack {
                            Rectangle().foregroundColor(.clear)
                                .ignoresSafeArea(.container, edges: .horizontal)
                                .overlay {
                                    HStack {
                                        Text("Create Open Request")
                                            .withDoneButtonStyles(backColor: .accentColor, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width - 50, height: 50)
                                    }
                                }
                        }
                    }
                }
                .padding(.vertical, 20)
                Spacer(minLength: 100)
            }
        }
//        .onAppear {
//            print("00000000000000000000000000000000000000000000000000\n\n\n")
//
//            print(categories)
//        }
        .onAppear {
            if categories.filter({$0.name == nil}).isEmpty == false {
                var newServices: [CategoryService] = []
                categories.forEach { cat in
                    if cat.name == nil {
                        if var newCat = StaticCategories[cat.id] {
                            if newServices.contains(where: {$0.id == newCat.id}) == false {
                                newCat.unitsCount = cat.unitsCount
                                //                            categories = categories.filter({$0.id != cat.id})
                                newServices.append(newCat)
                            }
                        }
                    }
                    categories.removeAll()
                    categories.append(contentsOf: newServices)
                    categories.uniqued()
            }
            }
        }
        .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                     options: [.allowContentDrag, .tapToDissmiss, .swipeToDismiss,
                               .cornerRadius(15),
                               .noBottomPosition, .appleScrollBehavior,
                               .dragIndicatorColor(Color.lightGray.opacity(0.5)),
                               .showCloseButton(action: { self.bottomSheetPosition = .hidden })],
                     headerContent: {Text("Details").foregroundColor(.black)},
                     mainContent: {
            VStack {
                HStack {
                    Text("Placed")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(getString(from: cstRequest.placedDate, "dd/MM/yy HH:mm"))
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
                HStack {
                    Text("Upload")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(getString(from: cstRequest.placedDate, "dd/MM/yy HH:mm"))
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
                HStack {
                    Text("Until")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(getString(from: cstRequest.validDate, "dd/MM/yy HH:mm"))
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
//                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
                HStack {
                    Text("Looked")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(cstRequest.visits.description)
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
            }.padding(20)
        })
        .padding(.horizontal, 20).padding(.top, 10)
        .navigationTitle("Request")
        .navigationBarTitleDisplayMode(.inline)
        .navigationViewStyle(.stack)
    }
}
struct EditorView: View {
    enum FocusField: Hashable {
        case field
    }
    @FocusState private var focusedField: FocusField?
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Binding var note: String
//    @StateObject var requestVM = RequestViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
                TextEditor(text: $note)
                    .focused($focusedField, equals: .field)
//                    .onChange(of: input, perform: { newValue in
//                        $requestVM.notes.wrappedValue = newValue
//                    })
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding()// Text color
                    .background(Color.white.opacity(0.2)) // TextEditor's Background Color

            }
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button(role: ButtonRole.destructive) {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Save")
                                    .foregroundColor(.Orange)
                                    .font(Font.system(size: 20, weight: .regular, design: .rounded))
                            }

                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.stack)
                .onAppear {

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.focusedField = .field
                    }
                }
        }
    }
}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
