//
//  AnimationType.swift
//  Shopper
//
//  Created by John Forde on 24/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit
/// AnimationType available to perform/
///
/// - from: Animation with direction and distance.
/// - zoom: Zoom animation.
/// - rotate: Rotation animation.
public enum AnimationType: Animation {

	case from(direction: Direction, offset: CGFloat)
	case zoom(scale: CGFloat)
	case rotate(angle: CGFloat)

	/// Creates the corresponding CGAffineTransform for AnimationType.from.
	public var initialTransform: CGAffineTransform {
		switch self {
		case .from(let direction, let offset):
			let sign = direction.sign
			if direction.isVertical { return CGAffineTransform(translationX: 0, y: offset * sign) }
			return CGAffineTransform(translationX: offset * sign, y: 0)
		case .zoom(let scale):
			return CGAffineTransform(scaleX: scale, y: scale)
		case .rotate(let angle):
			return CGAffineTransform(rotationAngle: angle)
		}
	}
}
