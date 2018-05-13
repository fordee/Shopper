//
//  Aisle+Api.swift
//  Shopper
//
//  Created by John Forde on 13/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import then

extension Aisle {
	func delete(shop: Shop) -> Promise<Void> {
		let deleteString = "/aisles/\(shop.name)/\(aisleNumber)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
		print("Delete String: \(deleteString)")
		return api.deleteAisle(path: deleteString)
	}

	func save(shop: Shop) -> Promise<Aisle> {
		return api.addAisle(path: "/aisles", params: ["shopName": shop.name, "aisleNumber": aisleNumber, "title": title])
	}

}
