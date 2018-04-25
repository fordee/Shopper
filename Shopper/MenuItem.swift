//
//  MenuItem.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

struct MenuItem {
	var menuName: String
	var icon: UIImageView

	init(menuName: String, iconName: String) {
		self.menuName = menuName
		self.icon = UIImageView(image: UIImage(named: iconName))
	}
}
