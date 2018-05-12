//
//  Utility.swift
//  Shopper
//
//  Created by John Forde on 29/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

extension UIColor {
	// https://github.com/yeahdongcn/UIColor-Hex-Swift/blob/master/HEXColor/UIColorExtension.swift
	public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
		let divisor = CGFloat(255)
		let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
		let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
		let blue    = CGFloat( hex6 & 0x0000FF       ) / divisor
		self.init(red: red, green: green, blue: blue, alpha: alpha)
	}

	var brightness: CGFloat {
		var R: CGFloat = 0
		var G: CGFloat = 0
		var B: CGFloat = 0
		var A: CGFloat = 0
		self.getRed(&R, green: &G, blue: &B, alpha: &A)
		let R_sqr = 0.299 * R
		let G_sqr = 0.587 * G
		let B_sqr = 0.114 * B
		let brightness = sqrt( R_sqr + G_sqr + B_sqr )
		return brightness
	}
}

extension UIView {
	func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		self.layer.mask = mask
	}
}

public extension Array {
	func executeIfPresent(_ closure: ([Element]) -> Void) {
		if !isEmpty {
			closure(self)
		}
	}
}

extension String {
	var djb2hash: Int {
		let unicodeScalars = self.unicodeScalars.map { $0.value }
		return unicodeScalars.reduce(5381) {
			($0 << 5) &+ $0 &+ Int($1)
		}
	}

	var sdbmhash: Int {
		let unicodeScalars = self.unicodeScalars.map { $0.value }
		return unicodeScalars.reduce(0) {
			Int($1) &+ ($0 << 6) &+ ($0 << 16) - $0
		}
	}
}
