//
//  FrequentItemsSectionController.swift
//  Shopper
//
//  Created by John Forde on 28/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import IGListKit

class FrequentItemsSectionController: ListSectionController, ListSupplementaryViewSource {

	var frequentItem: CategorizedItem!
	var expanded = true
	weak var delegate: FrequentItemDelegate?

	override init() {
		super.init()
		inset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
		minimumInteritemSpacing = 8
		supplementaryViewSource = self
	}

	override func numberOfItems() -> Int {
		return frequentItem.items.count * 2 // 2//expanded ? 2 : 1
	}

	override func didUpdate(to object: Any) {
		frequentItem = object as? CategorizedItem
	}

	override func cellForItem(at index: Int) -> UICollectionViewCell {
		let cellClass: AnyClass = index % 2 == 0 ? FrequentItemSummaryCell.self : FrequentItemDetailCell.self
		let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
		if let cell = cell as? FrequentItemSummaryCell {
			cell.frequentItemLabel.text = frequentItem.items[index / 2].shoppingItem // Change to use render() later
		} else if let cell = cell as? FrequentItemDetailCell {
			cell.delegate = delegate
			cell.shoppingItem = frequentItem.items[index / 2].shoppingItem
			cell.frequency = frequentItem.items[index / 2].frequency
			if frequentItem.category == "" { frequentItem.category = "No Category" }
			cell.category = frequentItem.category
		}
		return cell
	}

	override func sizeForItem(at index: Int) -> CGSize {
		guard let context = collectionContext else { return .zero}
		let width = context.containerSize.width

		if index % 2 == 0 {
			let size =  CGSize(width: width, height: FrequentItemSummaryCell.cellHeight)
			//print("size = \(size)")
			return size
		} else {
			let size = CGSize(width: width, height: FrequentItemDetailCell.cellHeight)
			return size
		}
	}

	override func didSelectItem(at index: Int) {
		print("Did Select Item at: \(index)")
		//expanded = !expanded
		collectionContext?.performBatch(animated: true, updates: { batchContext in
			batchContext.reload(self)
		})
	}

	// MARK: ListSupplementaryViewSource

	func supportedElementKinds() -> [String] {
		return [UICollectionElementKindSectionHeader]
	}

	func viewForSupplementaryElement(ofKind elementKind: String, at index: Int) -> UICollectionReusableView {
		switch elementKind {
		case UICollectionElementKindSectionHeader:
			return userHeaderView(atIndex: index)
		default:
			fatalError()
		}
	}

	func sizeForSupplementaryView(ofKind elementKind: String, at index: Int) -> CGSize {
		return CGSize(width: collectionContext!.containerSize.width, height: 40)
	}

	// MARK: Private
	private func userHeaderView(atIndex index: Int) -> UICollectionReusableView {
		guard let view = collectionContext?.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
																																				 for: self,
																																				 class: CategoryHeaderView.self,
																																				 at: index) as? CategoryHeaderView else {
																																					fatalError()
		}

		view.heading = frequentItem.category//"Test Heading"
		return view
	}
}



