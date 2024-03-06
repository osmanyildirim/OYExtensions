//
//  UITableView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UITableView: OYInit {
    public typealias ViewType = UITableView

    /// Register UITableViewCell with class name
    /// - Parameter type: UITableViewCell class
    public func oy_register<C: UITableViewCell>(_ type: C.Type) {
        register(C.self, forCellReuseIdentifier: C.oy_reuseIdentifier)
    }

    /// Register UITableViewCell array  with class names
    /// - Parameter types: UITableViewCell classes array
    public func oy_register<C: UITableViewCell>(types: C.Type...) {
        _ = types.map { oy_register($0) }
    }

    /// Register UITableViewCell with nib name and bundle
    /// - Parameters:
    ///   - nib: nib class
    ///   - bundle: bundle
    public func oy_register<C: UITableViewCell>(nib: C.Type, bundle: Bundle = .main) {
        register(UINib(nibName: nib.oy_reuseIdentifier, bundle: bundle), forCellReuseIdentifier: C.oy_reuseIdentifier)
    }

    /// Register UITableViewCell with nib name array and bundle
    /// - Parameters:
    ///   - nibs: nib classes
    ///   - bundle: bundle
    public func oy_register<C: UITableViewCell>(nibs: C.Type..., bundle: Bundle = .main) {
        _ = nibs.map { oy_register(nib: $0, bundle: bundle) }
    }

    /// Register UITableViewHeaderFooterView with class name
    /// - Parameter type: UITableViewHeaderFooterView class
    public func oy_registerHeaderFooterView<V: UITableViewHeaderFooterView>(_ type: V.Type) {
        register(V.self, forHeaderFooterViewReuseIdentifier: V.oy_reuseIdentifier)
    }

    /// Dequeue reusable UITableViewCell using class name
    /// - Parameter type: UITableViewCell class
    /// - Returns: UITableViewCell
    public func oy_dequeueReusableCell<C: UITableViewCell>(_ type: C.Type) -> C {
        guard let cell = dequeueReusableCell(withIdentifier: type.oy_reuseIdentifier) as? C else {
            fatalError("\(#function) UIRefreshControl doesn't belong to UIScrollView")
        }
        return cell
    }

    /// Dequeue reusable UITableViewCell using class name
    /// - Parameters:
    ///   - type: UITableViewCell class
    ///   - indexPath: IndexPath
    /// - Returns: UITableViewCell
    public func oy_dequeueReusableCell<C: UITableViewCell>(_ type: C.Type, for indexPath: IndexPath) -> C {
        guard let cell = dequeueReusableCell(withIdentifier: type.oy_reuseIdentifier, for: indexPath) as? C else {
            fatalError("\(#function) Unable to dequeue reusable cell of type `\(type)`")
        }
        return cell
    }

    /// Dequeue reusable Header or Footer using class name
    /// - Parameter viewType: UITableViewHeaderFooterView class
    /// - Returns: UITableViewHeaderFooterView
    public func oy_dequeueReusableHeaderFooterView<V: UITableViewHeaderFooterView>(_ viewType: V.Type) -> V? {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.oy_reuseIdentifier) as? V else {
            fatalError("\(#function) Unable to dequeue reusable view of type `\(viewType)`")
        }
        return view
    }

    /// Index path of last row in UITableView
    public var oy_indexPathForLastRow: IndexPath? {
        guard let lastSection = oy_lastSection else { return nil }
        return oy_indexPathForLastRow(inSection: lastSection)
    }
    
    /// Checks the validity of IndexPath of UITableView
    public func oy_isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        return indexPath.section >= 0 &&
               indexPath.row >= 0 &&
               indexPath.section < numberOfSections &&
               indexPath.row < numberOfRows(inSection: indexPath.section)
    }

    /// Index of last section in UITableView
    public var oy_lastSection: Int? {
        return numberOfSections > 0 ? numberOfSections - 1: nil
    }

    /// IndexPath's of visible cell(s) in UITableView
    public var oy_visibleCellsIndexPaths: [IndexPath] {
        guard let indexPaths = indexPathsForVisibleRows else { return [] }

        let visibleIndexPaths = indexPaths.filter { indexPath in
            let cellFrame = rectForRow(at: indexPath)
            let isCellVisible = bounds.contains(cellFrame)
            return isCellVisible
        }
        return visibleIndexPaths
    }

    /// UITableView's reload completion handler
    /// - Parameter completion: completion handler
    public func oy_reloadDataCompletion(completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion()
        }
        self.reloadData()
        CATransaction.commit()
    }

    /// Scroll to UITableView with indexPath, scrollPosition and animated
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - scrollPosition: scroll position: top, bottom etc.
    ///   - animated: if the should be animated
    public func oy_scrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool = true) {
        guard indexPath.section < numberOfSections else { return }
        guard indexPath.row < numberOfRows(inSection: indexPath.section) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }

    /// Scroll to bottom
    /// - Parameter animated: if the should be animated
    public func oy_scrollToBottom(animated: Bool = true) {
        if let lastSection = (0 ..< numberOfSections).reversed().first(where: { numberOfRows(inSection: $0) > 0 }) {
            let lastRow = numberOfRows(inSection: lastSection) - 1
            let lastIndexPath = IndexPath(row: lastRow, section: lastSection)
            oy_scrollToRow(at: lastIndexPath, at: .bottom)
        }
    }

    /// Remove UITableView's footer view
    public func oy_removeTableFooterView() {
        tableFooterView = nil
    }

    /// Remove UITableView's header view
    public func oy_removeTableHeaderView() {
        tableHeaderView = nil
    }

    /// Top and Bottom round corners of UITableView
    /// - Parameter radius: corner radius size
    public func oy_roundCornersTopAndBottom(_ radius: CGFloat) {
        cellForRow(at: IndexPath(row: 0, section: 0))?.oy_cornerRadius(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: radius)
        cellForRow(at: IndexPath(row: numberOfRows(inSection: 0) - 1, section: 0))?.oy_cornerRadius(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: radius)
    }

    /// Get and Set refreshControl for UITableView
    public var oy_refreshControl: UIRefreshControl? {
        get { refreshControl }
        set(value) { refreshControl = value }
    }
}

extension UITableView {
    /// Private method for find to last row's index path
    private func oy_indexPathForLastRow(inSection section: Int) -> IndexPath? {
        guard numberOfSections > 0, section >= 0 else { return nil }
        guard numberOfRows(inSection: section) > 0 else {
            return IndexPath(row: 0, section: section)
        }
        return IndexPath(row: numberOfRows(inSection: section) - 1, section: section)
    }
}
