//
//  TagListView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit
import SwiftUI
import AVFoundation

@objc public protocol TagListViewDelegate {
    @objc optional func tagPressed(_ title: String, tagView: TagView, sender: TagListView) -> Void
    @objc optional func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) -> Void
}

extension StringProtocol {
    var getServiceID: CategoryType {
        return (CategoryType(rawValue: CategoryType.allCases
            .first(where: { $0.title.hasPrefix(String(self.filter({$0.isLetter}).prefix($0.title.count - 1)))})!.id)) ?? CategoryType.Cleaning
    }
}


@IBDesignable
open class TagListView: UIView {
    
    @IBInspectable open dynamic var textColor: UIColor = .black {
        didSet {
            tagViews.forEach {
                $0.textColor = textColor
            }
        }
    }
    
    @IBInspectable open dynamic var selectedTextColor: UIColor = .black {
        didSet {
            tagViews.forEach {
                $0.selectedTextColor = selectedTextColor
            }
        }
    }

    @IBInspectable open dynamic var tagLineBreakMode: NSLineBreakMode = .byTruncatingTail {
        didSet {
            tagViews.forEach {
                $0.titleLineBreakMode = tagLineBreakMode
            }
        }
    }
    
    @IBInspectable open dynamic var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            tagViews.forEach {
                $0.tagBackgroundColor = tagBackgroundColor
            }
        }
    }
    
    @IBInspectable open dynamic var tagHighlightedBackgroundColor: UIColor? {
        didSet {
            tagViews.forEach {
                $0.highlightedBackgroundColor = tagHighlightedBackgroundColor
            }
        }
    }
    
    @IBInspectable open dynamic var tagSelectedBackgroundColor: UIColor? {
        didSet {
            tagViews.forEach {
                $0.selectedBackgroundColor = tagSelectedBackgroundColor
            }
        }
    }
    
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0 {
        didSet {
            tagViews.forEach {
                $0.cornerRadius = cornerRadius
            }
        }
    }
    @IBInspectable open dynamic var borderWidth: CGFloat = 0 {
        didSet {
            tagViews.forEach {
                $0.borderWidth = borderWidth
            }
        }
    }
    
    @IBInspectable open dynamic var borderColor: UIColor? {
        didSet {
            tagViews.forEach {
                $0.borderColor = borderColor
            }
        }
    }
    
    @IBInspectable open dynamic var selectedBorderColor: UIColor  = UIColor(named: "AccentColor") ?? .green {
        didSet {
            tagViews.forEach {
                $0.selectedBorderColor = selectedBorderColor
            }
        }
    }
    
    @IBInspectable open dynamic var paddingY: CGFloat = 5 {
        didSet {
            defer { rearrangeViews() }
            tagViews.forEach {
                $0.paddingY = paddingY
            }
        }
    }
    @IBInspectable open dynamic var paddingX: CGFloat = 0 {
        didSet {
            defer { rearrangeViews() }
            tagViews.forEach {
                $0.paddingX = paddingX
            }
        }
    }
    @IBInspectable open dynamic var marginY: CGFloat = 2 {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var marginX: CGFloat = 0 {
        didSet {
            rearrangeViews()
        }
    }
    
    @objc public enum Alignment: Int {
        case left
        case center
        case right
        case leading
        case trailing
    }
    @IBInspectable open var alignment: Alignment = .leading {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var shadowColor: UIColor = .white {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var shadowRadius: CGFloat = 0 {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var shadowOffset: CGSize = .zero {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var shadowOpacity: Float = 0 {
        didSet {
            rearrangeViews()
        }
    }
    
    @IBInspectable open dynamic var enableRemoveButton: Bool = false {
        didSet {
            defer { rearrangeViews() }
            tagViews.forEach {
                $0.enableRemoveButton = enableRemoveButton
            }
        }
    }
    
    @IBInspectable open dynamic var removeButtonIconSize: CGFloat = 12 {
        didSet {
            defer { rearrangeViews() }
            tagViews.forEach {
                $0.removeButtonIconSize = removeButtonIconSize
            }
        }
    }
    @IBInspectable open dynamic var removeIconLineWidth: CGFloat = 1 {
        didSet {
            defer { rearrangeViews() }
            tagViews.forEach {
                $0.removeIconLineWidth = removeIconLineWidth
            }
        }
    }
    
    @IBInspectable open dynamic var removeIconLineColor: UIColor = UIColor.white.withAlphaComponent(0.54) {
        didSet {
            defer { rearrangeViews() }
            tagViews.forEach {
                $0.removeIconLineColor = removeIconLineColor
            }
        }
    }
    
    @objc open dynamic var textFont: UIFont = .rounded(ofSize: 14, weight: .medium)  {
        didSet {
            defer { rearrangeViews() }
            tagViews.forEach {
                $0.textFont = textFont
            }
        }
    }
    
    @IBOutlet open weak var delegate: TagListViewDelegate?
//    private(set) var selectedView: TagView = TagView()
    open private(set) var tagViews: [TagView] = []
    private(set) var tagBackgroundViews: [UIView] = []
    private(set) var rowViews: [UIView] = []
    private(set) var tagViewHeight: CGFloat = 20
    private(set) var rows = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    // MARK: - Interface Builder
    
    open override func prepareForInterfaceBuilder() {
//        addTag("Welcome")
//        addTag("to")
//        addTag("TagListView").isSelected = true
    }
    
    // MARK: - Layout
    
    open override func layoutSubviews() {
        defer { rearrangeViews() }
        super.layoutSubviews()
    }
    
     func rearrangeViews() {
//        tagViews.reserveCapacity(ServiceType.allCases.count)
        let views = tagViews as [UIView] + tagBackgroundViews + rowViews
        views.forEach {
            $0.removeFromSuperview()
        }
        rowViews.removeAll(keepingCapacity: true)

        var isRtl: Bool = false
        
        if #available(iOS 10.0, tvOS 10.0, *) {
            isRtl = effectiveUserInterfaceLayoutDirection == .rightToLeft
        
        }
        else if let shared = UIApplication.value(forKey: "sharedApplication") as? UIApplication {
            isRtl = shared.userInterfaceLayoutDirection == .leftToRight
        }
        
        var alignment = self.alignment
        
        if alignment == .leading {
            alignment = isRtl ? .right : .left
        }
        else if alignment == .trailing {
            alignment = isRtl ? .left : .right
        }
        
        var currentRow = 0
        var currentRowView: UIView!
        var currentRowTagCount = 0
        var currentRowWidth: CGFloat = 0
        let frameWidth = frame.width
        
        let directionTransform = isRtl
            ? CGAffineTransform(scaleX: -1.0, y: 1.0)
            : CGAffineTransform.identity
        
        for (index, tagView) in tagViews.enumerated() {
            tagView.frame.size = tagView.intrinsicContentSize
            tagView.textFont = .rounded(ofSize: 14, weight: .medium)
            tagViewHeight = tagView.frame.height
            
            if currentRowTagCount == 0 || currentRowWidth + tagView.frame.width > frameWidth {
                currentRow += 1
                currentRowWidth = 0
                currentRowTagCount = 0
                currentRowView = UIView()
                currentRowView.transform = directionTransform
                currentRowView.frame.origin.y = CGFloat(currentRow - 1) * (tagViewHeight + marginY)
                
                rowViews.append(currentRowView)
                addSubview(currentRowView)

                tagView.frame.size.width = min(tagView.frame.size.width, frameWidth)
            }
            
            let tagBackgroundView = tagBackgroundViews[index]
            tagBackgroundView.transform = directionTransform
            tagBackgroundView.frame.origin = CGPoint(
                x: currentRowWidth,
                y: 0)
            tagBackgroundView.frame.size = tagView.bounds.size
            tagBackgroundView.layer.shadowColor = shadowColor.cgColor
            tagBackgroundView.layer.shadowPath = UIBezierPath(roundedRect: tagBackgroundView.bounds, cornerRadius: cornerRadius).cgPath
            tagBackgroundView.layer.shadowOffset = shadowOffset
            tagBackgroundView.layer.shadowOpacity = shadowOpacity
            tagBackgroundView.layer.shadowRadius = shadowRadius
            tagBackgroundView.addSubview(tagView)
            currentRowView.addSubview(tagBackgroundView)
            
            currentRowTagCount += 1
            currentRowWidth += tagView.frame.width + marginX
            
            switch alignment {
            case .leading: fallthrough // switch must be exahutive
            case .left:
                currentRowView.frame.origin.x = 0
            case .center:
                currentRowView.frame.origin.x = (frameWidth - (currentRowWidth - marginX)) / 2
            case .trailing: fallthrough // switch must be exahutive
            case .right:
                currentRowView.frame.origin.x = frameWidth - (currentRowWidth - marginX)
            }
            currentRowView.frame.size.width = currentRowWidth
            currentRowView.frame.size.height = max(tagViewHeight, currentRowView.frame.height)
        }
        rows = currentRow
        
        invalidateIntrinsicContentSize()
    }
    
    // MARK: - Manage tags
    
    override open var intrinsicContentSize: CGSize {
        var height = CGFloat(rows) * (tagViewHeight) //+ marginY)
        if rows > 0 {
            height -= marginY
        } 
        return CGSize(width: frame.width, height: height)
    }
    
     func createNewTagView(_ title: String) -> TagView {
        let tagView = TagView(title: title)
//        tagView.isSelected = isSelected

        tagView.textColor = textColor
        tagView.selectedTextColor = selectedTextColor
        tagView.tagBackgroundColor = tagBackgroundColor
        tagView.highlightedBackgroundColor = tagHighlightedBackgroundColor
        tagView.selectedBackgroundColor = tagSelectedBackgroundColor
        tagView.titleLineBreakMode = tagLineBreakMode
        tagView.cornerRadius = cornerRadius
        tagView.borderWidth = borderWidth
        tagView.borderColor = borderColor
        tagView.selectedBorderColor = selectedBorderColor
        tagView.paddingX = 0
        tagView.paddingY = paddingY
        tagView.textFont = .rounded(ofSize: 14, weight: .medium)
        tagView.semanticContentAttribute = .forceLeftToRight
        tagView.removeIconLineWidth = removeIconLineWidth
        tagView.removeButtonIconSize = removeButtonIconSize
        tagView.enableRemoveButton = enableRemoveButton
        tagView.removeIconLineColor = removeIconLineColor
         tagView.paddingY = 0
        tagView.addTarget(self, action: #selector(tagPressed(_:)), for: .touchUpInside)
        tagView.removeButton.addTarget(self, action: #selector(removeButtonPressed(_:)), for: .touchUpInside)

        // On long press, deselect all tags except this one
        tagView.onLongPress = { [unowned self] this in
            self.tagViews.forEach {
                $0.isSelected = $0 == this
            }
        }
         
        return tagView
    }

    @discardableResult
    open func addTag(_ title: String) -> TagView {
        defer { rearrangeViews() }
        return addTagView(createNewTagView(title))
    }
    
    @discardableResult
    open func addTags(_ titles: [String]) -> [TagView] {
        return addTagViews(titles.map(createNewTagView))
    }
    
    @discardableResult
    open func addTagView(_ tagView: TagView) -> TagView {
        defer { rearrangeViews() }
        
        tagViews.append(tagView)
        tagBackgroundViews.append(UIView(frame: tagView.bounds))
        
        return tagView
    }
    
    @discardableResult
    open func addTagViews(_ tagViewList: [TagView]) -> [TagView] {
        defer { rearrangeViews() }
        tagViewList.forEach {
            guard $0.currentTitle?.suffix(2) != " 0" else { return }
            tagViews.append($0)
            tagBackgroundViews.append(UIView(frame: $0.bounds))
        }
        return tagViews
    }

    @discardableResult
    open func insertTag(_ title: String, at index: Int) -> TagView {
        return insertTagView(createNewTagView(title), at: index)
    }
    

    @discardableResult
    open func insertTagView(_ tagView: TagView, at index: Int) -> TagView {
        defer { rearrangeViews() }
        tagViews.insert(tagView, at: index)
        tagBackgroundViews.insert(UIView(frame: tagView.bounds), at: index)

        return tagView
    }

    @discardableResult
    open func insertTags(_ titles: Set<String>,_ tagViewList: [TagView] = []) -> [TagView] {
        let tagViewList = tagViewList.count > 0 ? tagViewList : Array(titles).map(createNewTagView)
        var tagViewL: [TagView] = tagViews

        tagViewList.forEach { tagl in
            tagViews.forEach { t in
//                if ((t.currentAttributedTitle?.string.hasPrefix((tagl.currentAttributedTitle?.string.filter({$0.isLetter}))!))!) {
                if ((t.currentTitle?.hasPrefix((tagl.currentTitle?.filter({$0.isLetter}))!))!) {

                    tagViewL.append( insertTagView(tagl, at: tagViews.firstIndex(of: t)!))
//                    defer { rearrangeViews() }
//                    tagViews.insert(tagl, at: tagViews.firstIndex(of: t)!)
//                    tagBackgroundViews.insert(UIView(frame: tagl.bounds), at: tagViews.firstIndex(of: t)!)
                } else {
                    tagViewL.append( addTagView(tagl))
//                    defer { rearrangeViews() }
//                    tagViews.append(tagl)
//                    tagBackgroundViews.append(UIView(frame: tagl.bounds))
                }
            }

        }
        return tagViews.applying(tagViewL.difference(from: tagViews))!
    }
//    var titleStrings: [String] = []
//    titles.forEach { title in
//        tagViews.forEach { tagV in
//            if tagV.currentAttributedTitle?.string.hasPrefix(title.filter({$0.isLetter})) == true {
//                if tagV.currentAttributedTitle?.string.hasSuffix(title.filter({$0.isNumber})) == false {
//                    self.setAttributedTitle(title, at: self.tagViews.firstIndex(of: tagV)!)
//                }
//            } else {
//                insertTag(title, at: tagViews.capacity > (title.getServiceID.id) ? (title.getServiceID.id) : tagViews.endIndex)
//                tagViews.sorted(by: {($0.currentAttributedTitle?.string.getServiceID.id)! < ($1.currentAttributedTitle?.string.getServiceID.id)!})
//            }
//        }
//    }
//    return tagViews.filter({(tagViews.capacity < ($0.currentAttributedTitle?.string.getServiceID.id)!)})
//    tagBackgroundViews.append(UIView(frame: tagView.bounds))
    
    open func setTitle(_ title: String, at index: Int) {
        tagViews[index].titleLabel?.text = title
    }
//    open func setAttributedTitle(_ title: String, at index: Int) {
//        tagViews[index].setAttributedTitle(
//            try? NSAttributedString(
//                data: title.data(using: .utf8) ?? Data(),
//                options: [.documentType: NSAttributedString.DocumentType.html],
//                documentAttributes: nil
//            ), for: UIControl.State())
//    }
    open func removeTag(_ title: String) {
        tagViews.reversed().filter({ $0.currentTitle == title }).forEach(removeTagView)
    }
    
    open func removeTagView(_ tagView: TagView) {
        defer { rearrangeViews() }
        
        tagView.removeFromSuperview()
        if let index = tagViews.firstIndex(of: tagView) {
            tagViews.remove(at: index)
            tagBackgroundViews.remove(at: index)
        }
    }
    
    open func removeAllTags() {
        defer {
            tagViews = []
            tagBackgroundViews = []
            rearrangeViews()
        }
        
        let views: [UIView] = tagViews + tagBackgroundViews
        views.forEach { $0.removeFromSuperview() }
    }

    open func selectedTags() -> [TagView] {
        return tagViews.filter { $0.isSelected }
    }
    
    // MARK: - Events
    
    @objc func tagPressed(_ sender: TagView!) {
        sender.onTap?(sender)
        delegate?.tagPressed?(sender.currentTitle ?? "", tagView: sender, sender: self)
//        delegate?.tagPressed?(sender.currentAttributedTitle?.string ?? "", tagView: sender, sender: self)
    }
    
    @objc func removeButtonPressed(_ closeButton: CloseButton!) {
        if let tagView = closeButton.tagView {
            delegate?.tagRemoveButtonPressed?(tagView.currentTitle ?? "qqqqqq", tagView: tagView, sender: self)
        }
    }
}
