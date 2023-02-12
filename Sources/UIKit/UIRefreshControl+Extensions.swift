//
//  UIRefreshControl+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIRefreshControl: OYInit {
    public typealias ViewType = UIRefreshControl

    /// Set UIRefreshControl to UITableView
    public func oy_set(to tableView: UITableView) {
        tableView.oy_refreshControl = self
    }

    /// Start UIRefreshControl inside of UIScrollView
    /// - Parameters:
    ///   - animated: if the should be animated
    ///   - sendAction: if the should it fire sendActions method for valueChanged UIControlEvents
    public func oy_start(animated: Bool = true, sendAction: Bool = true) {
        guard let scrollView = superview as? UIScrollView else { fatalError("\(#function) UIRefreshControl doesn't belong to UIScrollView") }

        beginRefreshing()
        let offset = CGPoint(x: 0, y: -frame.height)
        scrollView.setContentOffset(offset, animated: animated)

        guard sendAction else { return }
        sendActions(for: .valueChanged)
    }

    /// Start UIRefreshControl inside of UITableView
    /// - Parameters:
    ///   - tableView: UITableView inside which the refresh control is contained.
    ///   - animated: if the should be animated (default is true)
    ///   - sendAction: if the should it fire sendActions method for valueChanged UIControlEvents (default is true)
    public func oy_start(tableView: UITableView, animated: Bool = true, sendAction: Bool = true) {
        guard superview == tableView else { fatalError("\(#function) UIRefreshControl doesn't belong to UITableView") }

        beginRefreshing()
        let offset = CGPoint(x: 0, y: -frame.height)
        tableView.setContentOffset(offset, animated: animated)

        guard sendAction else { return }
        sendActions(for: .valueChanged)
    }

    /// Stop UIRefreshControl refreshing
    public func oy_stop() {
        endRefreshing()
    }

    /// Add action to UIRefreshControl
    /// @available on iOS 14.0
    /// - Parameter action: <#action description#>
    @available(iOS 14.0, *) public func add(action: UIAction) {
        addAction(action, for: .valueChanged)
    }

    /// Bool state of UIRefreshControl's refreshing
    public var oy_isRefreshing: Bool {
        isRefreshing
    }

    /// Tint color of UIRefreshControl
    public var oy_tintColor: UIColor {
        get { tintColor }
        set(value) { tintColor = value }
    }
}
