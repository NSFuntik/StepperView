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

    @Published var saved = false

    static let shared = RequestViewModel()

    init() {
        let requestsMeta: CstRequestMeta = try! newJSONDecoder().decode(CstRequestMeta.self, from: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "requests", ofType: "json")!)))
        self.requests = requestsMeta.requests
        print(self.requests)
        print(requestsMeta)
    }

    func createRequest(request: CstRequest, completion: @escaping () -> ()) {
        self.requests.append(request)
        completion()
    }

}
enum RequestBottomSheetPosition: CGFloat, CaseIterable {
    case middle = 0.3
    case hidden = -0.2
}
struct CstCreateRequestView: View {
    @Namespace var bottomID
    @State var bottomSheetPosition: RequestBottomSheetPosition = .hidden
    @State var showInfo = false
    @State var text = ""
    @State private var lastText = ""
    @State var requestsController = RequestViewModel.shared
    @EnvironmentObject var tabController: TabController
    @EnvironmentObject var CategoryVM: CategoriesViewModel
    @State var categories: [CategoryService]
    @State var cstRequest = CstRequest(
        statusRecord: .init(date: getString(from: Date(), "YYYY-MM-DDTHH:MM:SS") + ".312336Z", actor: "CUSTOMER", actorId: 1002, action: "CREATE", status: "LIVE", display: "LIVE"),
        id: 0, offeredSum: 0, placedDate: Date(), orderedDate: Date(),
        validDate: Date(timeInterval: TimeInterval(1), since: Date()),
        visits: 1, address: testProvider.address.defaultAddress, services: [],
        cstActions: [CstCstAction.cancel, .stop, .update], notes: "Enter your note")
    @Environment(\.dismiss) var dismiss
    @State private var totalChars = 1
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.multiplier = 0.01
        nf.numberStyle = .currency
        nf.locale = .init(identifier: "en_GB")
        return nf
    }()

    var body: some View {
        VStack {
            ZStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        VStack(alignment: .center, spacing: 10) {
                            VStack {
                                ForEach($categories.sorted(by: {$0.id.wrappedValue < $1.id.wrappedValue}))
                                { service in
                                    Section {
                                        NavigationLink(destination: CategoryServiceDetailView(service: service)) {
                                            VStack(alignment: .leading) {
                                                HStack {
                                                    Text(service.name.wrappedValue ?? "nil")
                                                        .foregroundColor(Color.black.opacity(0.9))
                                                        .multilineTextAlignment(.leading)
                                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                                        .lineLimit(3)
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
                                        }.padding(.horizontal, 5).frame(minHeight: 40)
                                        Divider().padding(.horizontal, -10).padding(.leading, 50)
                                    }
                                }
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
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
                                        Spacer()
                                        DatePicker("",
                                                   selection: $cstRequest.orderedDate,
                                                   displayedComponents: [.date, .hourAndMinute])
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
                                        Spacer()
                                        VStack(alignment: .trailing) {
                                            TextField("Total price:", value: $cstRequest.offeredSum, formatter: numberFormatter, prompt: Text("£80.00"))
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
                                        .opacity(0.7), lineWidth: 1).padding(1)).id(bottomID)
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
                            VStack {
                                VStack {
                                    NavigationLink(destination: AddressPickerView(pickedAddress: $cstRequest.address)) {
                                        Label {
                                            Text("Address")
                                                .foregroundColor(Color.black)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                            Spacer()
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
                                        }
                                    }.frame(height: 40)
                                    Divider().background(Color.secondary).padding(.leading, 50)
                                }
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
                                    NavigationLink(destination: RequestTrackingView()) {
                                        Label {
                                            Text("Tracking")
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
                                            Image("RequestTrackingIcon")
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
                                        Picker("Valid:", selection: $totalChars) {
                                            ForEach(0 ..< 20) {
                                                if   $0 > 0 { Text("\($0) weeks") }
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

                        }//.animation(Animation.easeInOut(duration: 1.5)).transition(.opacity)
                            .help("SSSSSSS")
                            .task(id: bottomID, {

                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        proxy.scrollTo(bottomID, anchor: .center)
                                    }
                                }
                            })
                    }.padding(.vertical, 20).padding(.horizontal, 20).zIndex(0)
                    VStack {
                        if requestsController.requests.first(where: {$0.id == cstRequest.id}) == nil {
                            Button {
                                cstRequest.validDate = Date(timeIntervalSinceNow: TimeInterval(totalChars * 604800))
                                let services: [CategoryService] = categories
                                cstRequest.services = services.map({$0.toCstService()})
                                cstRequest.id = (requestsController.requests.last?.id ?? requestsController.requests.count) + 1
                                requestsController.createRequest(request: cstRequest) {
                                    requestsController.saved = true
                                    dismiss()
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
                        } else {
                            HStack {
                                Button {
                                    $requestsController.requests.first(where: {$0.id.wrappedValue == cstRequest.id})?.validDate.wrappedValue = Date()
                                    $requestsController.requests.first(where: {$0.id.wrappedValue == cstRequest.id})?.statusRecord.status.wrappedValue = "CANCELED"
                                } label: {
                                    VStack {
                                        Rectangle().foregroundColor(.clear)
                                            .ignoresSafeArea(.container, edges: .horizontal)
                                            .overlay {
                                                HStack {
                                                    Text("Cancel")
                                                        .withDoneButtonStyles(backColor: .red, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 4 + 10, height: 50)
                                                }
                                            }
                                    }
                                }
                                Button {
                                    $requestsController.requests.first(where: {$0.id.wrappedValue == cstRequest.id})?.validDate.wrappedValue = Date()
                                    $requestsController.requests.first(where: {$0.id.wrappedValue == cstRequest.id})?.statusRecord.status.wrappedValue = "STOPPED"
                                } label: {
                                    VStack {
                                        Rectangle().foregroundColor(.clear)
                                            .ignoresSafeArea(.container, edges: .horizontal)
                                            .overlay {
                                                HStack {
                                                    Text("Stop")
                                                        .withDoneButtonStyles(backColor: .lightGray, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 4 + 10, height: 50)
                                                }
                                            }
                                    }
                                }
                                Button {
                                    $requestsController.requests.first(where: {$0.id.wrappedValue == cstRequest.id})?.wrappedValue = cstRequest

//                                    $requestsController.requests.wrappedValue.append(cstRequest)
                                    dismiss()
//                                    .first(where: {$0.id.wrappedValue == cstRequest.id})?.statusRecord.status.wrappedValue = "STOPPED"
                                } label: {
                                    VStack {
                                        Rectangle().foregroundColor(.clear)
                                            .ignoresSafeArea(.container, edges: .horizontal)
                                            .overlay {
                                                HStack {
                                                    Text("Update")
                                                        .withDoneButtonStyles(backColor: .green, accentColor: .white, isWide: false, width: UIScreen.main.bounds.width / 4 + 10, height: 50)
                                                }
                                            }
                                    }
                                }
                            } .padding(.horizontal, 10).zIndex(1)
                        }
                    }.zIndex(1)

                    Spacer(minLength: 100)
                }.bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                              options: [.allowContentDrag, .swipeToDismiss, .tapToDissmiss,
                                        .backgroundBlur(effect: .systemThinMaterialLight), .cornerRadius(25),
                                        .shadow(color: .lightGray, radius: 1, x:1,  y: 1), .noBottomPosition, .showCloseButton(action: {
                                            bottomSheetPosition = .hidden
                                        })],
                              headerContent: {
                    VStack {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("DETAILS")
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .font(Font.system(size: 16, weight: .medium, design: .rounded))
                            Spacer()
                        }
                    }.frame(height: 20)
                },
                              mainContent: {
                    if bottomSheetPosition == .middle {

                        Section {
                            VStack(spacing: 7.5) {
                                HStack {
                                    Text("Placed")
                                    Spacer()
                                    Text(getString(from: cstRequest.placedDate, "dd/MM/yy HH:mm"))
                                }
                                HStack {
                                    Text("Upload")
                                    Spacer()
                                    Text(getString(from: cstRequest.placedDate, "dd/MM/yy HH:mm"))
                                }
                                HStack {
                                    Text("Until")
                                    Spacer()
                                    Text(getString(from: cstRequest.validDate, "dd/MM/yy HH:mm"))
                                }
                                HStack {
                                    Text("Looked")
                                    Spacer()
                                    Text(cstRequest.visits.description)
                                }
                            }
                            .font(Font.system(size: 20, weight: .regular, design: .rounded))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .padding(.vertical, 10)
                            .frame(maxHeight: UIScreen.main.bounds.height / 4, alignment: .top)
                        }.padding(.horizontal, 20)
                    }
                }).minimumScaleFactor(0.8)
            }
        }
       .padding(.top, 10)
        .onAppear {
            if categories.filter({$0.name == nil}).isEmpty == false {
                var newServices: [CategoryService] = []
                categories.forEach { cat in
                    if cat.name == nil {
                        if var newCat = StaticCategories[cat.id] {
                            if newServices.contains(where: {$0.id == newCat.id}) == false {
                                newCat.unitsCount = cat.unitsCount
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
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
                TextEditor(text: $note)
                    .focused($focusedField, equals: .field)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding()
                    .background(Color.white.opacity(0.2))
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
