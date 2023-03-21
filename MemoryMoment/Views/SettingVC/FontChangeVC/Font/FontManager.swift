//
//  FontManager.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/25.
//

import UIKit

let fontKey = "Font"

enum FontSize: CGFloat {
    case small = 12
    case medium = 14
    case large = 16
    case extraLarge = 30
}

enum Font: Int {
    case Basic
    case JalnanOTF
    case KOTRA
    case Kyobo      // 교보손글씨2019
    case Leeseoyun  // 이서윤체
    case MapleStory
    /// 아이폰 작은 글씨(size: 12)
    var smallFont: UIFont {
        switch self {
        case .Basic:
            return .systemFont(ofSize: FontSize.small.rawValue)
        case .JalnanOTF:
            return UIFont(name: "JalnanOTF", size: FontSize.small.rawValue)!
        case .KOTRA:
            return UIFont(name: "KOTRA HOPE", size: FontSize.small.rawValue)!
        case .MapleStory:
            return UIFont(name: "Maplestory OTF Light", size: FontSize.small.rawValue)!
        case .Kyobo:
            return UIFont(name: "KyoboHandwriting2021sjy", size: FontSize.small.rawValue)!
        case .Leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.small.rawValue)!
        }
    }
    /// 아이폰 중간 글씨(size: 14)
    var mediumFont: UIFont {
        switch self {
        case .Basic:
            return .systemFont(ofSize: FontSize.medium.rawValue)
        case .JalnanOTF:
            return UIFont(name: "JalnanOTF", size: FontSize.medium.rawValue)!
        case .KOTRA:
            return UIFont(name: "KOTRA HOPE", size: FontSize.medium.rawValue)!
        case .MapleStory:
            return UIFont(name: "Maplestory OTF Light", size: FontSize.medium.rawValue)!
        case .Kyobo:
            return UIFont(name: "KyoboHandwriting2021sjy", size: FontSize.medium.rawValue)!
        case .Leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.medium.rawValue)!
        }
    }
    /// 아이폰 큰 글씨(size: 16)
    var largeFont: UIFont {
        switch self {
        case .Basic:
            return .systemFont(ofSize: FontSize.large.rawValue)
        case .JalnanOTF:
            return UIFont(name: "JalnanOTF", size: FontSize.large.rawValue)!
        case .KOTRA:
            return UIFont(name: "KOTRA HOPE", size: FontSize.large.rawValue)!
        case .MapleStory:
            return UIFont(name: "Maplestory OTF Light", size: FontSize.large.rawValue)!
        case .Kyobo:
            return UIFont(name: "KyoboHandwriting2021sjy", size: FontSize.large.rawValue)!
        case .Leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.large.rawValue)!
        }
    }
    /// 제일큰 글씨(size: 30)
    var extraLargeFont: UIFont {
        switch self {
        case .Basic:
            return .systemFont(ofSize: FontSize.extraLarge.rawValue)
        case .JalnanOTF:
            return UIFont(name: "JalnanOTF", size: FontSize.extraLarge.rawValue)!
        case .KOTRA:
            return UIFont(name: "KOTRA HOPE", size: FontSize.extraLarge.rawValue)!
        case .MapleStory:
            return UIFont(name: "Maplestory OTF Light", size: FontSize.extraLarge.rawValue)!
        case .Kyobo:
            return UIFont(name: "KyoboHandwriting2021sjy", size: FontSize.extraLarge.rawValue)!
        case .Leeseoyun:
            return UIFont(name: "LeeSeoyun", size: FontSize.extraLarge.rawValue)!
        }
    }
}

class FontManager {
    /// 저장된 폰트 가져오기
    static func getFont() -> Font {
        if let font = (UserDefaults.standard.value(forKey: fontKey) as AnyObject).integerValue {
            print("폰트 가져오기 성공")
            return Font(rawValue: font)!
        } else {
            // 저장된 폰트가 없으면 기본 폰트로
            print("기본 폰트 설정")
            return .Basic
        }
    }
    /// 폰트 저장하기
    static func setFont(font: Font) {
        UserDefaults.standard.setValue(font.rawValue, forKey: fontKey)
        print(UserDefaults.standard.synchronize())
        print("완료")
    }
}
