//
//  ShopSectionController.swift
//  Shopper
//
//  Created by John Forde on 12/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit
import IGListKit

class ShopSectionController: ListSectionController {
	var shop: Shop!
	var expanded = false
	weak var delegate: ShopDelegate?

	override init() {
		super.init()
		inset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
	}

	override func numberOfItems() -> Int {
		return expanded ? shop.aisles.count + 1 : 1
	}

	override func didUpdate(to object: Any) {
		shop = object as? Shop
	}

	override func cellForItem(at index: Int) -> UICollectionViewCell {

		let cellClass: AnyClass = index == 0 ? ShopCell.self : AisleCell.self

		let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)

		if let cell = cell as? ShopCell {
			cell.shop = shop
			cell.addButton.isHidden = !expanded
			cell.delegate = delegate
		} else if let cell = cell as? AisleCell {
			let aisle = shop.aisles[index - 1] // subtract one from index because first cell is Shop Name
			cell.delegate = delegate
			cell.shop = shop
			cell.aisle = aisle
		}
		return cell
	}

	override func sizeForItem(at index: Int) -> CGSize {
		guard let context = collectionContext else { return .zero}
		let width = context.containerSize.width
		let height: CGFloat = 55
		return CGSize(width: width, height: height)
	}

	override func didSelectItem(at index: Int) {
		print("index: \(index)")
		if index == 0 {
			expanded = !expanded
			collectionContext?.performBatch(animated: true, updates: { batchContext in
				batchContext.reload(self)
			})
		}
	}
}
