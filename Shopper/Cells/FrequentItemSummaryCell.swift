//
//  FrequentItemListCell.swift
//  Shopper
//
//  Created by John Forde on 28/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Stevia

class FrequentItemSummaryCell: UICollectionViewCell {

	var frequentItemLabel = UILabel()

	static var cellHeight: CGFloat {
		let height = 20 + UIFont.mainFont.pointSize + 4
		return height
	}

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(frame: CGRect) {
		super.init(frame: frame)

		sv(
			frequentItemLabel.style(frequentItemStyle)
		)

		// Here we layout the cell.
		layout(
			10,
			|-16-frequentItemLabel-16-|,
			10
		)

		// Configure visual elements
		backgroundColor = UIColor.white
		frequentItemLabel.numberOfLines = 0
	}

	func frequentItemStyle(l: UILabel) {
		l.font = UIFont.mainFont//UIFont(name: "AmericanTypewriter", size: 20)
		l.textColor = UIColor.black
	}

}
