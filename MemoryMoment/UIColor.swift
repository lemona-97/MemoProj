//
//  UIColor.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    // ex) class var mainOrange1: UIColor { UIColor(hex: 0xFF8A00)}
    class var mainColor: UIColor { UIColor(hex: 0xA3CCA2)}
    class var mainBackgroundColor: UIColor { UIColor(hex: 0xE3FAC7)}
    class var mainTitleColor: UIColor { UIColor(hex: 0x345545)}

    
}
