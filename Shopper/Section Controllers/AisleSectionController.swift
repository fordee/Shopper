//
//  AisleSectionController.swift
//  Shopper
//
//  Created by John Forde on 13/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit
import IGListKit

class AisleSectionController: ListSectionController {
	var aisle: Aisle!
	var shop: Shop?

	weak var delegate: AisleDelegate?

	override init() {
		super.init()
		inset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
	}

	override func numberOfItems() -> Int {
		return aisle.categories.count + 1 // Including the Aisle Cell
	}

	override func didUpdate(to object: Any) {
		aisle = object as? Aisle
	}

	override func cellForItem(at index: Int) -> UICollectionViewCell {
		let cellClass: AnyClass = index == 0 ? AisleCategoryCell.self : CategoryCell.self
		let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)

		if let cell = cell as? AisleCategoryCell {
			cell.aisle = aisle
			cell.shopName = shop?.name
			cell.delegate = delegate
		} else if let cell = cell as? CategoryCell {
			cell.shopName = shop?.name
			cell.aisle = aisle
			cell.category = aisle.categories[index - 1]
			cell.delegate = delegate
		}
		return cell
	}

	override func sizeForItem(at index: Int) -> CGSize {
		guard let context = collectionContext else { return .zero}
		let width = context.containerSize.width
		let height: CGFloat = index == 0 ? 65 : 45
		return CGSize(width: width, height: height)
	}

	override func didSelectItem(at index: Int) {
		print("index: \(index)")
		if index == 0 {
			collectionContext?.performBatch(animated: true, updates: { batchContext in
				batchContext.reload(self)
			})
		}
	}
}

