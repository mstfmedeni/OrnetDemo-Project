//
//  AppDelegate.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 24.09.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        setRootController(createNavController(CategorysController.initlizeWithStoryBoard()))
        
        return true
    }
    public func setRootController(_ vc: UIViewController){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window = UIWindow.init(frame: UIScreen.main.bounds)

        if let window = delegate.window {

            window.rootViewController = vc
            window.makeKeyAndVisible()

        }
    }



}

