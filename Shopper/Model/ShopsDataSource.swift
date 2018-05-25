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

	@objc	static func refresh() {
		// First make a network request for shops
		Shop.fetchShops().then { fetchedShops in
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
}

extension Notification.Name {
	static let refreshShops = Notification.Name("refreshShops")
}
