//
//  AppDelegate.swift
//  EarthQuake
//
//  Created by Layne on 2024/11/7.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

