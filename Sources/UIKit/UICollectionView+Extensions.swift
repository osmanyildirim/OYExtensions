//
//  UICollectionView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UICollectionView {
    /// Register UICollectionViewCell with class name
    /// - Parameter type: UICollectionViewCell class
    public func oy_register<C: UICollectionViewCell>(_ type: C.Type) {
        register(C.self, forCellWithReuseIdentifier: C.oy_reuseIdentifier)
    }

    /// Register UICollectionViewCell array  with class names
    /// - Parameter types: UICollectionViewCell classes array
    public func oy_register<C: UICollectionViewCell>(types: C.Type...) {
        _ = types.map { oy_register($0) }
    }

    /// Register UICollectionViewCell with nib name and bundle
    /// - Parameters:
    ///   - nib: nib class
    ///   - bundle: bundle
    public func oy_register<C: UICollectionViewCell>(nib: C.Type, bundle: Bundle = .main) {
        register(UINib(nibName: nib.oy_reuseIdentifier, bundle: bundle), forCellWithReuseIdentifier: C.oy_reuseIdentifier)
    }

    /// Register UICollectionViewCell with nib name array and bundle
    /// - Parameters:
    ///   - nibs: nib classes
    ///   - bundle: bundle
    public func oy_register<C: UICollectionViewCell>(nibs: C.Type..., bundle: Bundle = .main) {
        _ = nibs.map { oy_register(nib: $0, bundle: bundle) }
    }

    /// Register UICollectionReusableView with class name
    /// - Parameters:
    ///   - kind: `UICollectionView.elementKindSectionHeader` or `UICollectionView.elementKindSectionFooter`
    ///   - type: UICollectionReusableView class
    public func oy_register<C: UICollectionReusableView>(supplementaryViewOfKind kind: String, type: C.Type) {
        register(C.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: C.oy_reuseIdentifier)
    }

    /// Register UICollectionReusableView with nib name and bundle
    /// - Parameters:
    ///   - kind: `UICollectionView.elementKindSectionHeader` or `UICollectionView.elementKindSectionFooter`
    ///   - nib: nib class
    ///   - bundle: bundle
    public func oy_register<C: UICollectionReusableView>(supplementaryViewOfKind kind: String, nib: C.Type, bundle: Bundle = .main) {
        register(UINib(nibName: nib.oy_reuseIdentifier, bundle: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: C.oy_reuseIdentifier)
    }

    /// Register UICollectionReusableView with nib names and bundle
    /// - Parameters:
    ///   - kind: `UICollectionView.elementKindSectionHeader` or `UICollectionView.elementKindSectionFooter`
    ///   - nibs: nib classes
    ///   - bundle: bundle
    public func oy_register<C: UICollectionReusableView>(supplementaryViewOfKind kind: String, nibs: C.Type..., bundle: Bundle = .main) {
        _ = nibs.map { oy_register(supplementaryViewOfKind: kind, nib: $0) }
    }

    /// Dequeue reusable UICollectionViewCell using class name
    /// - Parameters:
    ///   - type: UICollectionViewCell class
    ///   - indexPath: IndexPath
    /// - Returns: UICollectionViewCell
    public func oy_dequeueReusableCell<C: UICollectionViewCell>(_ type: C.Type, for indexPath: IndexPath) -> C {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.oy_reuseIdentifier, for: indexPath) as? C else {
            fatalError("\(#function) Unable to dequeue reusable cell of type `\(type)`")
        }
        return cell
    }

    /// Dequeue reusable UICollectionReusableView using class name
    /// - Parameters:
    ///   - kind: `UICollectionView.elementKindSectionHeader` or `UICollectionView.elementKindSectionFooter`
    ///   - type: UICollectionReusableView class
    ///   - indexPath: IndexPath
    /// - Returns: UICollectionReusableView
    public func oy_dequeueReusableSupplementaryView<C: UICollectionReusableView>(ofKind kind: String, type: C.Type, for indexPath: IndexPath) -> C {
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: C.oy_reuseIdentifier, for: indexPath) as? C else {
            fatalError("\(#function) Unable to dequeue reusable cell of type `\(type)`")
        }
        return cell
    }

    /// Item(s) count of UICollectionView
    public var oy_itemCount: Int {
        var section = 0
        var itemsCount = 0
        while section < numberOfSections {
            itemsCount += numberOfItems(inSection: section)
            section += 1
        }
        return itemsCount
    }

    /// Index path of last item in UICollectionView
    public var oy_indexPathForLastItem: IndexPath? {
        oy_indexPathForLastItem(inSection: oy_lastSection)
    }

    /// Index of last section in UICollectionView
    public var oy_lastSection: Int {
        numberOfSections > 0 ? numberOfSections - 1: 0
    }

    /// IndexPath's of visible cell(s) in UICollectionView
    public var oy_visibleCellsIndexPaths: [IndexPath] {
        let visibleIndexPaths = indexPathsForVisibleItems.filter { indexPath in
            guard let layoutAttribute = layoutAttributesForItem(at: indexPath) else { return false }
            let isVisible = bounds.contains(layoutAttribute.frame)
            return isVisible
        }
        return visibleIndexPaths
    }

    /// UICollectionView's reload completion handler
    /// - Parameter completion: completion handler
    public func oy_reloadDataCompletion(completion: @escaping () -> Void) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion()
        }
        self.reloadData()
        CATransaction.commit()
    }

    /// Scroll to UICollectionView with indexPath, scrollPosition and animated
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - scrollPosition: scroll position: top, bottom etc.
    ///   - animated: if the should be animated
    public func oy_scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard indexPath.item >= 0,
            indexPath.section >= 0,
            indexPath.section < numberOfSections,
            indexPath.item < numberOfItems(inSection: indexPath.section) else {
            return
        }
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
    }

    /// Index path of last item in UICollectionView by section
    /// - Parameter section: section number
    /// - Returns: indexPath
    private func oy_indexPathForLastItem(inSection section: Int) -> IndexPath? {
        guard section >= 0 else {
            return nil
        }
        guard section < numberOfSections else {
            return nil
        }
        guard numberOfItems(inSection: section) > 0 else {
            return IndexPath(item: 0, section: section)
        }
        return IndexPath(item: numberOfItems(inSection: section) - 1, section: section)
    }
}
