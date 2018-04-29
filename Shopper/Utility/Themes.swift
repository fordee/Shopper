//
//  Colors.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

extension UIColor {
	static var lightYellow:	UIColor { return UIColor(red:0.988, green:0.988, blue:0.8, alpha:1.0)	}
	static var lightBlue:		UIColor {	return UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)	}
}

extension UIFont {
	static var titleFont: UIFont { return UIFont(name: "Roboto-Regular", size: 22)! }
	static var backButtonFont: UIFont { return UIFont(name: "Roboto-Regular", size: 16)! }
	static var mainFont: UIFont { return UIFont(name: "Roboto-Regular", size: 20)! }
	static var menuFont: UIFont { return UIFont(name: "Roboto-Regular", size: 14)! }
	static var detailFont: UIFont { return UIFont(name: "Roboto-Regular", size: 12)! }
	static var buttonFont: UIFont { return UIFont(name: "Roboto-Bold", size: 12)! }

//	static var mainFont: UIFont { return UIFont(name: "AppleGothic", size: 18)! }
}
