//
//  ProfileTermsConditionsView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/7/22.
//

import SwiftUI

struct ProfileTermsConditionsView: View {
    @State var selectedTab: Tab.ID = Tab.QlogaTsCs.id
    enum Tab: Int, CaseIterable, Identifiable {
        case QlogaTsCs
        case PoviderTsCs
        case CustomerTsCs

        var id: Int { self.rawValue }
        var description: String {
            switch self {
                case .QlogaTsCs:
                    return "QLOGA\nTerms & Conditions"
                case .PoviderTsCs:
                    return "Povider's\nTerms & Conditions"
                case .CustomerTsCs:
                    return "Customer's\nTerms & Conditions"
            }
        }

        var link: String {
            switch self {
                case .QlogaTsCs:
                    return "https://pub.qloga.com/legal/qloga_ts_and_cs.html"
                case .PoviderTsCs:
                    return "https://pub.qloga.com/legal/p4p/prv_ind_ts_and_cs.html"
                case .CustomerTsCs:
                    return "https://pub.qloga.com/legal/p4p/cst_ts_and_cs.html"
            }
        }

    }
    @Binding var actorType: ActorsEnum
    @Binding var customer: Customer
    @Binding var provider: Provider
    @State var tabs: [String] = [Tab.QlogaTsCs.description]
    @State var richView: RichText = RichText(html: "")
    var body: some View {
        VStack {
            TabBarView(tabs: $tabs,
                       selection: $selectedTab,
                       underlineColor: .accentColor) { title, isSelected in

                    Text(title)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .ignoresSafeArea(.all, edges: .horizontal)
                        .foregroundColor(isSelected ? .black : .lightGray)
                        .frame(width: UIScreen.main.bounds.width / 2 - 30, alignment: .center)
                }
            HStack {
                ScrollView {
                    ScrollViewReader { proxy in
                        if Tab(rawValue: $selectedTab.wrappedValue) == Tab.QlogaTsCs {
                            RichText(html: try! String(contentsOf: URL(string: Tab.init(rawValue: $selectedTab.wrappedValue)!.link)!, encoding: .utf8)).id(0)
                                .onAppear {
                                    proxy.scrollTo(0, anchor: .top)
                                }
                                .padding(.horizontal, -5)
                                .placeholder(when: false) {
                                    Text("loading")
                                }
                        } else {  richView.id(1)  .padding(.horizontal, -5) .placeholder(when: false) {
                            Text("loading")
                        }   .onAppear {
                            proxy.scrollTo(1, anchor: .top)
                        }    }
                        Spacer()

                }
                }.overlay {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1.0).foregroundColor(.lightGray)
                }.padding(1).clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }.padding(.vertical, 10)
        }.padding(.horizontal, 20)
            .navigationTitle("Terms & Conditions")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
//                actorType != .CUSTOMER ? tabs.append(Tab.PoviderTsCs.description) : tabs.append(Tab.CustomerTsCs.description)
                switch actorType {
                    case .CUSTOMER:
                        tabs.append(Tab.CustomerTsCs.description)
                        richView = RichText(html: try! String(contentsOf: URL(string: Tab.CustomerTsCs.link)!, encoding: .utf8))
                    case .QLOGA, .PROVIDER, .RESOURCE, .JOB_APPLICANT:
                        tabs.append(Tab.PoviderTsCs.description)
                        richView = RichText(html: try! String(contentsOf: URL(string: Tab.PoviderTsCs.link)!, encoding: .utf8))

                }
            }

    }
}

struct ProfileTermsConditionsView_Previews: PreviewProvider {
    static var previews: some View {
            NavigationView {
                ProfileTermsConditionsView(actorType: Binding(projectedValue: .constant(.CUSTOMER)), customer: Binding(projectedValue: .constant(testCustomer)), provider: Binding(projectedValue: .constant(testProvider)))
            }.previewDevice("iPhone X")

    }
}
