//
//  TabBar.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/16/22.
//

import SwiftUI
struct TabBarView<Label: View>: View {
    @Binding var tabs: [String] // The tab titles
    @Binding var selection: Int // Currently selected tab
    let underlineColor: Color // Color of the underline of the selected tab
    // Tab label rendering closure - provides the current title and if it's the currently selected tab
    let label: (String, Bool) -> Label

    var body: some View {
        // Pack the tabs horizontally and allow them to be scrolled
//        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 15) {
                ForEach(tabs, id: \.self) {
                    self.tab(title: $0)
                }
//            }.padding(.horizontal, 3) // Tuck the out-most elements in a bit
        }
    }
    private func tab(title: String) -> some View {
        let index = self.tabs.firstIndex(of: title)!
        let isSelected = index == selection
        return Button(action: {
            // Allows for animated transitions of the underline,
            // as well as other views on the same screen
            withAnimation {
                self.selection = index
            }
        }) {
            label(title, isSelected)
                .padding(5)
                .padding(.vertical, 5)
                .overlay(RoundedRectangle(cornerRadius: 10) // The line under the tab
                    .frame(height: 3, alignment: .bottom)
                         // The underline is visible only for the currently selected tab
                    .foregroundColor(isSelected ? underlineColor : .clear)
                    .padding(.top, 5)
                         
                         // Animates the tab selection
                    .transition(.move(edge: .bottom)) ,alignment: .bottomLeading)
                .padding(.bottom, -10)
        }
    }

}
struct TabBarView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            TabBarView(tabs: .constant(["Orders", "Quotes", "Inquires", "Requests"]),
                       selection: .constant(0),
                       underlineColor: .accentColor) { title, isSelected in
                Text(title)
                    .font(.system(size: 19, weight: .regular, design: .rounded))
                    .foregroundColor(isSelected ? .black : .lightGray)
            }

        }
    }
}
