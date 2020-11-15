//
//  AppDelegate.swift
//  TMDb Index
//
//  Created by brennobemoura on 14/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        GenresService.shared.load()
        
        return true
    }
}

