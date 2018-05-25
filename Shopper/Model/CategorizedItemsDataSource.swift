//
//  CategorizedItemsDataSource.swift
//  Shopper
//
//  Created by John Forde on 6/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//


import Foundation

public class CategorizedItemsDataSource {

	static var categorizedItems: [CategorizedItem] = []
	static var frequentItems: [FrequentItem] = []
	static let cacher: Cacher = Cacher(destination: .temporary)

	@objc	static func refresh() {
		// First make a network request for FrequentItems
		FrequentItem.fetchFrequentItems().then { fetcheditems in
			self.frequentItems = fetcheditems
			// Now cache the fetcheditems
			let cachableItems = CachableFrequentItems(frequentItems: fetcheditems)
			cacher.persist(item: cachableItems) { url, error in
				if let error = error {
					print("FrequentItems failed to persist: \(error)")
				} else {
					print("FrequentItems persisted in \(String(describing: url))")
				}
				//NotificationCenter.default.post(name: .refreshFrequentItems, object: nil, userInfo: ["animated": false])
			}
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
				self.catagorizeItems()
				NotificationCenter.default.post(name: .refreshFrequentItems, object: nil, userInfo: ["animated": false])
		}
		// In the meantime, load our cached source
		if let cachedItems: CachableFrequentItems = cacher.load(fileName: "frequentitems") {
			print("FrequentItems read from cache.")
			frequentItems = cachedItems.frequentItems
			catagorizeItems()
			NotificationCenter.default.post(name: .refreshFrequentItems, object: nil, userInfo: ["animated": true])
		}
	}

	private static func catagorizeItems() {
		categorizedItems = []
		let sortedItems = frequentItems.sorted(by: { $0.category > $1.category}) // This only works if frequentItems is sorted

		var currentCategory = sortedItems.first?.category ?? ""
		if currentCategory == "" { currentCategory = "No Category" }
		var currentItemList: [FrequentItem] = []

		for item in sortedItems {
			if (currentCategory != item.category || sortedItems.last === item) { // The very last item needs to fall into this loop (hence the || condition)
				if !currentItemList.isEmpty {
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
		catagorizeItems()
		NotificationCenter.default.post(name: .refreshFrequentItems, object: nil, userInfo: ["animated": true])
	}

	static func deleteItem(_ item: FrequentItem) {
		item.delete().then {
			frequentItems = frequentItems.filter { frequentItem in
				return frequentItem.shoppingItem != item.shoppingItem
			}
			catagorizeItems()
			NotificationCenter.default.post(name: .refreshFrequentItems, object: nil, userInfo: ["animated": true])
			}.onError { e in
				print(e)
		}
	}
}

extension Notification.Name {
	static let refreshFrequentItems = Notification.Name("refreshFrequentItems")
}

