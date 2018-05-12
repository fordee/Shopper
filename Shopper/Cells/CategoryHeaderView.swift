//
//  CategoryHeaderView.swift
//  Shopper
//
//  Created by John Forde on 6/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class CategoryHeaderView: UICollectionViewCell {
	var headingLabel = UILabel()

	var heading: String? {
		get {
			return headingLabel.text
		}
		set {
			headingLabel.text = newValue
		}
	}

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(frame: CGRect) {
		super.init(frame: frame)
		sv(headingLabel)
		layout(4,
					 |-headingLabel|,
					 4)

		backgroundColor = UIColor.darkColor
		headingLabel.textColor = UIColor.white
		headingLabel.font = UIFont.headerFont
	}

	
}
