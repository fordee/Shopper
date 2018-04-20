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

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		sv(
			shoppingItemLabel.style(shoppingItemStyle)
		)

		// Here we layout the cell.
		layout(
			10,
			|-16-shoppingItemLabel-16-|,
			10
		)

		// Configure visual elements
		backgroundColor = UIColor.lightYellow
		shoppingItemLabel.numberOfLines = 0
	}

	func shoppingItemStyle(l: UILabel) {
		l.font = UIFont(name: "AmericanTypewriter", size: 20)
		l.textColor = UIColor.black
	}
	
}
