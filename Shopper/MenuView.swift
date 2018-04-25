//
//  Menu.swift
//  Shopper
//
//  Created by John Forde on 25/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class MenuView: UIView {

	let tableView = UITableView()
	let topImageView = UIImageView(image: UIImage(named: "icon"))

	convenience init() {
		self.init(frame:CGRect.zero)

		// Here we use Stevia to make our constraints more readable and maintainable.
		sv(topImageView,
			tableView)
		backgroundColor = UIColor.white
		tableView.backgroundColor = UIColor.white

		topImageView.height(Dimensions.menuWidth)
		topImageView.contentMode = .scaleToFill
		topImageView.backgroundColor = UIColor.purple

		layout(0,
					 |topImageView|,
					 0,
					 |tableView|,
					 0)
		//tableView.fillContainer()

		// Configure Tablview
		tableView.separatorColor = UIColor.white
		tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell") // Use ToDoCell
		tableView.estimatedRowHeight = 50 // Enable self-sizing cells
	}
}
