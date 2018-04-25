//
//  ToDoVC.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
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

	private var items = [Any?]()
	private let animations = [AnimationType.from(direction: .right, offset: 30.0)]

	override func viewDidLoad() {
		super.viewDidLoad()

		setupBurgerMenu()
		setupVC()
		setupTableView()
		setupFAB()
		refresh()
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	@objc	func refresh() {
		ToDo.fetchToDos().then { fetchedToDos in
			self.toDos = fetchedToDos.filter { toDo in
				return toDo.category == "Shopping"
			}
			}.onError { e in
				print(e)
			}.finally {
				// In any case, reload the tableView
				self.toDos.sort() { lhs, rhs in
					return (lhs.done != rhs.done) && lhs.done == "false"
				}
				//self.v.tableView.reloadData()
				self.items = Array(repeating: nil, count: 20)
				self.v.tableView.reloadData()
				UIView.animate(views: self.v.tableView.visibleCells, animations: self.animations) {

				}
				self.v.refreshControl.endRefreshing()
		}
	}

	@objc func clearItems(sender: Any) {
		let itemsToClear = toDos.filter { toDo in
			return toDo.isDone
		}
		for toDo in itemsToClear {
			if toDo == itemsToClear.last! { // Refresh if this is the last one.
				toDo.delete().then {
					self.refresh()
					}.onError { e in
						print(e)
				}
			} else {
				toDo.delete().onError { e in
					print(e)
				}
			}
		}
	}

	@objc func burgerMenu() {
		present(SideMenuManager.default.menuLeftNavigationController!, animated: true)
	}

	// MARK: Private functions
	private func setupBurgerMenu() {
		let menuVC = MenuVC()
		let leftNavController = UISideMenuNavigationController(rootViewController: menuVC)
		leftNavController.isNavigationBarHidden = true
		let menuManager = SideMenuManager.default
		menuManager.menuLeftNavigationController = leftNavController
		menuManager.menuPresentMode = .menuSlideIn
		menuManager.menuWidth = 150
		menuManager.menuPushStyle = .popWhenPossible
		menuManager.menuAddPanGestureToPresent(toView: navigationController!.navigationBar)
		menuManager.menuAddScreenEdgePanGesturesToPresent(toView: navigationController!.view)
	}

	private func setupVC() {
		title = "Shopping List"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearItems))
		navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "burger_menu"), style: .plain, target: self, action: #selector(burgerMenu))
	}

	private func setupTableView() {
		v.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
		v.tableView.dataSource = self
		v.tableView.delegate = self
	}

	private func setupFAB() {
		// FAB = Floating Action Button
		fab = FloatingAddButton(color: UIColor.blue){
			self.addItemTapped()
		}
		view.sv(fab)
		view.layout(
			(>=10),
			|-(>=10)-fab-24-|,
			24
		)
		fab?.show()
	}

	private func addItemTapped() {
		fab.hide()
		let addItemVC = AddItemVC()
		addItemVC.delegate = self
		present(addItemVC, animated: true)
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

extension ToDoVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		toDos[indexPath.row].toggleDone()
		toDos[indexPath.row].update().then() {_ in
			self.refresh()
			}.onError { e in
				print(e)
		}
	}
}

extension ToDoVC: AddDelegate {
	func addShoppingItem(addViewController: AddItemVC) {
		if let item = addViewController.toDoItem {
			item.save().then() {_ in
				self.refresh()
				}.onError { e in
					print(e)
			}
		}
		fab.show()
	}

	func close(addViewController: AddItemVC) {
		fab.show()
	}
}

