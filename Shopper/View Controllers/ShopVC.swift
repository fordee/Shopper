//
//  ShopVC.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit
import IGListKit

class ShopVC: UIViewController {

	//let v = ShopView()
	let v = EditFrequentItemsView()

	var filterSelection = false

	var frequentItemDataSource = CategorizedItemsDataSource.categorizedItems//FrequentItemDataSource.frequentItems

	lazy var adapter: ListAdapter = {
		return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
	}()


	override func loadView() {
		view = v
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		adapter.collectionView = v.listView
		adapter.dataSource = self

		v.filterControl.addTarget(self, action: #selector(filterListView), for: .valueChanged)

		CategorizedItemsDataSource.delegate = self//FrequentItemDataSource.delegate = self
		CategorizedItemsDataSource.refresh()//FrequentItemDataSource.refresh()
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	@objc func filterListView() {
		filterSelection = v.filterControl.selectedSegmentIndex == 1
		adapter.reloadData(completion: nil)
	}


}

extension ShopVC: ListAdapterDataSource {
	func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
		return /*FrequentItemDataSource*/CategorizedItemsDataSource.categorizedItems.sorted{ lhs, rhs in
			return lhs.category < rhs.category
		}.filter { item in
			return filterSelection ? item.category == "No Category" : true //.category == "" || item.category == "No Category") : true
		}
	}

	func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
		return FrequentItemsSectionController()
	}

	func emptyView(for listAdapter: ListAdapter) -> UIView? {
		return nil
	}
}

extension ShopVC: FrequentItemDelegate {

	func frequentItemDidUpdateMessages() {
		//adapter.reloadData()
		adapter.performUpdates(animated: true)
	}
}
