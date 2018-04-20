//
//  ToDoView.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class ToDoView: UIView {

	let refreshControl = UIRefreshControl()
	let tableView = UITableView()

	convenience init() {
		self.init(frame:CGRect.zero)

		// Here we use Stevia to make our constraints more readable and maintainable.
		sv(tableView)
		tableView.backgroundColor = UIColor.lightYellow
		tableView.fillContainer()

		tableView.addSubview(refreshControl)

		// Configure Tablview
		refreshControl.tintColor = UIColor.lightBlue
		tableView.separatorColor = UIColor.lightBlue
		tableView.register(ToDoCell.self, forCellReuseIdentifier: "ToDoCell") // Use ToDoCell
		tableView.estimatedRowHeight = 50 // Enable self-sizing cells
	}
}

