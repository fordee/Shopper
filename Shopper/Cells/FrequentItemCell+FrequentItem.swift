//
//  FrequentItemCell-FrequentItem.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

extension FrequentItemCell {

	func render(with: FrequentItem) {
		frequentItemLabel.text = with.shoppingItem
	}

}

