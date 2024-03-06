//
//  OYSaveImage.swift
//  OYExtensions
//
//  Created by osmanyildirim
//

import Foundation

struct OYSaveImage {
    final class delegate: NSObject {
        let completion: ((Error?) -> Void)?

        init(completion: ((Error?) -> Void)?) {
            self.completion = completion
        }

        @objc func savedImage(_ image: UIImage, error: Error?, context: UnsafeMutableRawPointer?) {
            self.completion?(error)
        }
    }

    #warning("yorum ekle")
    func saveImage(image: UIImage, completion: ((Error?) -> Void)?) {
        let delegate = delegate(completion: completion)
        UIImageWriteToSavedPhotosAlbum(image, delegate, #selector(delegate.savedImage(_: error: context:)), nil)
    }
}
