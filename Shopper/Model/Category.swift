//
//  Category.swift
//  Shopper
//
//  Created by John Forde on 29/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import UIKit

struct Category {
	let name: String
	let color: UIColor

	init(name: String, color: UIColor) {
		self.name = name
		self.color = color
	}

	static func color(for category: String) -> UIColor {
		let categories = all
		for c in categories {
			if c.name == category { return c.color}
		}
		return UIColor.white
	}

	static let all: [Category] = [Category(name: "Vegetables", color: UIColor(hex6: 0x00796b)),
															Category(name: "Meat", color: UIColor(hex6: 0xe91e63)),
															Category(name: "Alcohol", color: UIColor(hex6: 0x9c27b0)),
															Category(name: "Coffee", color: UIColor(hex6: 0x673ab7)),
															Category(name: "Soft Drinks", color: UIColor(hex6: 0x3f51b5)),
															Category(name: "Eggs", color: UIColor(hex6: 0x2196f3)),
															Category(name: "Foreign Foods", color: UIColor(hex6: 0x03a9f4)),
															Category(name: "Rice", color: UIColor(hex6: 0x00bcd4)),
															Category(name: "Oil", color: UIColor(hex6: 0x009688)),
															Category(name: "Spices", color: UIColor(hex6: 0x4caf50)),
															Category(name: "Sauces", color: UIColor(hex6: 0x8bc34a)),
															Category(name: "Sugar", color: UIColor(hex6: 0xcddc39)),
															Category(name: "Bread", color: UIColor(hex6: 0xffeb3b)),
															Category(name: "Dairy - Milk", color: UIColor(hex6: 0xffc107)),
															Category(name: "Dairy - Butter/Cheese", color: UIColor(hex6: 0xff9800)),
															Category(name: "Fruit", color: UIColor(hex6: 0xff5722)),
															Category(name: "Pet", color: UIColor(hex6: 0x795548)),
															Category(name: "Pasta", color: UIColor(hex6: 0x9e9e9e)),
															Category(name: "Confectionary", color: UIColor(hex6: 0x607d8b)),
															Category(name: "Cooking", color: UIColor(hex6: 0xc51162)),
															Category(name: "Washing", color: UIColor(hex6: 0xd50000)),
															Category(name: "Frozen", color: UIColor(hex6: 0xaa00ff)),
															Category(name: "Fish", color: UIColor(hex6: 0x6200ea)),
															Category(name: "Baby", color: UIColor(hex6: 0x304ffe)),
															Category(name: "Checkout", color: UIColor(hex6: 0x0091ea))]
}
