//
//  FloatingAddButton.swift
//  Shopper
//
//  Created by John Forde on 17/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit
import Stevia

class FloatingAddButton: UIControl {

	// MARK: Public constants
	let controlWidth: CGFloat = 54
	let controlHeight: CGFloat = 54

	let plusWidth: CGFloat = 4
	let plusInset: CGFloat = 10
	let padding: CGFloat = 20

	// MARK: Private variables
	private var controlColor: UIColor = UIColor.red
	private var completion: (() -> Void)?

	private lazy var controlBackgroundLayer: CAShapeLayer = {
		let layer = CAShapeLayer()
		layer.contentsScale = UIScreen.main.scale
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
		layer.shadowOpacity = 0.3
		layer.masksToBounds = false
		layer.anchorPoint = CGPoint(x: 0, y: 0)

		return layer
	}()

	private lazy var controlForeground1Layer: CAShapeLayer = {
		let layer = CAShapeLayer()
		layer.contentsScale = UIScreen.main.scale
		layer.backgroundColor = UIColor.clear.cgColor
		layer.fillColor = UIColor.white.cgColor
		layer.path = CGPath(roundedRect: CGRect(x: (controlWidth / 2) - (plusWidth / 2), y: plusInset, width: plusWidth, height: controlHeight - (plusInset * 2)), cornerWidth: (plusWidth / 2), cornerHeight: (plusWidth / 2), transform: nil)
		layer.anchorPoint = CGPoint(x: 0, y: 0)
		return layer
	}()

	private lazy var controlForeground2Layer: CAShapeLayer = {
		let layer = CAShapeLayer()
		layer.contentsScale = UIScreen.main.scale
		layer.backgroundColor = UIColor.clear.cgColor
		layer.fillColor = UIColor.white.cgColor
		layer.path = CGPath(roundedRect: CGRect(x: plusInset, y: (controlHeight / 2) - (plusWidth / 2), width: controlWidth - (plusInset * 2), height: plusWidth), cornerWidth: (plusWidth / 2), cornerHeight: (plusWidth / 2), transform: nil)
		layer.anchorPoint = CGPoint(x: 0, y: 0)
		return layer
	}()

	// MARK: init()
	init(color: UIColor = UIColor.red, completion: (() -> Void)?) {
		super.init(frame: .zero)
		self.controlColor = color
		self.completion = completion

		addTarget(self, action: #selector(onTouch), for: .touchUpInside)
		isUserInteractionEnabled = true

		width(controlWidth)
		height(controlHeight)

		controlBackgroundLayer.backgroundColor = controlColor.cgColor
		addLayersToControl()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Overrides
	override func layoutSubviews() { // This is required, because before this is called bounds is all zeros
		super.layoutSubviews()
		layoutLayers()
	}

	@objc func onTouch(sender: UIButton) {
		print("You tapped button")
		completion?()
	}

	// MARK: Public functions
	func show() {
		alpha = 0
		transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

		UIView.animate(withDuration: 0.3, delay: 0.5, usingSpringWithDamping: 0.7,
									 initialSpringVelocity: 0.5, options: [], animations: {
										self.alpha = 1
										self.transform = CGAffineTransform.identity
		},
									 completion: nil)
	}

	func hide() {
		UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7,
									 initialSpringVelocity: 0.5, options: [], animations: {
										self.alpha = 0
										self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
		},
									 completion: nil)
	}

	func removeControl() {
		removeFromSuperview()
	}

	// MARK: Private functions
	private func layoutLayers() {
		for l in [controlBackgroundLayer, controlForeground1Layer, controlForeground2Layer] {
			l.bounds = bounds
		}
		controlBackgroundLayer.cornerRadius = bounds.width / 2
	}

	private func addLayersToControl() {
		for l in [controlBackgroundLayer, controlForeground1Layer, controlForeground2Layer] {
			layer.addSublayer(l)
		}
	}
}

