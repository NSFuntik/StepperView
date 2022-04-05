//
//  RemovableTagListView.swift
//  Yosomono
//
//  Created by Nozomi Okada on 9/5/20.
//  Copyright © 2020 Nozomi Okada. All rights reserved.
//

import SwiftUI
import Combine



struct RemovableTagListView: UIViewRepresentable {

    @Environment(\.colorScheme) var colorScheme
    @Binding var selected: ServiceType.ID


    @Binding var tags: Set<String>

    var fontSize: CGFloat = 16
    //    @State  var chips: [TagView] = []
    func makeUIView(context: Context) -> TagListView {
        let tagListView = TagListView()
        tagListView.enableRemoveButton = false
        tagListView.addTagViews(Array($tags.wrappedValue.compactMap(tagListView.createNewTagView).sorted(by: {$0.bounds.width < $1.bounds.width})))
        initView(view: tagListView)
        tagListView.delegate = context.coordinator
        tagListView.textFont = .rounded(ofSize: 16, weight: .regular)
        return tagListView
    }

    func updateUIView(_ view: TagListView, context: Context) {
        if !context.coordinator.parent.$tags.wrappedValue.isStrictSubset(of: $tags.wrappedValue) {

            withAnimation(.linear) {
                let seld = view.selectedTags().first
                view.removeAllTags()
                view.addTagViews(Array($tags.wrappedValue.compactMap(view.createNewTagView).sorted(by: {$0.bounds.width < $1.bounds.width}))).map {
                    ($0.currentAttributedTitle == seld?.currentAttributedTitle) ? $0.isSelected = true : $0.updateConfiguration()
                }
                initView(view: view)
            }
            do { view.rearrangeViews() }
        }

    }

    func makeCoordinator() -> RemovableTagListViewCoordinator {
        return RemovableTagListViewCoordinator(parent: self, selected: $selected)
    }

    fileprivate func initView(view: TagListView) {
        view.textFont = .rounded(ofSize: 16, weight: .light)
        view.textColor = .black
        view.removeIconLineColor = .lightGray
        view.tagBackgroundColor = .clear
        view.textFont = .rounded(ofSize: 15, weight: .medium)

        view.borderColor = .lightGray
        view.borderWidth = 1
        view.cornerRadius = 10
        view.paddingX = fontSize / 2 + 2
        view.paddingY = fontSize / 2
        view.marginX = fontSize / 2
        view.marginY = fontSize / 2
    }
}

class RemovableTagListViewCoordinator: TagListViewDelegate {
    @Binding var selected: ServiceType.ID
    var parent: RemovableTagListView

    init(parent: RemovableTagListView, selected: Binding<ServiceType.ID>) {
        self.parent = parent
        self._selected = selected
    }

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.tagViews.forEach {
            $0.isSelected = false
        }

        tagView.isSelected = !tagView.isSelected
        $selected.wrappedValue = ServiceType.init(rawValue: ServiceType.allCases.first(where: {$0.title.hasPrefix(String(tagView.currentAttributedTitle?.string.filter{$0.isLetter} ?? ""))})?.rawValue ?? selected)?.id ?? selected
    }

    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        //        sender.removeTagView(tagView)
        //        parent.tags.remove(title)
    }
}

//struct RemovableTagListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemovableTagListView(selectedButton: .constant(), tags: .constant(["Welcome", "to", "Removable", "TagListView"]))
//    }
//}

extension String {
    var getAttributedFromHTML: NSAttributedString {
        return try! NSAttributedString(
            data: self.data(using: .utf8) ?? Data(),
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
        )
    }
}
