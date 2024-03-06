//
//  UIViewController+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIViewController {
    /// Instantiate UIViewController with `storyboard and bundle` values
    /// `ViewController.oy_instantiate(storyboard: "Main", bundle: .main)`
    public static func oy_instantiate(storyboard: String = "Main", bundle: Bundle? = .main) -> Self {
        let storyboard = UIStoryboard(name: storyboard, bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: oy_reuseIdentifier) as? Self else {
            fatalError("\(#function) Cannot instantiate view controller of type \(oy_reuseIdentifier)")
        }
        return viewController
    }

    /// Instantiate UIViewController with `storyboard and bundle` values
    /// `ViewController.oy_instantiateNib(bundle: .main)`
    public static func oy_instantiateNib(bundle: Bundle? = .main) -> Self {
        self.init(nibName: String(describing: oy_reuseIdentifier), bundle: bundle)
    }

    /// `self.oy_present(viewControler: SecondViewController(), transitionStyle: .none) {
    ///     // do stuff
    /// }
    public func oy_present(viewControler: UIViewController, transitionStyle: UIModalTransitionStyle? = nil, completion: (() -> Void)? = nil) {
        if let transitionStyle {
            viewControler.modalTransitionStyle = transitionStyle
        }
        present(viewControler, animated: true, completion: completion)
    }

    /// `self.oy_present(viewControler: SecondViewController(), presentationStyle: .fullScreen) {
    ///     // do stuff
    /// }
    public func oy_present(viewControler: UIViewController, presentationStyle: UIModalPresentationStyle? = nil, onIpad: Bool = false, completion: (() -> Void)? = nil) {
        if let presentationStyle {
            viewControler.modalPresentationStyle = presentationStyle
        }

        guard #available(iOS 13.0, *), viewControler.modalPresentationStyle == .formSheet, onIpad else {
            present(viewControler, animated: true, completion: completion)
            return
        }

        viewControler.preferredContentSize = .init(width: UIScreen.oy_width, height: UIScreen.oy_height - 44)
        present(viewControler, animated: true, completion: completion)
    }

    /// Push ViewController with completion handler
    @objc public func oy_push(viewControler: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.oy_push(viewControler: viewControler, animated: animated, completion: completion)
    }

    /// Pop ViewController with completion handler
    @objc public func oy_pop(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.oy_pop(animated: animated, completion: completion)
    }

    /// Pop to root ViewController with completion handler
    @objc public func oy_popToRoot(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.oy_popToRoot(animated: animated, completion: completion)
    }

    /// Pop to ViewController with completion handler
    @objc public func oy_popTo(viewControler: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.oy_popTo(viewControler: viewControler, animated: animated, completion: completion)
    }

    /// Dismiss ViewController with completion handler
    public func oy_dismiss(completion: (() -> Void)? = nil) {
        dismiss(animated: true, completion: completion)
    }
    
    /// The root view controller for the window
    public static var oy_root: UIViewController? {
        guard let keyWindow = UIApplication.oy_keyWindow, let root = keyWindow.rootViewController else {
            return nil
        }
        return root
    }

    /// Navigation controller of UIViewController
    public var oy_navigationController: UINavigationController? {
        navigationController
    }

    /// Navigation bar of UIViewController
    public var oy_navigationBar: UINavigationBar? {
        navigationController?.navigationBar
    }

    /// Id of UIViewController
    public var oy_id: Int {
        Int(bitPattern: ObjectIdentifier(self))
    }

    /// Dismiss keyboard
    @objc public func oy_dismissKeyboard() {
        view.endEditing(true)
    }

    /// Add keyboard hide gesture
    public func oy_addHideKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.oy_dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    /// Navigation bar height of UIViewController
    public var oy_navigationBarHeight: CGFloat {
        if let navigationController = self as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return visibleViewController.oy_navigationBarHeight
        }
        if let navigationController = self.navigationController {
            return navigationController.navigationBar.frame.oy_height
        }
        return 0
    }

    /// Remove back button title
    public func oy_removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    /// Tab bar height of UIViewController
    public var oy_tabBarHeight: CGFloat {
        if let navigationController = self as? UINavigationController, let visibleViewController = navigationController.visibleViewController {
            return visibleViewController.oy_tabBarHeight
        }
        if let tab = self.tabBarController {
            return tab.tabBar.frame.size.height
        }
        return 0
    }

    /// Add child UIViewController
    public func oy_addChild(viewController: UIViewController, in view: UIView) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    /// Remove child UIViewController
    public func oy_removeChild(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}

// MARK: - Keyboard Extension
extension UIViewController {
    /// Observe `keyboardWillShow`action
    public func oy_addKeyboardWillShowObserver(completion: (() -> Void)?) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(forName: .oy_Keyboard.keyboardWillShowNotification, object: nil, queue: nil) { _ in
            completion?()
        }
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        NotificationCenter.default.post(Notification(name: .oy_Keyboard.keyboardWillShowNotification, object: nil, userInfo: nil))
    }

    /// Observe `keyboardDidShow`action
    public func oy_addKeyboardDidShowObserver(completion: (() -> Void)?) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(forName: .oy_Keyboard.keyboardDidShowNotification, object: nil, queue: nil) { _ in
            completion?()
        }
    }

    @objc private func keyboardDidShow(_ notification: Notification) {
        NotificationCenter.default.post(Notification(name: .oy_Keyboard.keyboardDidShowNotification, object: nil, userInfo: nil))
    }

    /// Observe `keyboardWillHide`action
    public func oy_addKeyboardWillHideObserver(completion: (() -> Void)?) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(forName: .oy_Keyboard.keyboardWillHideNotification, object: nil, queue: nil) { _ in
            completion?()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        NotificationCenter.default.post(Notification(name: .oy_Keyboard.keyboardWillHideNotification, object: nil, userInfo: nil))
    }

    /// Observe `keyboardDidHide`action
    public func oy_addKeyboardDidHideObserver(completion: (() -> Void)?) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(forName: .oy_Keyboard.keyboardDidHideNotification, object: nil, queue: nil) { _ in
            completion?()
        }
    }

    @objc private func keyboardDidHide(_ notification: Notification) {
        NotificationCenter.default.post(Notification(name: .oy_Keyboard.keyboardDidHideNotification, object: nil, userInfo: nil))
    }

    /// Remove all observers for keyboard events
    public func oy_removeKeyboardObservers() {
        [UIResponder.keyboardWillShowNotification,
            UIResponder.keyboardDidShowNotification,
            UIResponder.keyboardWillHideNotification,
            UIResponder.keyboardDidHideNotification,
            Notification.Name.oy_Keyboard.keyboardWillShowNotification,
            Notification.Name.oy_Keyboard.keyboardDidShowNotification,
            Notification.Name.oy_Keyboard.keyboardWillHideNotification,
            Notification.Name.oy_Keyboard.keyboardDidHideNotification].forEach { item in
            NotificationCenter.default.removeObserver(self, name: item, object: nil)
        }
    }
}

extension Notification.Name {
    /// Keyboard events keys
    struct oy_Keyboard {
        static let keyboardWillShowNotification = NSNotification.Name("oy_Keyboard_KeyboardWillShowNotification")
        static let keyboardDidShowNotification = NSNotification.Name("oy_Keyboard_KeyboardDidShowNotification")
        static let keyboardWillHideNotification = NSNotification.Name("oy_Keyboard_KeyboardWillHideNotification")
        static let keyboardDidHideNotification = NSNotification.Name("oy_Keyboard_KeyboardDidHideNotification")
    }
}
