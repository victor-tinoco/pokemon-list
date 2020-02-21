//
//  AppDelegate.swift
//  clean-code-init
//
//  Created by Victor Martins Tinoco - VTN on 12/02/20.
//  Copyright © 2020 tinoco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.rootViewController = InitialViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

