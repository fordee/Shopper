//
//  EditFrequentItemsView.swift
//  Shopper
//
//  Created by John Forde on 27/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Stevia
import IGListKit

class EditFrequentItemsView: UIView {

	let listView = ListCollectionView(frame: CGRect.zero, listCollectionViewLayout: ListCollectionViewLayout(stickyHeaders: true, scrollDirection: .vertical, topContentInset: 8, stretchToEdge: true))


	convenience init() {
		self.init(frame:CGRect.zero)

		// Here we use Stevia to make our constraints more readable and maintainable.
		sv(listView)
		listView.backgroundColor = UIColor.darkGray
		listView.fillContainer()

		// Configure Collection View
		

	}

	
}
