//
//  ControllerBuilder.swift
//  OrnetDemo
//
//  Created by Mustafa MEDENi on 25.09.2020.
//

import UIKit


final class ControllerBuilder {

    public static func make<T>(_ vc:T) -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let viewController = storyboard.instantiateViewController(withIdentifier: (String(describing: T.self))) as! T
            return viewController

    }
}

