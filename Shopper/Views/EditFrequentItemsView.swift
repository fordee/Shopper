//
//  EditFrequentItemsView.swift
//  Shopper
//
//  Created by John Forde on 27/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia
import IGListKit

class EditFrequentItemsView: UIView {

	let listView = ListCollectionView(frame: CGRect.zero, listCollectionViewLayout: ListCollectionViewLayout(stickyHeaders: true, scrollDirection: .vertical, topContentInset: 0, stretchToEdge: true))

	let filterControl = UISegmentedControl(items: ["All", "No Category"])

	convenience init() {
		self.init(frame:CGRect.zero)
		backgroundColor = UIColor.white
		
		

		// Here we use Stevia to make our constraints more readable and maintainable.
		sv(filterControl,
			 listView)
		listView.backgroundColor = UIColor.darkGray

		filterControl.backgroundColor = UIColor.white
		filterControl.tintColor = UIColor.themeColor
		layout(54,
					 filterControl.centerHorizontally().height(30),
					 8,
					 |listView|,
					 0)

		filterControl.selectedSegmentIndex = 0

	}
	
}
