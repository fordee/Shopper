//
//  ShopsDataSource.swift
//  Shopper
//
//  Created by John Forde on 12/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation

public class ShopsDataSource {

	static weak var delegate: FrequentItemDelegate?

	static var shops: [Shop] = []

	@objc	static func refresh() {
		Shop.fetchShops().then { fetchedShops in
			self.shops = fetchedShops
		}.onError { e in
			print(e)
		}.finally {
			self.delegate?.frequentItemDidUpdateMessages()
		}
	}

//	static func updateItem(_ frequentItem: FrequentItem) {
//		for item in frequentItems {
//			if item.shoppingItem == frequentItem.shoppingItem { // shoppingItem is unique
//				item.category = frequentItem.category
//				item.frequency = frequentItem.frequency
//				return // No need to continue since it is unique
//			}
//		}
//	}
}
