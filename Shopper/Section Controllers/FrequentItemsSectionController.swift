//
//  FrequentItemsSectionController.swift
//  Shopper
//
//  Created by John Forde on 28/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import IGListKit

class FrequentItemsSectionController: ListSectionController {

	var frequentItem: FrequentItem!
	var expanded = false

	override init() {
		super.init()
		inset = UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 4)
	}

	override func numberOfItems() -> Int {
		return expanded ? 2 : 1
	}

	override func didUpdate(to object: Any) {
		frequentItem = object as? FrequentItem
	}

	override func cellForItem(at index: Int) -> UICollectionViewCell {
		let cellClass: AnyClass = index == 0 ? FrequentItemSummaryCell.self : FrequentItemDetailCell.self
		let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
		if let cell = cell as? FrequentItemSummaryCell {
			cell.frequentItemLabel.text = frequentItem.shoppingItem // Change to use render() later
		} else if let cell = cell as? FrequentItemDetailCell {
			cell.shoppingItem = frequentItem.shoppingItem
			cell.frequency = frequentItem.frequency
			if frequentItem.category == "" { frequentItem.category = "No Category" }
			cell.category = frequentItem.category
		}
		return cell
	}

	override func sizeForItem(at index: Int) -> CGSize {
		guard let context = collectionContext else { return .zero}
		let width = context.containerSize.width

		if index == 0 {
			return CGSize(width: width, height: FrequentItemSummaryCell.cellHeight)
		} else {
			return CGSize(width: width, height: FrequentItemDetailCell.cellHeight)
		}
	}

	override func didSelectItem(at index: Int) {
		print("Did Select Item at: \(index)")
		expanded = !expanded
		collectionContext?.performBatch(animated: true, updates: { batchContext in
			batchContext.reload(self)
		})
	}
}



