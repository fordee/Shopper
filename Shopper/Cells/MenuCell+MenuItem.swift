//
//  MenuCell+MenuItem.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation

extension MenuCell {

	func render(with: MenuItem) {
		menuItemLabel.text = with.menuName
		menuIcon = with.icon
	}

}
