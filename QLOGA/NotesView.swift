//
//  NotesView.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 4/21/22.
//

import SwiftUI

struct NotesView: View {
    @State var selectedTab: Tab.ID = Tab.ProviderNotes.id
    @Binding var actorType: ActorsEnum
    @State var tabs: [String] = []
    enum Tab: Int, CaseIterable, Identifiable {
        case ProviderNotes
        case CustomerNotes
        var id: Int { self.rawValue }
        var description: String {
            switch self {
                case .ProviderNotes:
                    return "Povider's"
                case .CustomerNotes:
                    return "Customer's"
            }
        }
    }
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
            if Tab(rawValue: selectedTab) == .ProviderNotes {
                Text("Internal and external drains and sewers repairs including blockage removals, pipe replacements, etc.")
            } else {
                Text("Internal and external drains and sewers repairs including blockage removals, pipe replacements, etc.\nInternal and external drains and sewers repairs including blockage removals, pipe replacements, etc.")
            }
            Spacer()

        }.padding(.horizontal, 20).padding(.top, 10)
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                //                actorType != .CUSTOMER ? tabs.append(Tab.PoviderTsCs.description) : tabs.append(Tab.CustomerTsCs.description)
                switch actorType {
                    case .CUSTOMER:
                        tabs.append(Tab.ProviderNotes.description)
                        tabs.append("Your's")

                    case .QLOGA, .PROVIDER, .RESOURCE, .JOB_APPLICANT:
                        tabs.append(Tab.CustomerNotes.description)
                        tabs.append("Your's")

                }
            }

    }
}
