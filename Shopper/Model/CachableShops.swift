//
//  CachableShops.swift
//  Shopper
//
//  Created by John Forde on 25/5/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Foundation

struct CachableShops: Cachable, Codable {
	let shops: [Shop]

	var fileName: String {
		return "shops"
	}

	init(shops: [Shop]) {
		self.shops = shops
	}
}
