//
//  SelectableTagListView.swift
//  Yosomono
//
//  Created by Nozomi Okada on 9/2/20.
//  Copyright © 2020 Nozomi Okada. All rights reserved.
//

import SwiftUI


struct SelectableTagListView: UIViewRepresentable {

    @Binding var selectedTags: Set<String>

    var tags: [String]
    var searchTerm = ""
    var fontSize: CGFloat = 14

    func makeUIView(context: Context) -> TagListView {
        let tagListView = TagListView()
        initView(view: tagListView)
        tagListView.delegate = context.coordinator
        return tagListView
    }

    func updateUIView(_ view: TagListView, context: Context) {
        view.removeAllTags()
        if searchTerm.isEmpty {
            return
        }
        let lowercasedSearchTerm = searchTerm.lowercased()
        tags.forEach { tag in
            if tag.lowercased().contains(lowercasedSearchTerm) {
                let tagView = view.addTag(tag)
                if selectedTags.contains(tag) {
                    tagView.isSelected = true
                }
            }
        }
    }

    func makeCoordinator() -> SelectableTagListViewCoordinator {
        return SelectableTagListViewCoordinator(parent: self)
    }

    fileprivate func initView(view: TagListView) {
        view.textFont =  .rounded(ofSize: fontSize, weight: .light)
        view.textColor = UIColor(.blue)
        view.selectedTextColor = .white
        view.tagBackgroundColor = .clear
        view.tagSelectedBackgroundColor = UIColor(.blue)
        view.cornerRadius = fontSize
        view.borderWidth = 1
        view.borderColor = .blue
        view.paddingX = fontSize / 2
        view.paddingY = fontSize / 2
        view.marginX = fontSize / 2
        view.marginY = fontSize / 2
    }
}

class SelectableTagListViewCoordinator: TagListViewDelegate {

    var parent: SelectableTagListView

    init(parent: SelectableTagListView) {
        self.parent = parent
    }

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagView.isSelected = !tagView.isSelected

        if tagView.isSelected {
            parent.selectedTags.insert(title)
        } else {
            parent.selectedTags.remove(title)
        }
    }
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.removeTagView(tagView)
        parent.tags.filter{$0 != title}
        print(title)
    }
}

struct SelectTagListView_Previews: PreviewProvider {
    static var previews: some View {
        SelectableTagListView(selectedTags: .constant(["Selectable"]), tags: ["Welcome", "to", "Selectable", "TagListView"])
    }
}
