//
//  CstCreateRequestView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/10/22.
//

import SwiftUI
import AnyFormatKitSwiftUI
import BottomSheetSwiftUI
class RequestViewModel: ObservableObject {
    @Published var requests: CstRequests = []
    static let shared = RequestViewModel()
    @Published var notes = ""
    init() {
        let requestsMeta: CstRequestMeta = try! newJSONDecoder().decode(CstRequestMeta.self, from: try! Data(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "requests", ofType: "json")!)))
        self.requests = requestsMeta.requests
        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
        print(self.requests)
        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
        print(requestsMeta)
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
    @State private var totalChars = 0
    @State private var lastText = ""
    @StateObject var RequestVM = RequestViewModel()

    @ObservedObject var CategoryVM: CategoriesViewModel
    //    @State var totalPrice: NSNumber?
    @FocusState var isEditingPrice: Bool
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.locale = .init(identifier: "en_GB")
        return nf
    }()

    var body: some View {//.filter{$0.unitsCount.wrappedValue > 0}.sorted(by: {$0.id < $1.id})
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 10) {
                    VStack {
                        ForEach($CategoryVM.categories.projectedValue[CategoryVM.pickedService].services.filter({s in s.unitsCount.wrappedValue > 0}).sorted(by: {$0.id.wrappedValue < $1.id.wrappedValue}))
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
                                           selection: Binding(get: {
                                    getDate(from: $CategoryVM.OrderTime.from, "dd/MM/yy HH:mm").wrappedValue
                                }, set: { newValue in
                                    $CategoryVM.OrderTime.from.wrappedValue = getString(from: newValue, "dd/MM/yy HH:mm")
                                    let toDate = getDate(from: $CategoryVM.OrderTime.to, "dd/MM/yy HH:mm").wrappedValue
                                    let fotmatter = DateFormatter()
                                    fotmatter.dateFormat = "MMdd"
                                    let fromDay = Int(fotmatter.string(from: newValue))!
                                    let toDay = Int(fotmatter.string(from: toDate))!
                                    if toDay < fromDay {
                                        $CategoryVM.OrderTime.to.wrappedValue = getString(from: newValue, "dd/MM/yy HH:mm")
                                    }
                                }), displayedComponents: [.date, .hourAndMinute])

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
                                    //                                TextField("Total price:", value: CategoryVM.totalPrice,
                                    //                                          formatter: numberFormatter, prompt: Text("£80.00"))

                                    Text("£80.00")

                                        .font(Font.system(size: 17,
                                                          weight: .semibold,
                                                          design: .rounded))
                                        .foregroundColor(Color.black)
                                        .keyboardType(.decimalPad)
                                        .toolbar{
                                            ToolbarItem(placement: .keyboard, content: {
                                                Button(role: ButtonRole.destructive) {

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
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            VStack {
                                Rectangle().foregroundColor(.clear)
                                    .ignoresSafeArea(.container, edges: .horizontal)
                                    .overlay {
                                        HStack {
                                            Text("Add services")
                                                //.withDoneButtonStyles(backColor: .white, accentColor: .accentColor)
                                                .withDoneButtonStyles(backColor: .white, accentColor: .accentColor, isWide: false, width: UIScreen.main.bounds.width - 50, height: 50)
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.vertical, 20)

                    //            Spacer()

                    VStack {
                        //        if actorType != .CUSTOMER {}
                        NavigationLink(destination: AddressPickerView(pickedAddress: $RequestVM.requests[0].address)) {
                            Label {
                                Text("Address")
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                    .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                Spacer()
                                Text($RequestVM.requests[0].address.wrappedValue.total ?? "")
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
                                Picker("Visits count", selection: $RequestVM.requests[0].visits) {
                                    ForEach(1 ..< 20) {
                                        Text("\($0)")
                                    }.frame( height: 60, alignment: .center)
                                }.pickerStyle(.wheel)
                            } label: {
                                Label {
                                    Text("Visits")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text($RequestVM.requests[0].visits.wrappedValue.description)
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
                            NavigationLink(destination: EditorView(note: $RequestVM.requests[0].wrappedValue.notes)) {
                                Label {
                                    Text("Notes")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("")
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
                                    Picker("Visits count", selection: $RequestVM.requests[0].visits) {
                                        ForEach(1 ..< 20) {
                                            Text("\($0)")
                                        }.frame( height: 60, alignment: .center)
                                    }.pickerStyle(.wheel)
                                } label: {
                                Label {
                                    Text("Valid")
                                        .foregroundColor(Color.black)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.system(size: 17, weight: .regular, design: .rounded))
                                    Spacer()
                                    Text("")
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
            }

        }


        .bottomSheet(bottomSheetPosition: $bottomSheetPosition,
                     options: [.allowContentDrag, .tapToDissmiss, .swipeToDismiss,
                               .cornerRadius(15), .shadow(color: .white, radius: 3, x: 3, y: 3),
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
                    Text(getString(from: $RequestVM.requests[0].wrappedValue.placedDate, "dd/MM/yy HH:mm"))
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
                    Text(getString(from: $RequestVM.requests[0].wrappedValue.placedDate, "dd/MM/yy HH:mm"))
                        .multilineTextAlignment(.trailing)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                }
                HStack {
                    Text("Untill")
                        .multilineTextAlignment(.leading)
                        .font(Font.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.secondary)
                    //                        .shadow(color: Color.lightGray, radius: 1, x: 1, y: 1)
                        .lineLimit(1)
                    Spacer()
                    Text(getString(from: $RequestVM.requests[0].wrappedValue.validDate, "dd/MM/yy HH:mm"))
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
                    Text($RequestVM.requests[0].wrappedValue.visits.description)
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
    @State var note: String
    @StateObject var requestVM = RequestViewModel()
    @State var input = ""
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.opacity(0.3).edgesIgnoringSafeArea(.all)
                TextEditor(text: $note)
                    .focused($focusedField, equals: .field)
                    .onChange(of: input, perform: { newValue in
                        $requestVM.notes.wrappedValue = newValue
                    })
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
                                $requestVM.notes.wrappedValue = $input.wrappedValue
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
                    input = $requestVM.notes.wrappedValue
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.focusedField = .field
                    }
                }
        }
    }
}
