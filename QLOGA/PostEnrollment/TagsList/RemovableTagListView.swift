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
    @Binding var selected: CategoryType.ID
    @Binding var isRemovable: Bool
    @ObservedObject var categoriesVM: CategoriesViewModel
    @Binding var tags: Set<String>
    @State var fontSize: CGFloat = 14

    func makeUIView(context: Context) -> TagListView {
        let tagListView = TagListView()
        tagListView.addTagViews(Array($tags.wrappedValue.compactMap(tagListView.createNewTagView).sorted(by: {$0.frame.width < $1.frame.width})))
        tagListView.textFont = .rounded(ofSize: fontSize, weight: fontSize < 10 ? .light : .medium)
        initView(view: tagListView)
        tagListView.delegate = context.coordinator
        tagListView.enableRemoveButton = $isRemovable.wrappedValue

        return tagListView
    }

    func updateUIView(_ view: TagListView, context: Context) {
        if context.coordinator.parent.tags != self.tags {
            if !context.coordinator.parent.$tags.wrappedValue.isStrictSubset(of: $tags.wrappedValue) {

                withAnimation(.linear) {
                    let seld = view.selectedTags().first
                    view.removeAllTags()
                    view.addTagViews(Array($tags.wrappedValue.compactMap(view.createNewTagView).sorted(by: {$0.bounds.width < $1.bounds.width})))
                        .map {
                            ($0.currentTitle == seld?.currentTitle) ? $0.isSelected = true : $0.updateConfiguration()
                        }
                    initView(view: view)
                }
                do { view.rearrangeViews() }
            }
        }
    }

    func makeCoordinator() -> RemovableTagListViewCoordinator {
        return RemovableTagListViewCoordinator(parent: self, selected: $selected, categories: _categoriesVM, fontSize: fontSize)
    }

    fileprivate func initView(view: TagListView) {
        view.textColor = .black
        view.removeIconLineColor = UIColor(named: "Orange")!
        view.removeButtonIconSize = 9
        view.tagBackgroundColor = .clear
        view.textFont = .rounded(ofSize: fontSize, weight: fontSize < 10 ? .light : .medium)
        view.borderColor = .lightGray
        view.borderWidth = 1
        view.cornerRadius = 13
        view.paddingX = fontSize / 2 + 2
        view.paddingY = fontSize / 2
        view.marginX = fontSize / 2
        view.marginY = fontSize / 2
    }
}

class RemovableTagListViewCoordinator: TagListViewDelegate {
    @Binding var selected: CategoryType.ID
    var parent: RemovableTagListView
    @ObservedObject var categoriesVM: CategoriesViewModel
    @State var fontSize: CGFloat

    init(parent: RemovableTagListView, selected: Binding<CategoryType.ID>, categories: ObservedObject<CategoriesViewModel>, fontSize: CGFloat) {
        self.parent = parent
        self._selected = selected
        self.categoriesVM = categories.wrappedValue
        self.fontSize = fontSize
    }

    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.tagViews.forEach {
            $0.isSelected = false
        }

        tagView.isSelected = !tagView.isSelected
        $selected.wrappedValue = CategoryType.init(rawValue: CategoryType.allCases.first(where: {$0.title.hasPrefix(String(tagView.currentTitle?.filter{$0.isLetter} ?? ""))})?.rawValue ?? selected)?.id ?? selected
    }

    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
                sender.removeTagView(tagView)
                parent.tags.remove(title)
        let suffix = title.filter({$0.isLetter})
       guard CategoryType.allCases.filter({$0.title == suffix}).isEmpty == false,
             let serviceId = CategoryType.allCases.filter({$0.title == suffix}).first?.id else { return }
        $categoriesVM.categories.wrappedValue[serviceId].services = (categoriesVM.categories.filter({title.contains($0.name!)}).first?.services.filter({$0.unitsCount < 0}))!

        $categoriesVM.categories.wrappedValue[serviceId].services.insert(contentsOf: categoriesVM.defaultCategories[serviceId].services, at: 0)
        print(title)
    }
}
