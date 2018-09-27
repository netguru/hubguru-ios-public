//
// ApplicationDelegate.swift
//
// Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

/// Entry point for the application.
///
/// It should not be accessed from anywhere else except the system, hence the
/// `fileprivate` access modifier.
@UIApplicationMain fileprivate final class AppDelegate: UIResponder, UIApplicationDelegate {

	/// Application's key window. Optional because of protocol requirements.
	@nonobjc fileprivate lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

	/// - SeeAlso: UIApplicationDelegate.application(_:willFinishLaunchingWithOptions:)
    fileprivate func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		guard let window = window else {
			fatalError("There is no way `window` can be `nil` at this point")
		}
		
		window.rootViewController = LoginViewController()
		window.makeKeyAndVisible()

		return true

	}

}
