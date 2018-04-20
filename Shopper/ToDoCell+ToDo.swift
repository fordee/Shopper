//
//  ToDoCell+ToDo.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import UIKit

extension ToDoCell {

	func render(with: ToDo) {
		let attributedText = NSMutableAttributedString(string: with.description)
		if with.done == "true" {
			attributedText.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedText.length))
			shoppingItemLabel.alpha = 0.5
		} else {
			attributedText.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 0, range: NSMakeRange(0, attributedText.length))
			shoppingItemLabel.alpha = 1.0
		}
		shoppingItemLabel.attributedText = attributedText
	}

}