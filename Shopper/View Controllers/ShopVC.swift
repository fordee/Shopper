//
//  ShopVC.swift
//  Shopper
//
//  Created by John Forde on 12/5/18.
//  Copyright © 2018 4Dware. All rights reserved.
//

import UIKit
import IGListKit

protocol ShopDelegate: class {
	//func shopDidUpdateMessages()
	func aisleDelete(shop: Shop, aisle: Aisle)
	func aisleEdit(shop: Shop, aisle: Aisle)
	func aisleAdd(shop: Shop)
}

class ShopVC: UIViewController {
	let v = ShopView()
	var shopDataSource = ShopsDataSource.shops
	var editAisleVC: EditAisleVC? = nil

	lazy var adapter: ListAdapter = {
		return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
	}()

	override func loadView() {
		view = v
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Add button
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

		// Setup IGListView Adapter
		adapter.collectionView = v.listView
		adapter.dataSource = self

		// Setup Data Source
		ShopsDataSource.refresh()

		// Setup Notification Observer
		NotificationCenter.default.addObserver(self, selector: #selector(shopDidUpdateMessages), name: .refreshShops, object: nil)
	}

	override var prefersStatusBarHidden: Bool {
		return true
	}

	@objc private func addButtonTapped() {
		print("Add button tapped.")
		shopAdd()
	}

	@objc private func closeButtonTapped() {
		print("Close button tapped.")
		editAisleVC?.dismiss(animated: true, completion: nil)
	}

	private func shopAdd() {
		print("Shop Add")
		let alert = UIAlertController(title: "New Shop", message: "Add a new Shop", preferredStyle: .alert)
		alert.addTextField { textField in
			textField.borderStyle = .roundedRect
			textField.placeholder("Shop Name")
			textField.keyboardType = .alphabet
			textField.autocapitalizationType = .words
			textField.returnKeyType = .done
		}
		let okAction = UIAlertAction(title: "OK", style: .default) { [weak alert] (_) in
			let shopName = alert!.textFields![0].text!
			print("OK: \(shopName)")
			let shop = Shop(name: shopName)
			shop.save().then {_ in
				ShopsDataSource.refresh()
				}.onError { e in
					print(e)
			}
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}

	@objc func shopDidUpdateMessages() {
		adapter.performUpdates(animated: true)
	}

}



// MARK: List Adapter Data Source
extension ShopVC: ListAdapterDataSource {
	func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
		return ShopsDataSource.shops
	}

	func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
		let sc = ShopSectionController()
		sc.delegate = self
		return sc
	}

	func emptyView(for listAdapter: ListAdapter) -> UIView? {
		return nil
	}
}

// MARK: Shop Delegate
extension ShopVC: ShopDelegate {



	func aisleDelete(shop: Shop, aisle: Aisle) {
		let alert = UIAlertController(title: "Delete aisle?",
																	message: "Do you really want to delete aisle: \(aisle.title) for \(shop.name)?",
																	preferredStyle: .alert)
		let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .destructive) { _ in
			print("OK")
			aisle.delete(shop: shop).then {
				ShopsDataSource.refresh()
			}.onError { e in
				print(e)
			}
		}
		let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel"), style: .cancel, handler: nil)
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}

	func aisleEdit(shop: Shop, aisle: Aisle) {
		print("Aisle Edit: \(shop),  \(aisle)")
		editAisleVC = EditAisleVC()
		//editAisleVC?.aisleDataSource = [aisle]
		editAisleVC?.v.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
		editAisleVC?.shop = shop
		editAisleVC?.aisleNumber = aisle.aisleNumber
		editAisleVC?.aisles = [aisle]
		//editAisleVC?.delegate = self
		present(editAisleVC!, animated: true, completion: nil)
	}

	func aisleAdd(shop: Shop) {
		print("Aisle Add: \(shop)")
		let alert = UIAlertController(title: "Add Aisle", message: "Add an Aisle to \(shop.name)", preferredStyle: .alert)
		alert.addTextField { textField in
			textField.borderStyle = .roundedRect
			textField.placeholder("Aisle Number")
			textField.keyboardType = .numbersAndPunctuation
			textField.returnKeyType = .next
		}
		alert.addTextField { textField in
			textField.borderStyle = .roundedRect
			textField.placeholder("Aisle Title")
			textField.keyboardType = .alphabet
			textField.autocapitalizationType = .words
			textField.returnKeyType = .done
		}
		let okAction = UIAlertAction(title: "OK", style: .default) { [weak alert] (_) in
			let aisleNumber = alert!.textFields![0].text!
			let aisleTitle = alert!.textFields![1].text!
			print("OK: \(aisleNumber) \(aisleTitle)")
			let aisle = Aisle(title: aisleTitle, aisleNumber: aisleNumber)
			aisle.save(shop: shop).then {_ in 
				ShopsDataSource.refresh()
				}.onError { e in
					print(e)
			}
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}

}
