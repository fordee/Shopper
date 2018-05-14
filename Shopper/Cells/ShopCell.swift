//
//  ShopItem.swift
//  Shopper
//
//  Created by John Forde on 12/5/18.
//  Copyright © 2018 4Dware. All rights reserved.
//

import Stevia

class ShopCell: UICollectionViewCell {

	var shop: Shop? {
		didSet {
			if shop!.name.lowercased().range(of: "countdown") != nil {
				logo.image = UIImage(named: "countdown_logo")
			} else if shop!.name.lowercased().range(of: "new world") != nil {
				logo.image = UIImage(named: "new_world_logo")
			}
			shopLabel.text = shop!.name
		}
	}

	var shopLabel = UILabel()
	var logo = UIImageView()
	var addButton = UIButton()
	weak var delegate: ShopDelegate?

	static var cellHeight: CGFloat {
		let height = 20 + UIFont.mainFont.pointSize + 4
		return height
	}

	required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)}

	override init(frame: CGRect) {
		super.init(frame: frame)

		sv(
			logo.style(logoStyle),
			shopLabel.style(shopStyle),
			addButton.style { b in
				b.size(24)
				b.image("add")
				b.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
			}
		)

		// Here we layout the cell.
		layout(
			10,
			|-16-logo-8-shopLabel-(>=16)-addButton-8-|,
			10
		)

		// Configure visual elements
		backgroundColor = UIColor.white
		shopLabel.numberOfLines = 0
	}

	private func shopStyle(l: UILabel) {
		l.font = UIFont.mainFont
		l.textColor = UIColor.black
	}

	private func logoStyle(i: UIImageView) {
		i.contentMode = .scaleAspectFit
	}

	@objc private func addButtonTapped() {
		print("Add Button Tapped")
		if let shop = shop {
			delegate?.aisleAdd(shop: shop)
		}
	}

}
