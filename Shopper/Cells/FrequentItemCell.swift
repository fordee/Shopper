//
//  FrequentItemCell.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class FrequentItemCell: UITableViewCell {

	var frequentItemLabel = UILabel()
	var colorBar = UIImageView()

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none

		sv(
			colorBar.style(colorBarStyle),
			frequentItemLabel.style(frequentItemStyle)
		)

		// Here we layout the cell.
		layout(
			0,
			|colorBar-10-frequentItemLabel-16-|,
			0
		)

		// Configure visual elements
		backgroundColor = UIColor.white//.lightYellow
		frequentItemLabel.numberOfLines = 0
	}

	private func frequentItemStyle(l: UILabel) {
		l.font = UIFont.mainFont//UIFont(name: "AmericanTypewriter", size: 20)
		l.textColor = UIColor.black
	}

	private func colorBarStyle(i: UIImageView) {
		i.backgroundColor = UIColor.red
		i.width(14)
	}
}
