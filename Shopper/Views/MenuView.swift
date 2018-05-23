//
//  Menu.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class MenuView: UIView {

	let menuTableView = UITableView()
	let shopTableView = UITableView()
	let topImageView = UIImageView(image: UIImage(named: "icon2"))
	var collapse: Bool = false  {
		didSet {
			var duration = 0.0
			if collapse {
				menuTableView.height(0.0 as CGFloat)
				shopTableView.height(tableViewHeight)
				duration = 0.3
			} else {
				menuTableView.height(tableViewHeight)
				shopTableView.height(0.0 as CGFloat)
				duration = 0.5
			}

			UIView.animate(withDuration: duration) {
				self.layoutIfNeeded()
			}
		}
	}

	let selectorControl = MenuDropDownControl(color: UIColor.themeColor) // No completion set
	var tableViewHeight: CGFloat = 0

	@objc func onTapped() {
		collapse = !collapse
	}

	func selectShop(shopName: String) {
		selectorControl.shopName = shopName
		collapse = !collapse
		selectorControl.flashButton()
	}

	convenience init() {
		self.init(frame:CGRect.zero)

		// Here we use Stevia to make our constraints more readable and maintainable.
		sv(topImageView,
			 selectorControl,
			 menuTableView,
			 shopTableView)
		backgroundColor = UIColor.white
		menuTableView.backgroundColor = UIColor.white

		topImageView.height(Dimensions.menuWidth)
		topImageView.contentMode = .scaleToFill
		//topImageView.backgroundColor = UIColor.purple

		layout(0,
					 |topImageView|,
					 0,
					 |selectorControl.height(60)|,
					 0,
					 |shopTableView.height(0)|,
					 0,
					 |menuTableView|,
					 0)

		// Configure Tablview
		tableViewHeight = UIScreen.main.bounds.height - shopTableView.frame.origin.y
		menuTableView.separatorColor = UIColor.white
		shopTableView.separatorColor = UIColor.white
		
		menuTableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
		menuTableView.estimatedRowHeight = 50 // Enable self-sizing cells

		shopTableView.register(ShopMenuCell.self, forCellReuseIdentifier: "ShopMenuCell") 
		shopTableView.estimatedRowHeight = 50 // Enable self-sizing cells
	}

}
