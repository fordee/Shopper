//
//  FrequentItem+Api.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import then

extension FrequentItem {
	static func fetchFrequentItems() -> Promise<[FrequentItem]> {
		return api.fetchFrequentItems()
	}
}
