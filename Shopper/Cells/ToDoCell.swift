//
//  ToDoCell.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class ToDoCell: UITableViewCell {

	var shoppingItemLabel = UILabel()
	var colorBar = UIImageView()

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		sv(
			colorBar.style(colorBarStyle),
			shoppingItemLabel.style(shoppingItemStyle)
		)

		// Here we layout the cell.
		layout(
			0,
			|colorBar-10-shoppingItemLabel-16-|,
			0
		)

		// Configure visual elements
		backgroundColor = UIColor.white
		shoppingItemLabel.numberOfLines = 0
	}

	private func shoppingItemStyle(l: UILabel) {
		l.font = UIFont.mainFont
		l.textColor = UIColor.black
	}

	private func colorBarStyle(i: UIImageView) {
		i.backgroundColor = UIColor.red
		i.width(14)
	}
}
