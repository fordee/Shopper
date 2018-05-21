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
	var toDos: [ToDo] = []
	var shops: [Shop] = []
	var shoppingItems: [ShoppingItem] = []

	private var items = [Any?]()
	private let animations = [AnimationType.from(direction: .right, offset: 30.0)]

	override func viewDidLoad() {
		super.viewDidLoad()

		setupBurgerMenu()
		setupVC()
		setupTableView()
		setupFAB()
		refresh()
		ShopsDataSource.refresh()
		NotificationCenter.default.addObserver(self, selector: #selector(refreshShops), name: .refreshShops, object: nil)
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
					if (lhs.done != rhs.done) {
						if lhs.done == "false" {
							return true
						} else {
							return false
						}
					}
					if lhs.shoppingCategory > rhs.shoppingCategory {
						return true
					}
					return false
				}
				if self.shops.count > 0 { // whichever finishes last
					self.refreshShops()
				}
//				self.items = Array(repeating: nil, count: 20)
//				self.v.tableView.reloadData()
//				UIView.animate(views: self.v.tableView.visibleCells, animations: self.animations) {
//				}
				self.v.refreshControl.endRefreshing()
		}
	}

	@objc func refreshShops() {
		shops = ShopsDataSource.shops
		if toDos.count > 0, let currentShopName = Shop.currentShopName {
			shoppingItems = ShoppingItem.getShoppingItems(from: shops, todos: toDos, currentShopName: currentShopName)
			v.tableView.reloadData()
			UIView.animate(views: self.v.tableView.visibleCells, animations: self.animations) {
			}
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
		menuManager.menuWidth = Dimensions.menuWidth
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
		fab = FloatingAddButton(color: UIColor.darkColor){
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

// MARK: TAble View Data Source
extension ToDoVC: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		return shoppingItems.count
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return shoppingItems[section].aisleName
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return shoppingItems[section].toDos.count//toDos.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoCell {
			let toDo = shoppingItems[indexPath.section].toDos[indexPath.row]//toDos[indexPath.row]
			cell.render(with: toDo)
			return cell
		}
		return UITableViewCell()
	}
}

// MARK: Table View Delegate
extension ToDoVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		shoppingItems[indexPath.section].toDos[indexPath.row].toggleDone()
		shoppingItems[indexPath.section].toDos[indexPath.row].update().then() {_ in
			self.refresh()
			}.onError { e in
				print(e)
		}
	}
}

// MARK: Add Delegate
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

