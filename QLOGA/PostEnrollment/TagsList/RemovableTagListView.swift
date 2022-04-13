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

//    @Environment(\.colorScheme) var colorScheme
    @Binding var selected: CategoryType.ID
    @Binding var isRemovable: Bool
    @ObservedObject var categoriesVM: CategoriesViewModel
    @Binding var tags: Set<String>

    var fontSize: CGFloat = 14
    //    @State  var chips: [TagView] = []
    func makeUIView(context: Context) -> TagListView {
        let tagListView = TagListView()
//        tagListView.enableRemoveButton = false
        tagListView.addTagViews(Array($tags.wrappedValue.compactMap(tagListView.createNewTagView).sorted(by: {$0.bounds.width < $1.bounds.width})))
        initView(view: tagListView)
        tagListView.delegate = context.coordinator
        tagListView.textFont = .rounded(ofSize: 14, weight: .medium)

        tagListView.enableRemoveButton = $isRemovable.wrappedValue

        return tagListView
    }

    func updateUIView(_ view: TagListView, context: Context) {
        if !context.coordinator.parent.$tags.wrappedValue.isStrictSubset(of: $tags.wrappedValue) {

            withAnimation(.linear) {
                let seld = view.selectedTags().first
                view.removeAllTags()
                view.addTagViews(Array($tags.wrappedValue.compactMap(view.createNewTagView).sorted(by: {$0.bounds.width < $1.bounds.width})))
                    .map {
//                    ($0.currentAttributedTitle == seld?.currentAttributedTitle) ? $0.isSelected = true : $0.updateConfiguration()
                        ($0.currentTitle == seld?.currentTitle) ? $0.isSelected = true : $0.updateConfiguration()
                }
                initView(view: view)
            }
            do { view.rearrangeViews() }
        }

    }

    func makeCoordinator() -> RemovableTagListViewCoordinator {
        return RemovableTagListViewCoordinator(parent: self, selected: $selected, categories: _categoriesVM)
    }

    fileprivate func initView(view: TagListView) {
//        view.textFont = .rounded(ofSize: 14, weight: .light)
        view.textColor = .black
        view.removeIconLineColor = UIColor(named: "Orange")!
        view.removeButtonIconSize = 9
        view.tagBackgroundColor = .clear
        view.textFont = .rounded(ofSize: 14, weight: .medium)
        
        view.borderColor = .lightGray
        view.borderWidth = 1
        view.cornerRadius = 12
        view.paddingX = fontSize / 2 + 2
        view.paddingY = fontSize / 2
        view.marginX = fontSize / 2
        view.marginY = fontSize / 2
        view.paddingY = fontSize / 2
        
//        view.rearrangeViews()
//        view.layer.setNeedsDisplay(CGRect(x: 0, y: 0, width: Int(view.frame.width), height:  view.rows * 20))
    }
}

class RemovableTagListViewCoordinator: TagListViewDelegate {
    @Binding var selected: CategoryType.ID
    var parent: RemovableTagListView
    @ObservedObject var categoriesVM: CategoriesViewModel

    init(parent: RemovableTagListView, selected: Binding<CategoryType.ID>, categories: ObservedObject<CategoriesViewModel>) {
        self.parent = parent
        self._selected = selected
        self.categoriesVM = categories.wrappedValue
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

//struct RemovableTagListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RemovableTagListView(selectedButton: .constant(), tags: .constant(["Welcome", "to", "Removable", "TagListView"]))
//    }
//}

//extension String {
//    var getAttributedFromHTML: NSAttributedString {
//        return try! NSAttributedString(
//            data: self.data(using: .utf8) ?? Data(),
//            options: [.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil
//        )
//    }
//}
