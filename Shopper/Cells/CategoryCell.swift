//
//  CategoryCell.swift
//  Shopper
//
//  Created by John Forde on 13/5/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import UIKit
import Stevia

class CategoryCell: UICollectionViewCell {

	var category: String? {
		didSet {
			categoryLabel.text = category!
		}
	}
	var aisle: Aisle? = nil
	var shopName: String? = nil

	var categoryLabel = UILabel()
	var deleteButton = UIButton()
	
	weak var delegate: AisleDelegate?

	var cellHeight: CGFloat {
		print(categoryLabel.numberOfLines)
		let height = 12 + UIFont.cellFont.pointSize + 4  // TODO: Work out the number of lines and size accordingly
		return height

	}

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(frame: CGRect) {
		super.init(frame: frame)

		sv(
			deleteButton.style { b in
				b.size(24)
				b.image("delete")
				b.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
			},
			categoryLabel.style { l in
				l.font = UIFont.cellFont
				l.textColor = UIColor.black
				l.numberOfLines = 1
			}
		)

		layout(
			6,
			|-16-categoryLabel-(>=16)-deleteButton-8-|,
			6
		)

		// Configure visual elements
		backgroundColor = UIColor.white
	}

	@objc private func deleteButtonTapped() {
		print("Delete button tapped")
		if let aisle = aisle, let shopName = shopName, let category = category {
			delegate?.categoryDelete(aisle: aisle, shopName: shopName, category: category)
		}
	}
}
