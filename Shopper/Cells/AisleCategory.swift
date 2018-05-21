//
//  AisleCategory.swift
//  Shopper
//
//  Created by John Forde on 13/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

//
//  AisleCell.swift
//  Shopper
//
//  Created by John Forde on 13/5/18.
//  Copyright © 2018 4Dware. All rights reserved.
//

import UIKit
import Stevia

class AisleCategoryCell: UICollectionViewCell {

	var aisle: Aisle? {
		didSet {
			aisleLabel.text = aisle!.title
			aisleNumberLabel.text = aisle!.aisleNumber
		}
	}
	var shopName: String? = nil

	var aisleLabel = UILabel()
	var aisleNumberLabel = UILabel()
	var addButton = UIButton()
	weak var delegate: AisleDelegate?

	var cellHeight: CGFloat {
		print(aisleLabel.numberOfLines)
		let height = 12 + UIFont.cellFont.pointSize + 4  // TODO: Work out the number of lines and size accordingly
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
			addButton.style { b in
				b.size(24)
				b.image("add")
				b.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
			}
		)

		layout(
				6,
				|-8-aisleNumberLabel-16-aisleLabel-(>=16)-addButton-8-|,
				20
		)
	
		// Configure visual elements
		backgroundColor = UIColor.white
	}

	@objc private func addButtonTapped() {
		print("Add button tapped.")
		if let aisle = aisle, let shopName = shopName {
			delegate?.categoryAdd(aisle: aisle, shopName: shopName)
		}
	}

}

