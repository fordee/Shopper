//
//  FrequentItem.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation
import IGListKit

public class FrequentItem: Equatable {

	public static func == (lhs: FrequentItem, rhs: FrequentItem) -> Bool {
		return lhs.frequencyInt! > rhs.frequencyInt!
	}

	var shoppingItem: String
	var frequency: String
	var category: String

	var frequencyInt: Int? {
		return Int(frequency)
	}

	public required init() {
		self.shoppingItem = ""
		self.frequency = ""
		self.category = ""
	}

	public init(shoppingItem: String, frequency: String, category: String) {
		self.shoppingItem = shoppingItem
		self.frequency = frequency
		self.category = category
	}
}

extension FrequentItem: ListDiffable, Hashable {

	public var hashValue: Int {
		return shoppingItem.djb2hash ^ frequency.hashValue ^ category.hashValue
	}

	public func diffIdentifier() -> NSObjectProtocol {
		return shoppingItem as NSObjectProtocol
	}

	public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
		return self == object as? FrequentItem
	}
}


