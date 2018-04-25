//
//  MenuCell.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class MenuCell: UITableViewCell {

	var menuItemLabel = UILabel()

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none

		sv(
			menuItemLabel.style(menuItemStyle)
		)

		// Here we layout the cell.
		layout(
			10,
			|-16-menuItemLabel-|,
			10
		)

		// Configure visual elements
		backgroundColor = UIColor.white
		menuItemLabel.numberOfLines = 0
	}

	func menuItemStyle(l: UILabel) {
		l.font = UIFont.mainFont
		l.textColor = UIColor.black
	}

}
