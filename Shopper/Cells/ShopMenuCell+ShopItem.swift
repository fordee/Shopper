//
//  ShopMenuCell+ShopItem.swift
//  Shopper
//
//  Created by John Forde on 20/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

extension ShopMenuCell {

	func render(with: Shop) {
		if with.name.lowercased().contains("countdown") {
			menuIcon.image = UIImage(named: "countdown_logo")
		}
		if with.name.lowercased().contains("new world") {
			menuIcon.image = UIImage(named: "new_world_logo")
		}
		shopItemLabel.text = with.name
	}

}
