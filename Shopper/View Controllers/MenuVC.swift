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
															 MenuItem(menuName: "Switch Shop", iconName: "menu_icon"),
															 MenuItem(menuName: "Set Theme", iconName: "menu_icon")]

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.white
		v.tableView.dataSource = self
		v.tableView.delegate = self

		for family in UIFont.familyNames.sorted() {
			let names = UIFont.fontNames(forFamilyName: family)
			print("Family: \(family) Font names: \(names)")
		}
	}

}

extension MenuVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return menuItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell {
			let menuItem = menuItems[indexPath.row]
			cell.render(with: menuItem)
			return cell
		}
		return UITableViewCell()
	}
}

extension MenuVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Menu Item Selected: \(indexPath.row)")
		tableView.deselectRow(at: indexPath, animated: true)
		switch indexPath.row {
		case 0:
			let vc = ShopVC()
			navigationController?.pushViewController(vc, animated: true)
		default:
			break
		}

	}
}
