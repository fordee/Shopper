//
//  FrequentItem+JSON.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Arrow

extension FrequentItem : ArrowParsable {
	public init() {

	}

	public mutating func deserialize(_ json: JSON) {
		shoppingItem  <-- json["ShoppingItem"]
		frequency <-- json["Frequency"]
	}

}

