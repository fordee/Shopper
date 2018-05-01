//
//  AppDelegate.swift
//  StarterProject
//
//  Copyright © 2017 4DWare. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		api = WSApi()

		let navigationBarAppearance = UINavigationBar.appearance()
		let barButtonItemAppearance = UIBarButtonItem.appearance()

		navigationBarAppearance.prefersLargeTitles = false
		navigationBarAppearance.barTintColor = UIColor.themeColor
		navigationBarAppearance.tintColor = UIColor.textColor


		window = UIWindow(frame: UIScreen.main.bounds)

		let navController = UINavigationController(rootViewController: ToDoVC())
		navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor, .font: UIFont.titleFont] // This is weirdly difficult to set a basic color
		barButtonItemAppearance.setTitleTextAttributes([.foregroundColor: UIColor.textColor, .font: UIFont.backButtonFont], for: .normal)
		navController.navigationBar.barStyle = .blackTranslucent

		window?.rootViewController = navController
		window?.makeKeyAndVisible()
		return true
	}

}

