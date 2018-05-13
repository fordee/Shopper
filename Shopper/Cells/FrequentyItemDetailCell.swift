//
//  FrequentyItemDetailCell.swift
//  Shopper
//
//  Created by John Forde on 29/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import Stevia

class FrequentItemDetailCell: UICollectionViewCell {

	var numberOfItemsLabel = UILabel()
	var categoryLabel = UILabel()
	var categoryButton = UIButton()
	var deleteButton = UIButton()

	var spacerLabel  = UILabel()

	var category: String = "No Category" {
		didSet {
			let backgroundColor = category == "No Category" ? UIColor.themeColor : Category.color(for: category)

			let brightness = backgroundColor.brightness
			print("Category: \(category), Brightness: \(brightness)")
			let textColor = brightness > 0.85 ? UIColor.black : UIColor.white // TODO: Make this based on contrast
			categoryButton.backgroundColor = backgroundColor
			setButtonText(category, on: categoryButton, color: textColor)
		}
	}
	var shoppingItem: String = ""
	var frequency: String = "1" {
		didSet {
			numberOfItemsLabel.text = "Frequency: \(frequency)"
		}
	}

	static var cellHeight: CGFloat {
		let height: CGFloat = 30 + 10
		return height
	}

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(frame: CGRect) {
		super.init(frame: frame)
		// Configure visual elements of cell
		backgroundColor = UIColor.white
		//roundCorners([.bottomLeft, .bottomRight], radius: Dimensions.cellRadius)

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
				button.backgroundColor = UIColor.themeColor
				button.setTitleColor(UIColor.textColor, for: .normal)
				button.layer.cornerRadius = 8
				button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
				setButtonText("No Category", on: button)
			},
			deleteButton.style { button in
				button.size(24)
				button.image("delete")
				button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
			},
			spacerLabel.style { label in
				label.height(10)
				label.backgroundColor = UIColor.darkGray
			}
		)

		// Layout the cell.
		layout(
			4,
			|-16-numberOfItemsLabel-16-categoryLabel-16-categoryButton-(>=8)-deleteButton-8-|,
			4,
			|spacerLabel|,
			0
		)
	}

	@objc func categoryButtonTapped() {
		let values = Category.all
		DPPickerManager.shared.showPicker(title: "Select a Category", selected: values[0].name, strings: values.map {$0.name}) { value, index, cancel in
			if !cancel {
				guard let value = value else { return }
				self.category = value // This will set the text on the button as well
				print("Tapped, value: \(value), index: \(index)")
				let item = FrequentItem(shoppingItem: self.shoppingItem, frequency: self.frequency, category: self.category)
				item.save().then { _ in
					CategorizedItemsDataSource.updateItem(item) // TODO: Cahneg to categorized Item Data Source
				}.onError() { e in
					print("Error: \(e)")
				}

			}
		}
	}

	@objc func deleteButtonTapped() {
		print("delete button tapped.")
	}

	private func setButtonText(_ text: String, on button: UIButton, color: UIColor = UIColor.textColor) {
		let attributedString = NSAttributedString(string: "   \(text)   ", attributes: [.font: UIFont.buttonFont,
																																										.foregroundColor: color,
																																										.underlineStyle: 0])
		button.setAttributedTitle(attributedString, for: .normal)
		button.sizeToFit()
	}
}


