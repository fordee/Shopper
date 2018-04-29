//
//  FrequentItem+Api.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import then

extension FrequentItem {
	static func fetchFrequentItems() -> Promise<[FrequentItem]> {
		return api.fetchFrequentItems()
	}

	func save() -> Promise<FrequentItem> {
		return api.saveFrequentItem(path: "/common-items", params: ["Category": category, "ShoppingItem": shoppingItem, "Frequency": frequency])
	}
}
