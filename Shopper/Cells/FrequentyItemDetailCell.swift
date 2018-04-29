//
//  FrequentyItemDetailCell.swift
//  Shopper
//
//  Created by John Forde on 29/4/18.
//  Copyright © 2018 freshOS. All rights reserved.
//

import Stevia

class FrequentItemDetailCell: UICollectionViewCell {

	var numberOfItemsLabel = UILabel()
	var categoryLabel = UILabel()
	var categoryButton = UIButton()
	var deleteButton = UIButton()

	var category: String = "No Category" {
		didSet {
			setButtonText(category, on: categoryButton)
		}
	}
	var shoppingItem: String = ""
	var frequency: String = "1" {
		didSet {
			numberOfItemsLabel.text = "Frequency: \(frequency)"
		}
	}


	static var cellHeight: CGFloat {
		let height: CGFloat = 30
		print("Height: \(height)")
		return height
	}

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(frame: CGRect) {
		super.init(frame: frame)
		// Configure visual elements of cell
		backgroundColor = UIColor.white

		categoryLabel.text = "Category"

		sv(numberOfItemsLabel.style{ label in
				label.font = UIFont.detailFont
				label.text = "Frequecy: 1 "
			},
			categoryLabel.style { label in
				label.font = UIFont.detailFont
				//label.textColor = UIColor(white: 0, alpha: 0.6)
				label.textColor = UIColor.black
				label.numberOfLines = 0
			},
			categoryButton.style { button in
				button.backgroundColor = UIColor(hex6: 0xD81B60)
				button.setTitleColor(UIColor.white, for: .normal)
				button.layer.cornerRadius = 8
				button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
				setButtonText("No Category", on: button)
			},
			deleteButton.style { button in
				button.size(32)
				button.setImage(UIImage(named: "close_icon"), for: .normal)
				button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
			}
		)

		// Layout the cell.
		layout(
			4,
			|-16-numberOfItemsLabel-16-categoryLabel-16-categoryButton-(>=8)-deleteButton-8-|,
			4
		)
	}

	@objc func categoryButtonTapped() {
		let values = Category.all//["Meat", "Alcohol", "Dairy", "Canned Goods", "Produce", "Frozen Goods"]
		DPPickerManager.shared.showPicker(title: "Select a Category", selected: values[0], strings: values) { value, index, cancel in
			if !cancel {
				guard let value = value else { return }
				//self.setButtonText(value, on: self.categoryButton)
				self.category = value // This will set the text on the button as well
				print("Tapped, value: \(value), index: \(index)")
				let item = FrequentItem(shoppingItem: self.shoppingItem, frequency: self.frequency, category: self.category)
				item.save().onError() { e in
					print("Error: \(e)")
				}

			}
		}
	}

	@objc func deleteButtonTapped() {
		print("delete button tapped.")
	}

	private func setButtonText(_ text: String, on button: UIButton, color: UIColor = UIColor.white) {
		let attributedString = NSAttributedString(string: "   \(text)   ", attributes: [.font: UIFont.buttonFont,
																																										.foregroundColor: color,
																																										.underlineStyle: 0])
		button.setAttributedTitle(attributedString, for: .normal)
		button.sizeToFit()
	}
}


