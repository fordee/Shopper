//
//  EditAisleView.swift
//  Shopper
//
//  Created by John Forde on 13/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia
import IGListKit

class EditAisleView: UIView {

	let closeButton = UIButton()
	let listView = ListCollectionView(frame: CGRect.zero, listCollectionViewLayout: ListCollectionViewLayout(stickyHeaders: true, scrollDirection: .vertical, topContentInset: 0, stretchToEdge: true))

	convenience init() {
		self.init(frame: CGRect.zero)
		render()
	}

	func render() {
		// Here we use Stevia to make our constraints more readable and maintainable.
		sv(closeButton.style { b in
			b.backgroundColor = UIColor.darkGray
			b.setTitleColor(UIColor.textColor, for: .normal)
			b.titleLabel?.font = UIFont.backButtonFont
			b.text("Close")
		},
			listView)

		backgroundColor = UIColor.darkGray
		listView.backgroundColor = UIColor.darkGray

		layout(50,
					 |-(>=16)-closeButton-16-|,
					 8,
					 |-listView-|,
					 8)
	}
}
