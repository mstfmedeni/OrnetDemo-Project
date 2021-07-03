import UIKit

fileprivate extension Selector {
    static let endEditingForce = #selector(BaseViewController.endEditingForce)
}

class BaseViewController: UIViewController {

    // MARK: - IBOutlets

    // This constraint ties an element at zero points from the bottom layout guide
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?

    @IBInspectable var isHandleKeyboardLayout: Bool = false

    @IBInspectable var keyboardHeightSpace: CGFloat = 59
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: .endEditingForce)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigatinBarTheme()
        self.setBackButton()

        tapGesture.cancelsTouchesInView = false // Fixes UICollectionView didSelect long press bug inside the views

        self.navigationController?.navigationBar.setBottomBorderColor(color: .blue, height: 1)

        if isHandleKeyboardLayout {
            self.handleKeypadVisibility()
        }

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.title
    }

    // MARK: - Custom Methods

    /// Sets Theme of UINavigationController's navigationBar
    func setNavigatinBarTheme() {
        let font: UIFont = UIFont.systemFont(ofSize: 18, weight: .black)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue, .font: font]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
    }

    /// Sets backbutton of general UINavigationController
    func setBackButton() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        self.navigationController?.navigationBar.backIndicatorImage = UIImage.init(imageLiteralResourceName: "navigationBack")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage.init(imageLiteralResourceName: "navigationBack")
    }

    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @objc func dismissAppend() {
        if self.navigationController  != nil {
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.dismiss(animated: true, completion: nil)

    }


    func removeNavigationBottomLine(`for` color: UIColor? = UIColor.white) {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = color
            navigationBar.isTranslucent = false
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
    }

    /// Handles keypad visibility
    func handleKeypadVisibility() {
        self.view.addGestureRecognizer(tapGesture)

        // Add Notification to handle keyboard selections
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(_:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }

    /// Resigns first responders
    @objc func endEditingForce() {
        self.view.endEditing(true)
    }

    @objc func dismissProcess() {
        self.addAlertAction(title: "Uyarı",
                            message: "Sonlandırmak istediğinize emin misiniz?",
                            cancelTitle: "Vazgeç",
                            defaultTitle: "Sonlandır") { _ in
                                self.dismiss(animated: true, completion: nil)
        }
    }

    // Deinitilaze notification
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    /// Notifies view that keyboard will change frame and sets sticky button's constraint's constants recording it.
    ///
    /// - Parameter notification: NSNotification.Name
    @objc func keyboardNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions().rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = keyboardHeightSpace
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.setNeedsLayout() },
                           completion: nil)
        }
    }

    func addSheetAction(actions: [String: (UIAlertAction) -> Void]? = [:],
                        cancelTitle: String? = nil,
                        defaultAction: ((UIAlertAction) -> Void)? = nil) {
        let alertAction: UIAlertController = UIAlertController(title: nil,
                                                               message: nil,
                                                               preferredStyle: .actionSheet)
        let cancelAction: ((UIAlertAction) -> Void)? = { action in
            alertAction.dismiss(animated: true, completion: nil)
        }
        if cancelTitle != nil {
            alertAction.addAction(UIAlertAction(title: cancelTitle,
                                                style: UIAlertAction.Style.cancel,
                                                handler: cancelAction))
        }

        for action in actions! {
            alertAction.addAction(UIAlertAction(title: action.key,
                                                style: action.key == "İptal Et" ? .destructive : .default,
                                                handler: action.value))
        }

        self.present(alertAction, animated: true, completion: nil)
    }

}
class BaseTableViewController: UITableViewController {



    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigatinBarTheme()
        self.setBackButton()

        self.navigationController?.navigationBar.setBottomBorderColor(color: .blue, height: 1)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.title
    }

    // MARK: - Custom Methods

    /// Sets Theme of UINavigationController's navigationBar
    func setNavigatinBarTheme() {
        let font: UIFont = UIFont.systemFont(ofSize: 18, weight: .black)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue, .font: font]
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        self.navigationController?.navigationBar.isTranslucent = false
    }

    /// Sets backbutton of general UINavigationController
    func setBackButton() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        self.navigationController?.navigationBar.backIndicatorImage = UIImage.init(imageLiteralResourceName: "navigationBack")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage.init(imageLiteralResourceName: "navigationBack")
    }


    func hideBackButton() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @objc func dismissAppend() {
        if self.navigationController  != nil {
            self.navigationController?.popViewController(animated: true)
            return
        }
        self.dismiss(animated: true, completion: nil)

    }

    func removeNavigationBottomLine(`for` color: UIColor? = UIColor.white) {
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.barTintColor = color
            navigationBar.isTranslucent = false
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        }
    }


    @objc func dismissProcess() {
        self.addAlertAction(title: "Uyarı",
                            message: "Sonlandırmak istediğinize emin misiniz?",
                            cancelTitle: "Vazgeç",
                            defaultTitle: "Sonlandır") { _ in
                                self.dismiss(animated: true, completion: nil)
        }
    }


    func addSheetAction(actions: [String: (UIAlertAction) -> Void]? = [:],
                        cancelTitle: String? = nil,
                        defaultAction: ((UIAlertAction) -> Void)? = nil) {
        let alertAction: UIAlertController = UIAlertController(title: nil,
                                                               message: nil,
                                                               preferredStyle: .actionSheet)
        let cancelAction: ((UIAlertAction) -> Void)? = { action in
            alertAction.dismiss(animated: true, completion: nil)
        }
        if cancelTitle != nil {
            alertAction.addAction(UIAlertAction(title: cancelTitle,
                                                style: UIAlertAction.Style.cancel,
                                                handler: cancelAction))
        }

        for action in actions! {
            alertAction.addAction(UIAlertAction(title: action.key,
                                                style: action.key == "İptal Et" ? .destructive : .default,
                                                handler: action.value))
        }

        self.present(alertAction, animated: true, completion: nil)
    }

}
