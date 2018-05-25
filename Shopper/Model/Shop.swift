//
//  Shop.swift
//  Shopper
//
//  Created by John Forde on 10/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation
import IGListKit

class Shop: Cachable, Codable, Equatable, CustomStringConvertible {
	var fileName: String = "Shop" // Cachable conformance

	var name = ""
	var aisles: [Aisle] = []

	var description: String {
		return name + String(" Aisle: \(aisles)")
	}

	static var currentShopName: String? = nil {
		didSet {
			UserDefaults.standard.setValue(currentShopName, forKey: "CurrentShop")
		}
	}

	init(name: String, aisles: [Aisle]) {
		self.name = name
		self.aisles = aisles
	}

	init(name: String) {
		self.name = name
	}

	required init() {

	}

	// MARK: Equatable Protocol
	static func == (lhs: Shop, rhs: Shop) -> Bool {
		return lhs.name > rhs.name
	}
}

extension Shop: ListDiffable {
	public func diffIdentifier() -> NSObjectProtocol {
		return name as NSObjectProtocol
	}

	public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
		return self == object as? Shop
	}
}

