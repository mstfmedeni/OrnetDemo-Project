//
//  Functions.swift
//  PetSitter
//
//  Created by Mustafa MEDENi on 19.02.2020.
//  Copyright © 2020 Mustafa MEDENi. All rights reserved.
//

import Foundation
import UIKit



public func checkTextFieldsIsNull(textFields: [UITextField]) -> Bool{
    
    for item in textFields {
        
        if (item.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! {
            
            return true
        }
    }
    return false
    
}
// Helper function inserted by Swift 4.2 migrator.
public func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
public func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

public func getActiveController() -> UIViewController {
    
    var viewController = UIViewController()
    
    if let vc =  UIApplication.shared.delegate?.window??.rootViewController {
        
        viewController = vc
        var presented = vc
        
        while let top = presented.presentedViewController {
            presented = top
            viewController = top
        }
    }
    return viewController
}

public func setRootController(_ vc: UIViewController){
    let delegate = UIApplication.shared.delegate as! AppDelegate
    delegate.window = UIWindow.init(frame: UIScreen.main.bounds)

    if let window = delegate.window {
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                           duration: 0.3,
                           options: .transitionCrossDissolve,
                           animations: nil,
                           completion: nil)
    }
}

public func createNavController(_ vc: UIViewController) -> UINavigationController {
    let viewController = vc
    let navController:UINavigationController = UINavigationController(rootViewController: viewController)
    navController.modalPresentationStyle = .fullScreen
  /*  navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navController.navigationBar.shadowImage = UIImage()
    navController.navigationBar.isTranslucent = true
    navController.view.backgroundColor = UIColor.clear
    navController.navigationBar.tintColor = UIColor.white*/
   // navController.navigationBar.setTitleFont(Fonts.Regular.of(size: 21), color: UIColor.white)
   
    return navController
}


