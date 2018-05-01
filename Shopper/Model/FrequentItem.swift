//
//  FrequentItem.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation
import IGListKit

protocol FrequentItemDelegate: class {
	func frequentItemDidUpdateMessages()
}

public class FrequentItem: Equatable {

	public static func == (lhs: FrequentItem, rhs: FrequentItem) -> Bool {
		return lhs.frequencyInt! > rhs.frequencyInt!
	}

	var shoppingItem: String
	var frequency: String
	var category: String

	var frequencyInt: Int? {
		return Int(frequency)
	}

	public required init() {
		self.shoppingItem = ""
		self.frequency = ""
		self.category = ""
	}

	public init(shoppingItem: String, frequency: String, category: String) {
		self.shoppingItem = shoppingItem
		self.frequency = frequency
		self.category = category
	}
}

extension FrequentItem: ListDiffable {
	public func diffIdentifier() -> NSObjectProtocol {
		return shoppingItem as NSObjectProtocol
	}

	public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
		return self == object as? FrequentItem
	}
}


public class FrequentItemDataSource {

	static weak var delegate: FrequentItemDelegate?

	static var frequentItems: [FrequentItem] = []

	@objc	static func refresh() {
		FrequentItem.fetchFrequentItems().then { fetcheditems in
			self.frequentItems = fetcheditems
			}.onError { e in
				print(e)
			}.finally {
				self.frequentItems.sort() { lhs, rhs in
					return lhs.frequencyInt! > rhs.frequencyInt!
				}
				self.delegate?.frequentItemDidUpdateMessages()
		}
	}

	static func updateItem(_ frequentItem: FrequentItem) {
		for item in frequentItems {
			if item.shoppingItem == frequentItem.shoppingItem { // shoppingItem is unique
				item.category = frequentItem.category
				item.frequency = frequentItem.frequency
				return // No need to continue since it is unique
			}
		}
	}
}
