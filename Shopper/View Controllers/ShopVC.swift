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

	var frequentItemDataSource = FrequentItemDataSource()//: [FrequentItem] = []//FrequentItem(shoppingItem: "butter", frequency: "5"), FrequentItem(shoppingItem: "eggs", frequency: "2"), FrequentItem(shoppingItem: "beer", frequency: "10")]

	lazy var adapter: ListAdapter = {
		return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
	}()


	override func loadView() {
		view = v
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.lightBlue
		adapter.collectionView = v.listView
		adapter.dataSource = self
		//v.tableView.dataSource = self
		frequentItemDataSource.delegate = self
		frequentItemDataSource.refresh()
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	
	

}

extension ShopVC: ListAdapterDataSource {
	func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
		return frequentItemDataSource.frequentItems
	}

	func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
		return FrequentItemsSectionController()
	}

	func emptyView(for listAdapter: ListAdapter) -> UIView? {
		return nil
	}
}

extension ShopVC: FrequentItemDelegate {

	func frequentItemDidUpdateMessages(frequentItemDataSource: FrequentItemDataSource) {
		adapter.performUpdates(animated: true)
	}


}
