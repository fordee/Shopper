//
//  AppDelegate.swift
//  StarterProject
//
//  Created by Sacha Durand Saint Omer on 30/01/2017.
//  Copyright © 2017 freshOS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		api = WSApi()

		let navigationBarAppearace = UINavigationBar.appearance()

		navigationBarAppearace.prefersLargeTitles = true
		//navigationBarAppearace.tintColor  = UIColor.lightBlue
		navigationBarAppearace.barTintColor = UIColor.lightYellow

		window = UIWindow(frame: UIScreen.main.bounds)
		let navController = UINavigationController(rootViewController: ToDoVC())
		navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.blue, .font: UIFont(name: "AmericanTypewriter-Bold", size: 28)!]
		navController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue, .font: UIFont(name: "AmericanTypewriter-Bold", size: 18)!] // This is weirdly difficult to set a basic color
		window?.rootViewController = navController
		window?.makeKeyAndVisible()
		return true
	}
}

