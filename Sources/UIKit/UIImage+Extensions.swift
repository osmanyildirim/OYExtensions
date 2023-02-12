//
//  UIImage+Extensions.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import UIKit

extension UIImage {
    /// Initializer method with `image name`
    public static func oy_init(name: String) -> UIImage? {
        UIImage(named: name)
    }

    /// Initializer method with `base64 string` and `scale factor`
    /// `UIImage.oy_init(base64: "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAMAAAC67D+PAAAAflBMVEX////21aP81yfl6ez89tP868z33Jrw8/Xr8/z999zH0Nn98d798M/O09zx+P/Hxr334a/3+f354I3/62L8+enI0dfl7PXzym766c/8+OfayKP39/b34aP77tXl2bDws2Py0zz74D/0z3PwuYbdqGLq3Yr1xk3yqgTvqkXeyoI39fDEAAAAXUlEQVQI1x2MRxKAIADEFpRmF+y9l/9/UDCHzE4OC1h8Hz+tAh+gCpe2TOusVi7z1RjK7YjIRelyTiQCI8/9VrnsmO37keSiTypgnGMphPBKIAxlmsZB4P3XrHH+AOh8BGNIyU0rAAAAAElFTkSuQmCC")`
    public static func oy_init(base64: String, scale: CGFloat = 1.0) -> UIImage? {
        guard let data = Data(base64Encoded: base64) else { return nil }
        let image = UIImage(data: data, scale: scale)
        return image
    }

    /// Initializer method with `data`
    public static func oy_init(data: Data) -> UIImage? {
        UIImage(data: data)
    }

    /// `image.oy_base64` → output → "iVBORw0KGgoAAAANSUhEUgAAAA...."
    public var oy_base64: String? {
        pngData()?.oy_base64EncodedString
    }

    /// Download image with concurrently
    /// @available on iOS 15.0
    /// - Parameters:
    ///   - url: image url
    ///   - completion: Result type with UIImage and Error
    @available(iOS 15.0, *) public static func oy_download(from url: URL, completion: ((Result<UIImage, Error>) -> Void)?) async throws {
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))

            guard let mimeType = response.mimeType, mimeType.hasPrefix("image"), let image = UIImage(data: data) else {
                completion?(.failure(OYError.imageNotDownload))
                return
            }
            completion?(.success(image))
        } catch {
            completion?(.failure(OYError.imageNotDownload))
        }
    }

    /// Download image with URLSession dataTask
    /// - Parameters:
    ///   - url: image url
    ///   - completion: Result type with UIImage and Error
    public static func oy_download(from url: URL, completion: ((Result<UIImage, Error>) -> Void)?) throws {
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard error == nil else {
                guard let error else { return }
                completion?(.failure(error))
                return
            }

            guard let data, let mimeType = response?.mimeType, mimeType.hasPrefix("image"), let image = UIImage(data: data) else {
                completion?(.failure(OYError.imageNotDownload))
                return
            }
            completion?(.success(image))
        }.resume()
    }

    /// `image.oy_sizeOnDisk` → output → "1.2578125KB"
    public var oy_sizeOnDisk: String? {
        guard let data = jpegData(compressionQuality: 1.0) else { return nil }

        var length = Double(data.count) / 1024 / 1024
        if length < 1.0 {
            length *= 1024
            return "\(length)KB"
        } else {
            return "\(length)MB"
        }
    }

    /// Compress quality of UIImage
    /// - Parameter quality: compression quality
    /// - Returns: optional UIImage
    public func oy_compress(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = jpegData(compressionQuality: quality) else { return nil }
        return UIImage(data: data)
    }

    /// Compress quality of UIImage
    /// - Parameter quality: compression quality
    /// - Returns: optional Data
    public func oy_compress(quality: CGFloat = 0.5) -> Data? {
        jpegData(compressionQuality: quality)
    }
}
