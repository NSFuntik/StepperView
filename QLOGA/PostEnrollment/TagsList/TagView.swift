//
//  TagView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

@IBDesignable
open class TagView: UIButton {

    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var textColor: UIColor = UIColor.black {
        didSet {
            reloadStyles()
        }
    }

    @IBInspectable open var textSize: CGFloat = 14 {
        didSet {
            reloadStyles()
        }
    }

    @IBInspectable open var selectedTextColor: UIColor = UIColor.black {
        didSet {
            reloadStyles()
        }
    }
    @IBInspectable open var titleLineBreakMode: NSLineBreakMode = .byTruncatingMiddle {
        didSet {
            titleLabel?.lineBreakMode = titleLineBreakMode
        }
    }
    @IBInspectable open var paddingY: CGFloat = 2 {
        didSet {
            titleEdgeInsets.top = paddingY
            titleEdgeInsets.bottom = paddingY
        }
    }
    @IBInspectable open var paddingX: CGFloat = 5 {
        didSet {
            titleEdgeInsets.left = paddingX
            updateRightInsets()
        }
    }

    @IBInspectable open var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var highlightedBackgroundColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var selectedBorderColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var selectedBackgroundColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var textFont: UIFont = .rounded(ofSize: 14, weight: .medium) {
        didSet {
            titleLabel?.font = textFont.withSize(textSize)
            titleLabel?.adjustsFontSizeToFitWidth

        }
    }
    
    private func reloadStyles() {
        if isHighlighted {
            if let highlightedBackgroundColor = highlightedBackgroundColor {
                // For highlighted, if it's nil, we should not fallback to backgroundColor.
                // Instead, we keep the current color.
                backgroundColor = highlightedBackgroundColor
            }
        }
        else if isSelected {
            backgroundColor = selectedBackgroundColor ?? tagBackgroundColor
            layer.borderColor = selectedBorderColor?.cgColor ?? borderColor?.cgColor
            setTitleColor(selectedTextColor, for: UIControl.State())
        }
        else {
            backgroundColor = tagBackgroundColor
            layer.borderColor = borderColor?.cgColor
            setTitleColor(textColor, for: UIControl.State())
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            reloadStyles()
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            reloadStyles()
        }
    }
    
    // MARK: remove button
    
    let removeButton = CloseButton()
    
    @IBInspectable open var enableRemoveButton: Bool = false {
        didSet {
            removeButton.isHidden = !enableRemoveButton
            updateRightInsets()
        }
    }
    
    @IBInspectable open var removeButtonIconSize: CGFloat = 9 {
        didSet {
            removeButton.iconSize = removeButtonIconSize
            updateRightInsets()
        }
    }
    
    @IBInspectable open var removeIconLineWidth: CGFloat = 3 {
        didSet {
            removeButton.lineWidth = removeIconLineWidth
        }
    }
    @IBInspectable open var removeIconLineColor: UIColor = UIColor(named: "Orange")! {
        didSet {
            removeButton.lineColor = removeIconLineColor
        }
    }
    
    /// Handles Tap (TouchUpInside)
    open var onTap: ((TagView) -> ())?
    open var onLongPress: ((TagView) -> Void)?
    
    // MARK: - init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.onTap(s)
        setupView()
    }
    
    public init(title: String) {
        super.init(frame: CGRect.zero)
    
//        let attributedTitle = try? NSAttributedString(
//            data: title.data(using: .utf8) ?? Data(),
//            options: [.documentType: NSAttributedString.DocumentType.html],
//            documentAttributes: nil
//        )
//        setAttributedTitle(attributedTitle, for: UIControl.State())
//        setImage(UIImage(systemName: "\(Int(title.filter({$0.isNumber})) ?? 0).circle"), for: UIControl.State())
        setTitle(title, for: UIControl.State())

        
        setupView()
    }
    
    private func setupView() {
        titleLabel?.lineBreakMode = titleLineBreakMode
        frame.size = intrinsicContentSize
        addSubview(removeButton)
        removeButton.tagView = self

//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
////        self.titleLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5.0).isActive = true
//        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6.0).isActive = true
//        self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
//        addSubview(subIcon)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        self.addGestureRecognizer(longPress)
    }
    
    @objc func longPress() {
        onLongPress?(self)
    }
    
    // MARK: - layout

    override open var intrinsicContentSize: CGSize {
        var size = CGSize(width: (imageView?.frame.size.width)! + (titleLabel?.frame.size.width)!, height: (titleLabel?.frame.size.height)!) //imageView?.frame.size + titleLabel?.frame.size + removeButton.iconSize
        size.height = textFont.pointSize + paddingY * 2
        size.width += paddingX * 4
        if size.width < size.height {
            size.width = size.height
        }
        if enableRemoveButton {
            size.width += removeButtonIconSize + paddingX
        }
        return size
    }
    
    private func updateRightInsets() {
        if enableRemoveButton {
            titleEdgeInsets.right = paddingX  + removeButtonIconSize + paddingX
            titleEdgeInsets.left = 0
        }
        else {
            titleEdgeInsets.right = paddingX
            titleEdgeInsets.left = 0

        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if enableRemoveButton {
            removeButton.frame.size.width =  paddingX +  removeButtonIconSize + paddingX//paddingX +
            removeButton.frame.origin.x = self.frame.width - removeButton.frame.width
            removeButton.frame.size.height = self.frame.height
            removeButton.frame.origin.y = 0
        }
    }
}

extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: 14, weight: weight)

        let descriptor = systemFont.fontDescriptor.withDesign(.rounded)!
        return UIFont(descriptor: descriptor, size: size)
    }
}

/// Swift < 4.2 support
#if !(swift(>=4.2))
private extension NSAttributedString {
    typealias Key = NSAttributedStringKey
}
private extension UIControl {
    typealias State = UIControlState
}
#endif


extension Int {
    var serviceTypeID: CategoryType {
        return CategoryType.init(rawValue: self)!
    }
}
