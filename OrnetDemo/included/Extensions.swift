//
//  Extensions.swift
//  PetSitter
//
//  Created by Mustafa MEDENi on 18.02.2020.
//  Copyright © 2020 Mustafa MEDENi. All rights reserved.
//

import Foundation
import UIKit


protocol Dated {
    var date: Date { get }
}

extension Array where Element: Dated {
    func groupedBy(dateComponents: Set<Calendar.Component>) -> [Date: [Element]] {
        let initial: [Date: [Element]] = [:]
        let groupedByDateComponents = reduce(into: initial) { acc, cur in
            let components = Calendar.current.dateComponents(dateComponents, from: cur.date)
            let date = Calendar.current.date(from: components)!
            let existing = acc[date] ?? []
            acc[date] = existing + [cur]
        }
        
        return groupedByDateComponents
    }
}


extension Date {

    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }

}

// MARK: - UITableView
extension UITableView {
    /// UINib and cell's class identifier name should match. Otherwise it won't work.
    ///
    /// - Parameter identifier: Cell and UINib identifier.
    func registerXib(name identifier:String) {
        self.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    @IBInspectable var footerView: Bool {
          get {
              return false
          } set {
              if newValue {
                  let view = UIView()
                  self.tableFooterView = view
              }
          }
      }
      
}

// MARK: - UINavigationBar
extension UINavigationBar {
    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let navigationSeparator = UIView(frame: CGRect(x: 0, y: frame.height, width: frame.width, height: height))
        navigationSeparator.backgroundColor = color
        navigationSeparator.isOpaque = true
        navigationSeparator.tag = 2000
        if let oldView = self.viewWithTag(2000) {
            oldView.removeFromSuperview()
        }
        self.addSubview(navigationSeparator)
    }
    
    func hideBottomBorder() {
        self.viewWithTag(2000)?.removeFromSuperview()
    }
 
    /// SwifterSwift: Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font
    ///   - color: title text color (default is .black).
    func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        titleTextAttributes = attrs
    }
    
}
// MARK: - UIViewController
extension UIViewController {
  
    /// Present
    ///
    /// - Parameters:
    ///   - title: Title string of alert controller
    ///   - message: Message string of alert controller
    ///   - cancelTitle: Cancel button title string
    ///   - defaultTitle: Default button title string
    ///   - defaultAction: Default action
    ///   - style: alert or sheet
    func presentSingleActionAlert(title: String? = "", message: String? = "", defaultActionTitle: String? = "OK") {
        let alertAction: UIAlertController = UIAlertController(title: title,
                                                               message: message,
                                                               preferredStyle: .alert)
        let defaultAction = UIAlertAction.init(title: defaultActionTitle, style: .default) { _ in
            alertAction.dismiss(animated: true, completion: nil)
        }
        alertAction.addAction(defaultAction)
        self.present(alertAction, animated: true, completion: nil)
    }
    
    func disableSwipeDismiss(){
        if #available(iOS 13.0, *) {
            self.isModalInPresentation = true
        }
    }
    
      /// Adds general action controller; cancel action is dismiss alertcontroller
      ///
      /// - Parameters:
      ///   - title: Title string of alert controller
      ///   - message: Message string of alert controller
      ///   - cancelTitle: Cancel button title string
      ///   - defaultTitle: Default button title string
      ///   - defaultAction: Default action
      ///   - style: alert or sheet
      func addAlertAction(title: String? = "",
                          message: String? = "",
                          cancelTitle: String? = nil,
                          defaultTitle: String? = "",
                          defaultAction: ((UIAlertAction) -> Void)? = nil) {
          DispatchQueue.main.async {
              let alertAction: UIAlertController = UIAlertController(title: title,
                                                                     message: message,
                                                                     preferredStyle: .alert)
              let cancelAction: ((UIAlertAction) -> Void)? = { action in
                  alertAction.dismiss(animated: true, completion: nil)
              }
              if cancelTitle != nil {
                  alertAction.addAction(UIAlertAction(title: cancelTitle,
                                                      style: UIAlertAction.Style.cancel,
                                                      handler: cancelAction))
              }
              alertAction.addAction(UIAlertAction(title: defaultTitle,
                                                  style: UIAlertAction.Style.default,
                                                  handler: defaultAction == nil ? cancelAction : defaultAction))
              
              self.present(alertAction, animated: true, completion: nil)
          }
      }
    
}
// MARK: - Bundle
extension Bundle {
    func getString(of filePath: String?, for type: String? = "json") -> String {
        if let file = self.path(forResource: filePath, ofType: type!) {
            do {
                return try String(contentsOfFile: file)
            } catch {
                return ""
            }
        } else {
            assertionFailure("File does not exist at pointed path")
            return ""
        }
    }
}
extension UIView {
    
    @IBInspectable  var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
           
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UIViewController  {

    class func initlizeWithStoryBoard() -> Self
      {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
        return viewController
    }


}

// MARK: - UIView
extension UIView {
    
    
    @IBInspectable var isRoundedView: Bool {
         get {
             return false // extension default değeri
         } set {
             if newValue  {
                 self.layer.cornerRadius = self.frame.size.height/2
                 self.clipsToBounds = true
             }
         }
     }
    
