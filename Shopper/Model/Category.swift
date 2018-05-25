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
		for c in categories where c.name == category {
			return c.color
		}
		return UIColor.white
	}

	static let all: [Category] = [
		Category(name: "Alcohol", color: UIColor(hex6: 0x9c27b0)),
		Category(name: "Baby", color: UIColor(hex6: 0x304ffe)),
		Category(name: "Bags & Wraps", color: UIColor(hex6: 0x34515e)),
		Category(name: "Baking Needs", color: UIColor(hex6: 0x707070)),
		Category(name: "Biscuits", color: UIColor(hex6: 0x4b2c20)),
		Category(name: "Bread", color: UIColor(hex6: 0xffeb3b)),
		Category(name: "Breakfast Foods", color: UIColor(hex6: 0x951478)),
		Category(name: "Bulk Foods", color: UIColor(hex6: 0xc41c00)),
		Category(name: "Canned Foods", color: UIColor(hex6: 0xc66900)),
		Category(name: "Canned Fruit", color: UIColor(hex6: 0xffc947)),
		Category(name: "Checkout", color: UIColor(hex6: 0x0091ea)),
		Category(name: "Coffee", color: UIColor(hex6: 0x673ab7)),
		Category(name: "Confectionary", color: UIColor(hex6: 0x607d8b)),
		Category(name: "Containers", color: UIColor(hex6: 0xba000d)),
		Category(name: "Cordial", color: UIColor(hex6: 0xff7961)),
		Category(name: "Cooking", color: UIColor(hex6: 0xc51162)),
		Category(name: "Dairy - Milk", color: UIColor(hex6: 0xffc107)),
		Category(name: "Dairy - Butter/Cheese", color: UIColor(hex6: 0xff9800)),
		Category(name: "Desserts", color: UIColor(hex6: 0x6a0080)),
		Category(name: "Eggs", color: UIColor(hex6: 0x2196f3)),
		Category(name: "Fish", color: UIColor(hex6: 0x6200ea)),
		Category(name: "Foreign Foods", color: UIColor(hex6: 0x03a9f4)),
		Category(name: "Frozen", color: UIColor(hex6: 0xaa00ff)),
		Category(name: "Fruit", color: UIColor(hex6: 0xff5722)),
		Category(name: "Fuels", color: UIColor(hex6: 0xd05ce3)),
		Category(name: "Gardening", color: UIColor(hex6: 0x320b86)),
		Category(name: "Hair Care", color: UIColor(hex6: 0x757de8)),
		Category(name: "Herbs", color: UIColor(hex6: 0x0069c0)),
		Category(name: "Juice", color: UIColor(hex6: 0x6ec6ff)),
		Category(name: "Light Bulbs", color: UIColor(hex6: 0x007ac1)),
		Category(name: "Meat", color: UIColor(hex6: 0xe91e63)),
		Category(name: "Muesli Bars", color: UIColor(hex6: 0x002984)),
		Category(name: "Noodles", color: UIColor(hex6: 0x67daff)),
		Category(name: "Oil", color: UIColor(hex6: 0x009688)),
		Category(name: "Oral Care", color: UIColor(hex6: 0x008ba3)),
		Category(name: "Paper Towels", color: UIColor(hex6: 0x9a67ea)),
		Category(name: "Party Time", color: UIColor(hex6: 0x62efff)),
		Category(name: "Pasta", color: UIColor(hex6: 0x9e9e9e)),
		Category(name: "Pet", color: UIColor(hex6: 0x795548)),
		Category(name: "Rice", color: UIColor(hex6: 0x00bcd4)),
		Category(name: "Sauces", color: UIColor(hex6: 0x8bc34a)),
		Category(name: "Shaving", color: UIColor(hex6: 0x00675b)),
		Category(name: "Skin Care", color: UIColor(hex6: 0x5a9216)),
		Category(name: "Snack Foods", color: UIColor(hex6: 0x087f23)),
		Category(name: "Soft Drinks", color: UIColor(hex6: 0x3f51b5)),
		Category(name: "Spices", color: UIColor(hex6: 0x4caf50)),
		Category(name: "Spreads", color: UIColor(hex6: 0x951da8)),
		Category(name: "Sugar", color: UIColor(hex6: 0xcddc39)),
		Category(name: "Tableware", color: UIColor(hex6: 0x52c7b8)),
		Category(name: "Tea", color: UIColor(hex6: 0x80e27e)),
		Category(name: "Tissues", color: UIColor(hex6: 0xbef67a)),
		Category(name: "Toilet Paper", color: UIColor(hex6: 0xffff6e)),
		Category(name: "Toys", color: UIColor(hex6: 0xffff72)),
		Category(name: "Vegetables", color: UIColor(hex6: 0x00796b)),
		Category(name: "Vinegar", color: UIColor(hex6: 0xfff350)),
		Category(name: "Vitamins", color: UIColor(hex6: 0xc8b900)),
		Category(name: "Washing", color: UIColor(hex6: 0xd50000)),
		Category(name: "Water", color: UIColor(hex6: 0x99aa00))]
}
