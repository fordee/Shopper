//
//  Colors.swift
//  StarterProject
//
//  Created by John Forde on 15/4/18.
//  Copyright © 2018 4DWare. All rights reserved.
//

import UIKit

extension UIColor {
	static var themeColor:	UIColor { return UIColor(named: "ThemeColor")!	}
	static var lightColor:		UIColor {	return UIColor(named: "LightColor")!	}
	static var darkColor:		UIColor {	return UIColor(named: "DarkColor")!	}
	static var textColor: UIColor { return UIColor.white }
}

extension UIFont {
	static var titleFont: UIFont { return UIFont(name: "Roboto-Bold", size: 22)! }
	static var headerFont: UIFont { return UIFont(name: "Roboto-Bold", size: 18)! }
	static var backButtonFont: UIFont { return UIFont(name: "Roboto-Regular", size: 16)! }
	static var cellFont: UIFont { return UIFont(name: "Roboto-Regular", size: 18)! }
	static var mainFont: UIFont { return UIFont(name: "Roboto-Regular", size: 20)! }
	static var menuFont: UIFont { return UIFont(name: "Roboto-Regular", size: 14)! }
	static var detailFont: UIFont { return UIFont(name: "Roboto-Regular", size: 12)! }
	static var buttonFont: UIFont { return UIFont(name: "Roboto-Bold", size: 12)! }

//	static var mainFont: UIFont { return UIFont(name: "AppleGothic", size: 18)! }
}
