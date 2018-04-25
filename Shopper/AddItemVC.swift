//
//  AddItemVC.swift
//  Shopper
//
//  Created by John Forde on 22/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit
import Stevia

protocol AddDelegate {
	func addShoppingItem(addViewController: AddItemVC)
	func close(addViewController: AddItemVC)
}

class AddItemVC: UIViewController {

	var v = AddItemView()

	var toDoItem: ToDo? = nil
	var delegate: AddDelegate?

	override func loadView() {
		view = v
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	// We need to store an array of frequent items
	var frequentItems = [FrequentItem]()

	private var items = [Any?]()
	private let animations = [AnimationType.from(direction: .right, offset: 30.0)]

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = UIColor.lightYellow
		v.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
		v.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
		v.tableView.dataSource = self
		v.tableView.delegate = self
		refresh()

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
				self.items = Array(repeating: nil, count: 20)
				self.v.tableView.reloadData()
				UIView.animate(views: self.v.tableView.visibleCells, animations: self.animations) {
				}
		}
	}
	
	@objc func addButtonTapped() {
		if let text = v.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), text.count > 0 {
			toDoItem = ToDo(category: "Shopping", description: text, done: "false")
		}
		delegate?.addShoppingItem(addViewController: self)
		v.textField.text = ""
	}

	@objc func closeButtonTapped() {
		delegate?.close(addViewController: self)
		dismiss(animated: true)
	}
}

extension AddItemVC: UITableViewDataSource {
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

extension AddItemVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		v.textField.text = frequentItems[indexPath.row].shoppingItem
	}
}
