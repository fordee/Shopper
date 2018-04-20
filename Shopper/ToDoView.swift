//
//  ToDoView.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Stevia

// This is our custom View.
// This is what replaces the heavy xml Storyboard file when you dev views in code.

// Get the full documentation at https://github.com/freshOS/Stevia

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

