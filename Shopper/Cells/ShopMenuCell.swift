//
//  ShopMenuCell.swift
//  Shopper
//
//  Created by John Forde on 20/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class ShopMenuCell: UITableViewCell {

	var shopItemLabel = UILabel()
	var menuIcon = UIImageView(image: UIImage(named: "menu_icon"))

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		//selectionStyle = .none

		sv(
			menuIcon.style(menuIconStyle),
			shopItemLabel.style(menuItemLabelStyle)
		)

		// Here we layout the cell.
		layout(
			10,
			|-menuIcon.centerVertically()-16-shopItemLabel.centerVertically()-(>=8)-|,
			10
		)

		// Configure visual elements
		backgroundColor = UIColor.white
		shopItemLabel.numberOfLines = 0
	}

	private func menuItemLabelStyle(l: UILabel) {
		l.font = UIFont.menuFont
		l.textColor = UIColor.black
		l.textAlignment = .left
	}

	private func menuIconStyle(i: UIImageView) {
		i.height(16)
		i.width(16)
	}

}
