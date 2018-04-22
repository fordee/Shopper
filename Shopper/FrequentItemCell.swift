//
//  FrequentItemCell.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Stevia

class FrequentItemCell: UITableViewCell {

	var frequentItemLabel = UILabel()

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none

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
		backgroundColor = UIColor.lightYellow
		frequentItemLabel.numberOfLines = 0
	}

	func frequentItemStyle(l: UILabel) {
		l.font = UIFont(name: "AmericanTypewriter", size: 20)
		l.textColor = UIColor.black
	}

}
