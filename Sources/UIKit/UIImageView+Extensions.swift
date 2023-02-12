//
//  UIImageView+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIImageView: OYInit {
    public typealias ViewType = UIImageView

    /// Initializer method with `image name`
    public static func oy_init(imageName: String) -> UIImageView {
        let imageView: UIImageView = oy_init()
        imageView.image = UIImage(named: imageName)
        return imageView
    }

    /// Initializer method with `image`
    public static func oy_init(image: UIImage?) -> UIImageView {
        let imageView: UIImageView = oy_init()
        imageView.image = image
        return imageView
    }

    /// Initializer method with `url, contentMode and placeholder image`
    /// Image downloading is Concurrently
    /// @available on iOS 15.0
    /// - Parameters:
    ///   - url: image url
    ///   - contentMode: content mode
    ///   - placeholder: optional placeholder image
    /// - Returns: UIImageView
    @available(iOS 15.0, *) public static func oy_init(url: URL, contentMode: ContentMode = .scaleAspectFit, placeholder: UIImage? = nil) async -> UIImageView {
        let imageView: UIImageView = oy_init()
        try? await imageView.oy_downloadImage(from: url, contentMode: contentMode, placeholder: placeholder)
        return imageView
    }

    /// Initializer method with `url, contentMode and placeholder image`.
    /// Image downloading with URLSession dataTask
    /// - Parameters:
    ///   - url: image url
    ///   - contentMode: content mode
    ///   - placeholder: optional placeholder image
    /// - Returns: UIImageView
    public static func oy_init(url: URL, contentMode: ContentMode = .scaleAspectFit, placeholder: UIImage? = nil) -> UIImageView {
        let imageView: UIImageView = oy_init()
        try? imageView.oy_downloadImage(from: url, contentMode: contentMode, placeholder: placeholder)
        return imageView
    }

    /// Download image to UIImageView
    /// Image downloading is Concurrently
    /// @available on iOS 15.0
    /// - Parameters:
    ///   - url: image url
    ///   - contentMode: content mode
    ///   - placeholder: optional placeholder image
    @available(iOS 15.0, *) public func oy_downloadImage(from url: URL, contentMode: ContentMode = .scaleAspectFit, placeholder: UIImage? = nil) async throws {
        self.contentMode = contentMode

        try await UIImage.oy_download(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.image = placeholder
                }
            }
        }
    }

    /// Download image to UIImageView
    /// Image downloading with URLSession dataTask
    /// - Parameters:
    ///   - url: image url
    ///   - contentMode: content mode
    ///   - placeholder: optional placeholder image
    public func oy_downloadImage(from url: URL, contentMode: ContentMode = .scaleAspectFit, placeholder: UIImage? = nil) throws {
        self.contentMode = contentMode

        try UIImage.oy_download(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image = image
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.image = placeholder
                }
            }
        }
    }

    /// Make UIImageView blurry
    public func oy_blur(style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        clipsToBounds = true
    }
}