    @objc func tabla(){
         self.endEditing(true)
     }
     @IBInspectable var AddTapControl: Bool {
         get {
             return false // extension default değeri
         } set {
             if newValue  {
                 let tap = UITapGestureRecognizer()
                 tap.cancelsTouchesInView = false
                 tap.addTarget(self, action: #selector(UIView.tabla))
                 self.addGestureRecognizer(tap)
             }
         }
     }
    
    @IBInspectable var AddBorder: CGFloat {
         get {
            return 0.0
         } set {
             if newValue>0  {
                self.addBorder(with: newValue, color: UIColor(cgColor: self.layer.borderColor ?? UIColor.blue.cgColor) , radius: 5)
             }
         }
     }
    
    /// SwifterSwift: Corner radius of view; also inspectable from Storyboard.
    @IBInspectable  var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    
    
    @IBInspectable var bottomColor: UIColor? {
        get {
            return UIColor.clear
        }
        set {
            
            
            let border = CALayer()
            let width = CGFloat(1.0)
            //frame.size.width/23
            border.frame = CGRect(x: 0, y: frame.size.height - width , width:  frame.size.width+frame.size.width/4, height: frame.size.height)
            border.borderWidth = width
            border.borderColor = newValue?.cgColor
            layer.addSublayer(border)
            layer.masksToBounds = true
        }
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    func fadeIn(completion: ((Bool) -> Void)?) {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
            self.transform = self.transform.scaledBy(x: 2, y: 2)
        }, completion: completion)
    }
    
    func fadeOut(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)
        }, completion: completion)
    }
    
    /// Adds shadows bottom of specific view.
    func addBottomShadow(opacity: Float? = 0.1, size: CGSize? = CGSize(width: 2, height: 2), radius: CGFloat? = 6) {
        self.layer.shadowOpacity = opacity!
        self.layer.shadowOffset = size!
        self.layer.shadowRadius = radius!
    }
    
    /// Adds border
    ///
    /// - Parameters:
    ///   - width: Border Width
    ///   - color: Border Color
    func addBorder(with width: CGFloat? = 1, color: UIColor? = UIColor.blue, radius: CGFloat? = 0) {
        self.clipsToBounds = true
        self.layer.borderWidth = width!
        self.layer.borderColor = color?.cgColor
        self.layer.cornerRadius = radius!
    }
    
    
    /// Rounds view corners
    ///
    /// - Parameters:
    ///   - corners: view corners like .topLeft, .topRight, .bottomLeft, .bottomRight
    ///   - radius: Radius value of corners
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    /// Rounds with dashed pattern of view corners
    ///
    /// - Parameters:
    ///   - corners: view corners like .topLeft, .topRight, .bottomLeft, .bottomRight
    ///   - radius: Radius value of corners
    func dashedRound(corners: UIRectCorner, radius: CGFloat? = 0.0) {
        let viewBorder = CAShapeLayer()
        viewBorder.strokeColor = UIColor.gray.cgColor
        viewBorder.lineDashPattern = [3, 2]
        viewBorder.frame = bounds
        viewBorder.fillColor = nil
        viewBorder.path = UIBezierPath(roundedRect: bounds,
                                       byRoundingCorners: corners,
                                       cornerRadii: CGSize(width: radius!, height: radius!)).cgPath
        self.layer.addSublayer(viewBorder)
    }
}
extension String{
    
    /// Present
    /// - Parameters:
    ///   - title: Title string of alert controller
    ///   - message: Message string of alert controller
    ///   - cancelTitle: Cancel button title string
    ///   - defaultTitle: Default button title string
    ///   - defaultAction: Default action
    ///   - style: alert or sheet
    func presentAsAlert(title: String? = "") {
        let alertAction: UIAlertController = UIAlertController(title: title != "" ? title : "Hata",
                                                               message: self,
                                                               preferredStyle: .alert)
        let defaultAction = UIAlertAction.init(title: "Tamam", style: .default) { _ in
            alertAction.dismiss(animated: true, completion: nil)
        }
        alertAction.addAction(defaultAction)
        
        var viewController = UIViewController()
        
        
        if let vc =  UIApplication.shared.delegate?.window??.rootViewController {
            
            viewController = vc
            var presented = vc
            
            while let top = presented.presentedViewController {
                presented = top
                viewController = top
            }
            
        }else{
            let win = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIViewController()
            vc.view.backgroundColor = .clear
            win.rootViewController = vc
            win.windowLevel = UIWindow.Level.alert + 1
            win.makeKeyAndVisible()
            
        }
        viewController.present(alertAction, animated: true, completion: nil)
        
        
    }
    
    /// Gets height of string according to its supeview.
    ///
    /// - Parameters:
    ///   - width: Widht of label
    ///   - font: Font of label
    /// - Returns: Label height in CGFloat
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    /// Gets width of string according to its supeview.
    ///
    /// - Parameters:
    ///   - height: Height of label
    ///   - font: Font of label
    /// - Returns: Label width in CGFloat
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    /// Checks correction of email
    ///
    /// - Returns: Bool
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
