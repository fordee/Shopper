//
//  CategorizedItemsDataSource.swift
//  Shopper
//
//  Created by John Forde on 6/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//


import Foundation

public class CategorizedItemsDataSource {

	static weak var delegate: FrequentItemDelegate?
	static var categorizedItems: [CategorizedItem] = []
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
				frequentItems.forEach { item in
					if item.category == "" {
						item.category = "No Category"
					}
				}
				self.catgorizeItems()
				self.delegate?.frequentItemDidUpdateMessages()
		}
	}

	static func catgorizeItems() {
		categorizedItems = []

		let sortedItems = frequentItems.sorted(by: { $0.category > $1.category}) // This only works if frequentItems is sorted
		
		var currentCategory = sortedItems.first?.category ?? ""
		if currentCategory == "" { currentCategory = "No Category" }
		var currentItemList: [FrequentItem] = []

		for item in sortedItems {
			if (currentCategory != item.category || sortedItems.last === item) { // The very last item needs to fall into this loop (hence the || condition)
				if currentItemList.count > 0 {
					categorizedItems.append(CategorizedItem(category: currentCategory, items: currentItemList))
					currentCategory = item.category
					currentItemList = [item]
				}
			} else {
				currentItemList.append(item)
			}
		}
		print("\(categorizedItems)")
	}

	static func updateItem(_ frequentItem: FrequentItem) {
		for item in frequentItems {
			if item.shoppingItem == frequentItem.shoppingItem { // shoppingItem is unique
				item.category = frequentItem.category
				item.frequency = frequentItem.frequency
				break // No need to continue since it is unique
			}
		}
		catgorizeItems()
		self.delegate?.frequentItemDidUpdateMessages()
	}

	static func deleteItem(_ item: FrequentItem) {
		item.delete().then {
			frequentItems = frequentItems.filter { frequentItem in
				return frequentItem.shoppingItem != item.shoppingItem
			}
			catgorizeItems()
			self.delegate?.frequentItemDidUpdateMessages()
		}.onError { e in
				print(e)
		}
	}

}

