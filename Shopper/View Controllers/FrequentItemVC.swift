//
//  frequentItemVC.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit
import IGListKit

protocol FrequentItemDelegate: class {
	func frequentItemDelete(item: FrequentItem)
}

class FrequentItemVC: UIViewController {

	let v = EditFrequentItemsView()
	var filterSelection = false
	var frequentItemDataSource = CategorizedItemsDataSource.categorizedItems
	weak var delegate: FrequentItemDelegate?

	lazy var adapter: ListAdapter = {
		return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
	}()

	override func loadView() {
		view = v
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(refreshFrequentItems), name: .refreshFrequentItems, object: nil)

		adapter.collectionView = v.listView
		adapter.dataSource = self

		v.filterControl.addTarget(self, action: #selector(filterListView), for: .valueChanged)

		CategorizedItemsDataSource.refresh()
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	@objc func filterListView() {
		filterSelection = v.filterControl.selectedSegmentIndex == 1
		adapter.reloadData(completion: nil)
	}

	@objc func refreshFrequentItems(_ notification: Notification) {
		adapter.performUpdates(animated: true)
	}
}

// MARK: List Adapter Data Source
extension FrequentItemVC: ListAdapterDataSource {
	func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
		return CategorizedItemsDataSource.categorizedItems.sorted { lhs, rhs in
			return lhs.category < rhs.category
		}.filter { item in
			return filterSelection ? item.category == "No Category" : true //.category == "" || item.category == "No Category") : true
		}
	}

	func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
		let sc = FrequentItemsSectionController()
		sc.delegate = self
		return sc
	}

	func emptyView(for listAdapter: ListAdapter) -> UIView? {
		return nil
	}
}

// MARK: Frequent Item Delegate
extension FrequentItemVC: FrequentItemDelegate {
	func frequentItemDelete(item: FrequentItem) {
		let alert = UIAlertController(title: "Delete Frequent Item?",
																	message: "Do you really want to delete item: \(item.shoppingItem)?",
																	preferredStyle: .alert)
		let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .destructive) { _ in
			CategorizedItemsDataSource.deleteItem(item)
		}
		let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
}
