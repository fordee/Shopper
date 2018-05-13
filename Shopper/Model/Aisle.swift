//
//  Aisle.swift
//  Shopper
//
//  Created by John Forde on 10/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation

struct Aisle: Equatable, CustomStringConvertible {
	var title = ""
	var aisleNumber = ""
	var categories: [String] = []

	var aisleNumberInt: Int {
		return Int(aisleNumber)!
	}

	init(title: String, aisleNumber: String, categories: [String]) {
		self.title = title
		self.aisleNumber = aisleNumber
		self.categories = categories
	}

	init(title: String, aisleNumber: String) {
		self.title = title
		self.aisleNumber = aisleNumber
	}

	init() {

	}

	var description: String {
		return title + String(" Categories: \(categories)")
	}

	// MARK: Equatable Protocol
	static func == (lhs: Aisle, rhs: Aisle) -> Bool {
		return lhs.title > rhs.title
	}
}


