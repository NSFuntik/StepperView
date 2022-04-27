//
//  PortfolioModel.swift
//  QLOGA
//
//  Created by Dmitry Mikhailov on 3/19/22.
//

import Foundation
import UIKit

struct PortfolioFolder: Identifiable, Hashable, Equatable {
	// MARK: Lifecycle

	init(title: String = "New Folder", images: [PortfolioImage] = [], isFocused: Bool = false, isPicked: Bool = false) {
		self.title = title
		self.images = images
		//        self.id = title.hashValue
		self.isFocused = isFocused
		self.isPicked = isPicked
	}

	// MARK: Internal

	var isFocused: Bool
	var isPicked: Bool
	var title: String
	var images: [PortfolioImage]
	var id = UUID().uuidString
}

struct PortfolioImage: Identifiable, Hashable, Equatable {
	// MARK: Lifecycle

	init(image: String = "PortfolioImage0", title: String = "", uploadDate: String = getString(from: Date.now, "dd/MM/yy HH:mm"), isFocused: Bool = false, isPicked: Bool = false, uiimage: UIImage? = nil) {
		self.title = title
		self.uploadDate = uploadDate
		self.isFocused = isFocused
		self.isPicked = isPicked
		self.image = UIImage(named: image)!

		if let uiimage = uiimage {
			self.image = uiimage
		}
	}

	// MARK: Internal

	var isFocused: Bool
	var title: String
	var id = UUID().uuidString
	var uploadDate: String
	var isPicked: Bool
	//    var uiimage: String
	var image: UIImage
}
