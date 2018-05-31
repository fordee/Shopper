//
//  CachableFrequentItems.swift
//  Shopper
//
//  Created by John Forde on 26/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation

struct CachableFrequentItems: Cachable, Codable {
	let frequentItems: [FrequentItem]

	var fileName: String {
		return "frequentitems"
	}

	init(frequentItems: [FrequentItem]) {
		self.frequentItems = frequentItems
	}
}
