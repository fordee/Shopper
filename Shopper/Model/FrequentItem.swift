//
//  FrequentItem.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation

public struct FrequentItem: Equatable {
	var shoppingItem = ""
	var frequency = ""

	var frequencyInt: Int? {
		return Int(frequency)
	}

	public init(shoppingItem: String, frequency: String) {
		self.shoppingItem = shoppingItem
		self.frequency = frequency
	}
}
