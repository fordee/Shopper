//
//  Animation.swift
//  Shopper
//
//  Created by John Forde on 24/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//
import UIKit
/// Animation protocol defines the initial transform for a view for it to
/// animate to its identity position.
public protocol Animation {

	/// Defines the starting point for the animations.
	var initialTransform: CGAffineTransform { get }
}

