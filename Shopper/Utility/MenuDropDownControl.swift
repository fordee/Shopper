//
//  MenuDropDownControl.swift
//  Shopper
//
//  Created by John Forde on 17/5/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit
import Stevia

class MenuDropDownControl: UIControl {

	// MARK: Public variables
	var isShopSelectMode = false
	var shopName: String = "" {
		didSet {
			shopTextLayer.string = shopName
		}
	}
	var completion: (()->())?

	// MARK: Private variables
	private let buttonWidth  : CGFloat = 35
	private let buttonHeight : CGFloat = 35
	private let padding: CGFloat = 4
	private var controlColor: UIColor = UIColor.red


	private lazy var controlBackgroundLayer : CAShapeLayer = {
		let layer = CAShapeLayer()
		layer.contentsScale = UIScreen.main.scale
		layer.masksToBounds = false
		layer.anchorPoint = CGPoint(x: 0, y: 0)
		return layer
	}()

	private lazy var shopTextLayer: CATextLayer = {
		let layer = CATextLayer()
		layer.alignmentMode = kCAAlignmentLeft
		layer.isWrapped = true
		layer.foregroundColor = UIColor.white.cgColor
		layer.font = UIFont.buttonFont
		layer.fontSize = 14
		layer.anchorPoint = CGPoint(x: 0, y: 0)
		return layer
	}()

	private lazy var controlButtonForegroundLayer : CAShapeLayer = {
		let layer = CAShapeLayer()
		layer.contentsScale = UIScreen.main.scale
		layer.masksToBounds = false
		layer.anchorPoint = CGPoint(x: 0, y: 0)
		var polygonPath = UIBezierPath()
		let x1 = 1.48684 * buttonWidth/3; let y1 = 0.42424 * buttonHeight/3 + 6
		polygonPath.move(to: CGPoint(x: x1, y: y1))
		let x2 = 1.98823 * buttonWidth/3; let y2 = 1.42424 * buttonHeight/3 + 4
		polygonPath.addLine(to: CGPoint(x: x2, y: y2))
		let x3 = 0.98546 * buttonWidth/3; let y3 = 1.42424 * buttonHeight/3 + 4
		polygonPath.addLine(to: CGPoint(x: x3, y: y3))
		polygonPath.fill()
		polygonPath.close()
		layer.path = polygonPath.cgPath
		layer.fillColor = UIColor.white.cgColor

		return layer
	}()

	// MARK: init()
	init(color: UIColor = UIColor.red,  completion: (()->())? = nil) {
		super.init(frame: .zero)
		self.controlColor = color
		self.completion = completion

		let tapGR = UITapGestureRecognizer(target: self, action: #selector(onTap))
		addGestureRecognizer(tapGR)
		isUserInteractionEnabled = true

		controlBackgroundLayer.backgroundColor = controlColor.cgColor
		controlButtonForegroundLayer.backgroundColor = controlColor.cgColor
		shopTextLayer.backgroundColor = controlColor.cgColor
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

	@objc func onTap(sender: UITapGestureRecognizer) {
		if sender.state == .ended && isButtonTapped(sender) {
			flashButton()
			completion?()
		}
	}

	func removeControl() {
		removeFromSuperview()
	}

	func flashButton() {
		let groupAnimation = CAAnimationGroup()
		groupAnimation.beginTime = CACurrentMediaTime()
		groupAnimation.duration = 0.3
		groupAnimation.fillMode = kCAFillModeBoth
		groupAnimation.isRemovedOnCompletion = false

		let rotate = CABasicAnimation(keyPath: "transform.rotation")
		rotate.fromValue = isShopSelectMode ? 0: CGFloat.pi
		rotate.toValue = isShopSelectMode ? CGFloat.pi : 0.0
		rotate.isRemovedOnCompletion = false
		rotate.fillMode = kCAFillModeBoth

		let flashWhite = CABasicAnimation(keyPath: "backgroundColor")
		flashWhite.fillMode = kCAFillModeBoth
		flashWhite.fromValue = controlColor.cgColor
		flashWhite.toValue = UIColor(white: 0.8, alpha: 0.8).cgColor
		flashWhite.duration = 0.15
		flashWhite.isRemovedOnCompletion = false
		flashWhite.autoreverses = true

		groupAnimation.animations = [rotate, flashWhite]

		controlButtonForegroundLayer.add(groupAnimation, forKey: nil)
		isShopSelectMode = !isShopSelectMode
	}

	// MARK: Private functions
	private func layoutLayers() {
		for l in [controlBackgroundLayer, controlButtonForegroundLayer, shopTextLayer]  {
			l.bounds = bounds
		}
		controlButtonForegroundLayer.frame = CGRect(x: bounds.maxX - buttonWidth, y: bounds.maxY - buttonHeight , width: buttonWidth, height: buttonHeight)
		controlButtonForegroundLayer.cornerRadius = buttonHeight / 2

		controlButtonForegroundLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)											// Our original triangle is drawn pointing up.
		controlButtonForegroundLayer.transform = CATransform3DMakeRotation(CGFloat.pi, 0, 0, 1)	// We want it facing down.

		shopTextLayer.frame = CGRect(x: padding, y: 20, width: bounds.width - buttonWidth - (padding * 2), height: buttonHeight)
	}

	private func addLayersToControl() {
		for l in [controlBackgroundLayer, controlButtonForegroundLayer, shopTextLayer]  {
			layer.addSublayer(l)
		}
	}

	private func isButtonTapped(_ tapGR: UITapGestureRecognizer) -> Bool {
		let touchLocation = tapGR.location(ofTouch: 0, in: self)
		if touchLocation.x > controlButtonForegroundLayer.frame.origin.x && touchLocation.y > controlButtonForegroundLayer.frame.origin.y {
			return true
		}
		return false
	}

}
