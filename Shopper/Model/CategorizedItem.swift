//
//  CategorizedItems.swift
//  Shopper
//
//  Created by John Forde on 6/5/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Foundation
import IGListKit

class CategorizedItem: Equatable, CustomStringConvertible {

	var description: String {
		return "Category: \(category), item count: \(items.count)\n"
	}

	var category = ""
	var items: [FrequentItem] = []

	static func == (lhs: CategorizedItem, rhs: CategorizedItem) -> Bool {
		return lhs.category > rhs.category
	}

	init(category: String, items: [FrequentItem]) {
		self.category = category
		self.items = items
	}
}

extension CategorizedItem: ListDiffable {
	public func diffIdentifier() -> NSObjectProtocol {
		return category as NSObjectProtocol
	}

	public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
		return self == object as? CategorizedItem
	}
}
