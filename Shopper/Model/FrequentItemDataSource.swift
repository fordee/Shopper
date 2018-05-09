//
//  FrequentItemDataSource.swift
//  Shopper
//
//  Created by John Forde on 6/5/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Foundation

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
