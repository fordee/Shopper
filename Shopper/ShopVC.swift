//
//  ShopVC.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

class ShopVC: UIViewController {

	let v = ShopView()

	var frequentItems: [FrequentItem] = [] //[FrequentItem(shoppingItem: "butter", frequency: "5"), FrequentItem(shoppingItem: "eggs", frequency: "2"), FrequentItem(shoppingItem: "beer", frequency: "10")]

	override func loadView() {
		view = v
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.lightBlue
		v.tableView.dataSource = self
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	@objc	func refresh() {
		FrequentItem.fetchFrequentItems().then { fetcheditems in
			self.frequentItems = fetcheditems
			}.onError { e in
				print(e)
			}.finally {
				self.frequentItems.sort() { lhs, rhs in
					return lhs.frequencyInt! > rhs.frequencyInt!
				}
			self.v.tableView.reloadData()
		}
	}
}

extension ShopVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return frequentItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "FrequentItemCell", for: indexPath) as? FrequentItemCell {
			let frequentItem = frequentItems[indexPath.row]
			cell.render(with: frequentItem)
			return cell
		}
		return UITableViewCell()
	}
}


