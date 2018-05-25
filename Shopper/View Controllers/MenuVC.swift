//
//  MenuVC.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

	var v = MenuView()

	override func loadView() {
		view = v
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	// We need to store an array of MenuItems
	var menuItems: [MenuItem] = [MenuItem(menuName: "Edit Frequent Items", iconName: "menu_icon"),
															 MenuItem(menuName: "Edit Shops", iconName: "menu_icon"),
															 MenuItem(menuName: "Set Theme", iconName: "menu_icon")]

	var shops: [Shop] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		NotificationCenter.default.addObserver(self, selector: #selector(refreshShops), name: .refreshShops, object: nil)

		view.backgroundColor = UIColor.white
		v.menuTableView.dataSource = self
		v.menuTableView.delegate = self

		v.shopTableView.dataSource = self
		v.shopTableView.delegate = self

		v.selectorControl.isShopSelectMode = false
		v.selectorControl.shopName = Shop.currentShopName ?? ""
		v.selectorControl.completion = {
			print("tapped...")
			self.v.collapse = !self.v.collapse
		}

//		for family in UIFont.familyNames.sorted() {
//			let names = UIFont.fontNames(forFamilyName: family)
//			print("Family: \(family) Font names: \(names)")
//		}
	}

	@objc func refreshShops() {
		shops = ShopsDataSource.shops
		DispatchQueue.main.async {
			self.v.shopTableView.reloadData()
		}
	}

}

// MARK: Table View Data Source
extension MenuVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == v.menuTableView {
			return menuItems.count
		}

		if tableView == v.shopTableView {
			return shops.count
		}
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if tableView == v.shopTableView {
			if let cell = tableView.dequeueReusableCell(withIdentifier: "ShopMenuCell", for: indexPath) as? ShopMenuCell {
				let shop = shops[indexPath.row]
				cell.render(with: shop)
				return cell
			}
		}

		if tableView == v.menuTableView {

			if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell {
				let menuItem = menuItems[indexPath.row]
				cell.render(with: menuItem)
				return cell
			}
		}
		return UITableViewCell()
	}
}

// MARK: Table View Delegate
extension MenuVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableView == v.menuTableView {
			print("Menu Item Selected: \(indexPath.row)")
			tableView.deselectRow(at: indexPath, animated: true)
			switch indexPath.row {
			case 0:
				let vc = FrequentItemVC()
				navigationController?.pushViewController(vc, animated: true)
			case 1:
				let vc = ShopVC()
				navigationController?.pushViewController(vc, animated: true)
			default:
				break
			}
		}
		if tableView == v.shopTableView {
			v.selectShop(shopName: shops[indexPath.row].name)
			tableView.deselectRow(at: indexPath, animated: true)
			Shop.currentShopName = shops[indexPath.row].name
			NotificationCenter.default.post(name: .refreshShops, object: nil, userInfo: ["animated": false])
			self.dismiss(animated: true)
		}
	}
}
