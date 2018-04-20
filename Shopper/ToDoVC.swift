//
//  ToDoVC.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import UIKit
import Stevia

class ToDoVC: UIViewController {

	var v = ToDoView()
	var fab: FloatingAddButton!
	
	override func loadView() {
		view = v
	}

	// We need to store an array of ToDo's
	var toDos = [ToDo]()

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Shopping List"

		v.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
		v.tableView.dataSource = self
		// And we fetch the ToDos.
		refresh()

		fab = FloatingAddButton(color: UIColor.lightBlue){
			self.viewTapped()
		}
		view.sv(fab)
		view.layout(
			(>=10),
			|-(>=10)-fab-24-|,
			24
		)
		fab?.show()
	}

	override func viewDidLayoutSubviews() { // This seems a bit messy
		fab.layoutLayers()
	}

	@objc
	func refresh() {
		ToDo.fetchToDos().then { fetchedToDos in
				self.toDos = fetchedToDos.filter() { isIncluded in
					return isIncluded.category == "Shopping"
				}
			}.onError { e in
				// An error occured :/
				print(e)
			}.finally {
				// In any case, reload the tableView
				self.toDos.sort() { lhs, rhs in
					return (lhs.done != rhs.done) && lhs.done == "false"
				}
				self.v.tableView.reloadData()
				self.v.refreshControl.endRefreshing()
		}
	}

	private func viewTapped() {
		print("Tapped!")
		let itemToSave = ToDo(category: "Shopping", description: "beers", done: "false")
		itemToSave.save().then() {_ in 
			self.refresh() // Refresh to get the new item
			}.onError { e in
			// An error occured :/
			print(e)
		}
		fab?.hide()
		fab?.show()
	}
}

extension ToDoVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return toDos.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoCell {
			let toDo = toDos[indexPath.row]
			cell.render(with: toDo)
			return cell
		}
		return UITableViewCell()
	}
}

