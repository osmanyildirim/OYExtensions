//
//  UITabBarController+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

extension UITabBarController {
    /// `self.oy_hideOrShowTabBar(isHide: true, animateDuration: 0.5)`
    public func oy_hideOrShowTabBar(isHide: Bool = true, animateDuration: TimeInterval = 0.5) {
        if isHide {
            UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.maxY + self.tabBar.frame.height
                self.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                self?.tabBar.isHidden = isHide
            }
        } else {
            self.tabBar.isHidden = isHide

            UIView.animate(withDuration: animateDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.maxY - self.tabBar.frame.height
                self.view.layoutIfNeeded()
            }
        }
    }

    /// Add tab bar item with `viewController, title, image and selectedImage` values
    func oy_addTabBarItem(viewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage? = nil) {
        let tabBarItem = UITabBarItem(title: title, image: image, selectedImage: selectedImage ?? image)
        viewController.tabBarItem = tabBarItem

        guard viewControllers != nil else {
            viewControllers = [viewController]
            return
        }
        viewControllers?.append(viewController)
    }

    /// Add tab bar item with `viewController, item and tag` values
    func oy_addTabBarItem(viewController: UIViewController, item: UITabBarItem.SystemItem, tag: Int) {
        let tabBarItem = UITabBarItem(tabBarSystemItem: item, tag: tag)
        viewController.tabBarItem = tabBarItem

        guard viewControllers != nil else {
            viewControllers = [viewController]
            return
        }
        viewControllers?.append(viewController)
    }

    /// `self.oy_hideOrShowBottomBarWhenPushed(isHide: true)`
    public func oy_hideOrShowBottomBarWhenPushed(isHide: Bool) {
        hidesBottomBarWhenPushed = isHide
    }
}
