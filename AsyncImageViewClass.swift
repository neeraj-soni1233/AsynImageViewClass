//
//  AsyncImageViewClass.swift
//
//  Created by Neeraj Soni on 02/10/19.
//  Copyright © 2019 Neeraj Soni. All rights reserved.
//

import UIKit

class AsyncImageViewClass: UIView {
    private var _image:UIImage?
    var image:UIImage? {
        get {
            return _image
        }
        set {
            _image = newValue
            layer.contents = nil
            guard let img1 = newValue else {return}
            DispatchQueue.global(qos: .userInitiated).async {
                let decoImage = self.decodeImage(img:img1)
                DispatchQueue.main.async {
                    self.layer.contents = decoImage?.cgImage
                }
            }
        }
    }
    
    
    func decodeImage(img:UIImage) -> UIImage? {
        guard let newImage = img.cgImage else {return nil}
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: nil, width: Int(newImage.width) , height: Int(newImage.height), bitsPerComponent: 8, bytesPerRow: Int(newImage.width * 4), space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        context?.draw(newImage, in: CGRect(x: 0, y: 0, width: newImage.width, height: newImage.height))
        let decodeImage = context?.makeImage()
        if let decoeImage = decodeImage{
            return UIImage(cgImage: decoeImage)
        }
        else {
            return nil
        }
        
        
        
    }
    
    
}
