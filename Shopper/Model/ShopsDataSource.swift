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

	@objc	static func refresh() {
		Shop.fetchShops().then { fetchedShops in
			self.shops = fetchedShops
		}.onError { e in
			print(e)
		}.finally {
			NotificationCenter.default.post(name: .refreshShops, object: nil)
		}
	}
}

extension Notification.Name {
	static let refreshShops = Notification.Name("refreshShops")
}
