//
//  Category.swift
//  Shopper
//
//  Created by John Forde on 29/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
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

	static let all: [Category] = [
		Category(name: "Alcohol", color: UIColor(hex6: 0x9c27b0)),
		Category(name: "Baby", color: UIColor(hex6: 0x304ffe)),
		Category(name: "Bags & Wraps", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Baking Needs", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Biscuits", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Bread", color: UIColor(hex6: 0xffeb3b)),
		Category(name: "Breakfast Foods", color: UIColor(hex6: 0x951478)),
		Category(name: "Bulk Foods", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Canned Foods", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Canned Fruit", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Checkout", color: UIColor(hex6: 0x0091ea)),
		Category(name: "Coffee", color: UIColor(hex6: 0x673ab7)),
		Category(name: "Confectionary", color: UIColor(hex6: 0x607d8b)),
		Category(name: "Containers", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Cordial", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Cooking", color: UIColor(hex6: 0xc51162)),
		Category(name: "Dairy - Milk", color: UIColor(hex6: 0xffc107)),
		Category(name: "Dairy - Butter/Cheese", color: UIColor(hex6: 0xff9800)),
		Category(name: "Desserts", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Eggs", color: UIColor(hex6: 0x2196f3)),
		Category(name: "Fish", color: UIColor(hex6: 0x6200ea)),
		Category(name: "Foreign Foods", color: UIColor(hex6: 0x03a9f4)),
		Category(name: "Frozen", color: UIColor(hex6: 0xaa00ff)),
		Category(name: "Fruit", color: UIColor(hex6: 0xff5722)),
		Category(name: "Fuels", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Gardening", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Hair Care", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Herbs", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Juice", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Light Bulbs", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Meat", color: UIColor(hex6: 0xe91e63)),
		Category(name: "Muesli Bars", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Noodles", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Oil", color: UIColor(hex6: 0x009688)),
		Category(name: "Oral Care", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Paper Towels", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Party Time", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Pasta", color: UIColor(hex6: 0x9e9e9e)),
		Category(name: "Pet", color: UIColor(hex6: 0x795548)),
		Category(name: "Rice", color: UIColor(hex6: 0x00bcd4)),
		Category(name: "Sauces", color: UIColor(hex6: 0x8bc34a)),
		Category(name: "Shaving", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Skin Care", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Snack Foods", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Soft Drinks", color: UIColor(hex6: 0x3f51b5)),
		Category(name: "Spices", color: UIColor(hex6: 0x4caf50)),
		Category(name: "Spreads", color: UIColor(hex6: 0x951da8)),
		Category(name: "Sugar", color: UIColor(hex6: 0xcddc39)),
		Category(name: "Tableware", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Tea", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Tissues", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Toilet Paper", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Toys", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Vegetables", color: UIColor(hex6: 0x00796b)),
		Category(name: "Vinegar", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Vitamins", color: UIColor(hex6: 0xFFFFFF)),
		Category(name: "Washing", color: UIColor(hex6: 0xd50000)),
		Category(name: "Water", color: UIColor(hex6: 0xFFFFFF))]
}
