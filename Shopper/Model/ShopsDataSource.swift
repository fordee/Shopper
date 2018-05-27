//
//  ShopsDataSource.swift
//  Shopper
//
//  Created by John Forde on 12/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation

public class ShopsDataSource {

	static var shops: [Shop] = []
	static let cacher: Cacher = Cacher(destination: .temporary)

	static func refresh() {
		// First make a network request for shops
		Shop.fetchShops().then { fetchedShops in
			self.shops = fetchedShops
			// Now cache the shops
			let cachableShops = CachableShops(shops: self.shops)
			cacher.persist(item: cachableShops) { url, error in
				if let error = error {
					print("Shops failed to persist: \(error)")
				} else {
					print("Shops persisted in \(String(describing: url))")
				}
				NotificationCenter.default.post(name: .refreshShops, object: nil, userInfo: ["animated": false])
			}
			}.onError { e in
				print(e)
		}
		// In the meantime, load our cached source
		if let cachedShops: CachableShops = cacher.load(fileName: "shops") {
			shops = cachedShops.shops
			NotificationCenter.default.post(name: .refreshShops, object: nil, userInfo: ["animated": true])
		}
	}

	static func swapAislesFor(shop: Shop, aisle1: inout Aisle, aisle2: inout Aisle) {
		swap(&aisle1, &aisle2)
		// Update aisle1
		aisle1.update(shop: shop).then { [aisle2] _ in
			aisle2.update(shop: shop).then { _ in
					print("Success")
				}.onError { e in
					print(e)
			}
			}.onError { e in
				print(e)
		}
	}

}

extension Notification.Name {
	static let refreshShops = Notification.Name("refreshShops")
}
