//
//  UIImage.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit

extension UIImage {
    func resize(toTargetSize targetSize: CGSize) -> UIImage? {
        let width = (self.size.width / self.size.height < targetSize.width / targetSize.height) ? targetSize.width : (targetSize.width * self.size.width / self.size.height)
        let height = (self.size.height / self.size.width < targetSize.height / targetSize.width) ? targetSize.height : (targetSize.height * self.size.height / self.size.width)
        let target = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContextWithOptions(target.size, false, UIScreen.main.scale)
        draw(in: target, blendMode: .normal, alpha: 1)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
