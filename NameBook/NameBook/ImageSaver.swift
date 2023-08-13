//
//  ImageSaver.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import SwiftUI

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writePhotoToAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    func writePhotoToDisc(image: UIImage, savePath: URL) {
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
