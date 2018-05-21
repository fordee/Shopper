//
//  ShopMenuCell+ShopItem.swift
//  Shopper
//
//  Created by John Forde on 20/5/18.
//  Copyright © 2018 freshOS. All rights reserved.
//
import Foundation

extension ShopMenuCell {

	func render(with: Shop) {
		shopItemLabel.text = with.name
	}

}
