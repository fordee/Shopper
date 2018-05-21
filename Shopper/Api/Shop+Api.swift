//
//  Shop.swift
//  Shopper
//
//  Created by John Forde on 12/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import then

extension Shop {
	static func fetchShops() -> Promise<[Shop]> {
		return api.fetchShops()
	}
	
	func save() -> Promise<Shop> {
		return api.addShop(path: "/shops", params: ["name": self.name])
	}
}
