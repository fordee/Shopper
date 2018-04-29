//
//  FrequentItem.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Foundation
import IGListKit

protocol FrequentItemDelegate: class {
	func frequentItemDidUpdateMessages(frequentItemDataSource: FrequentItemDataSource)
}

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

extension FrequentItem: ListDiffable {
	public func diffIdentifier() -> NSObjectProtocol {
		return shoppingItem as NSObjectProtocol
	}

	public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
		return self == object as? FrequentItem
	}
}


public class FrequentItemDataSource {

	weak var delegate: FrequentItemDelegate?

	var frequentItems: [FrequentItem] = []

	@objc	func refresh() {
		FrequentItem.fetchFrequentItems().then { fetcheditems in
			self.frequentItems = fetcheditems
			}.onError { e in
				print(e)
			}.finally {
				self.frequentItems.sort() { lhs, rhs in
					return lhs.frequencyInt! > rhs.frequencyInt!
				}
				self.delegate?.frequentItemDidUpdateMessages(frequentItemDataSource: self)
		}
	}
}
