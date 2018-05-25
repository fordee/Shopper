//
//  AisleCell.swift
//  Shopper
//
//  Created by John Forde on 13/5/18.
//  Copyright © 2018 4Dware. All rights reserved.
//

import UIKit
import Stevia

class AisleCell: UICollectionViewCell {

	var shop: Shop?
	var aisle: Aisle? {
		didSet {
			aisleLabel.text = aisle!.title
			aisleNumberLabel.text = aisle!.aisleNumber
		}
	}

	var aisleLabel = UILabel()
	var aisleNumberLabel = UILabel()
	var editButton = UIButton()
	var deleteButton = UIButton()
	weak var delegate: ShopDelegate?

	var cellHeight: CGFloat {
		print(aisleLabel.numberOfLines)
		let height = 12 + UIFont.cellFont.pointSize + 4
		return height

	}

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(frame: CGRect) {
		super.init(frame: frame)

		sv(
			aisleLabel.style { l in
				l.font = UIFont.cellFont
				l.textColor = UIColor.black
				l.numberOfLines = 0
			},
			aisleNumberLabel.style { l in
				l.font = UIFont.cellFont
				l.textColor = UIColor.darkColor
				l.numberOfLines = 0
				l.textAlignment = .right
				l.size(24)
			},
			editButton.style { b in
				b.size(24)
				b.image("edit")
				b.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
			},
			deleteButton.style { b in
				b.size(24)
				b.image("delete")
				b.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
			}
		)

		layout(
			6,
			|-8-aisleNumberLabel-16-aisleLabel-(>=16)-editButton-8-deleteButton-8-|,
			20
		)

		// Configure visual elements
		backgroundColor = UIColor.white
	}

	@objc private func editButtonTapped() {
		delegate?.aisleEdit(shop: shop!, aisle: aisle!)
	}

	@objc private func deleteButtonTapped() {
		if let shop = shop, let aisle = aisle {
			delegate?.aisleDelete(shop: shop, aisle: aisle)
		}
	}

	@objc private func addButtonTapped() {
		print("Add button tapped.")
	}

}
