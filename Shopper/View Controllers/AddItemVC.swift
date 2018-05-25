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
	var filterText = ""

	override func loadView() {
		view = v
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	// We need to store an array of frequent items
	var frequentItems: [FrequentItem] = []

	var filteredItems: [FrequentItem] = []

	private var items = [Any?]()
	private let animations = [AnimationType.from(direction: .right, offset: 30.0)]

	override func viewDidLoad() {
		super.viewDidLoad()

		v.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
		v.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
		v.tableView.dataSource = self
		v.tableView.delegate = self
		v.textField.delegate = self
		refresh()
		filteredItems = frequentItems // TODO: Remove
	}

	@objc	func refresh() {
		FrequentItem.fetchFrequentItems().then { fetcheditems in
				self.frequentItems = fetcheditems
			}.onError { e in
				print(e)
			}.finally {
				self.frequentItems.sort { lhs, rhs in
					return lhs.frequencyInt! > rhs.frequencyInt!
				}
				self.items = Array(repeating: nil, count: 20)
				self.filterItems()
				self.v.tableView.reloadData()
				UIView.animate(views: self.v.tableView.visibleCells, animations: self.animations) {
				}
		}
	}
	
	@objc func addButtonTapped() {
		if let text = v.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty {
			toDoItem = ToDo(category: "Shopping", description: text, done: "false", shoppingCategory: "No Category")
		}
		delegate?.addShoppingItem(addViewController: self)
		v.textField.text = ""
		filterText = ""
		filterItems()
		v.tableView.reloadData()

	}

	@objc func closeButtonTapped() {
		delegate?.close(addViewController: self)
		dismiss(animated: true)
	}

	// MARK: Private Functions

	private func filterItems() {
		filteredItems = frequentItems.filter { item in
			if filterText != "" {
				return item.shoppingItem.lowercased().contains(filterText.lowercased())
			} else {
				return true
			}
		}
	}

}

// MARK: UITableViewDataSource

extension AddItemVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredItems.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "FrequentItemCell", for: indexPath) as? FrequentItemCell {
			let frequentItem = filteredItems[indexPath.row]
			cell.render(with: frequentItem)
			return cell
		}
		return UITableViewCell()
	}
}

// MARK: UITableViewDelegate

extension AddItemVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		v.textField.text = filteredItems[indexPath.row].shoppingItem
	}
}

// MARK: UITextFieldDelegate

extension AddItemVC: UITextFieldDelegate {

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		if let text = textField.text, let textRange = Range(range, in: text) {
			filterText = text.replacingCharacters(in: textRange, with: string)
			print("filterText: \(filterText)")
			let oldItems = filteredItems
			filterItems()
			let changes = diff(old: oldItems, new: filteredItems)
			let changesWithIndexPath = IndexPathConverter().convert(changes: changes, section: 0)
			v.tableView.performBatchUpdates({
				internalBatchUpdates(changesWithIndexPath: changesWithIndexPath)
			})
			changesWithIndexPath.replaces.executeIfPresent {
				self.v.tableView.reloadRows(at: $0, with: .none)
			}
			//v.tableView.reloadData()
		}
		return true
	}

	private func internalBatchUpdates(changesWithIndexPath: ChangeWithIndexPath) {
		changesWithIndexPath.deletes.executeIfPresent {
			v.tableView.deleteRows(at: $0, with: .bottom)
		}

		changesWithIndexPath.inserts.executeIfPresent {
			v.tableView.insertRows(at: $0, with: .bottom)
		}

		changesWithIndexPath.moves.executeIfPresent {
			$0.forEach { move in
				v.tableView.moveRow(at: move.from, to: move.to)
			}
		}
	}

}



