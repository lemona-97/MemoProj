//
//  TabBarViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    static let objectRatio  = 4.0 / 7.0

    let MemoIconDefault : UIImage = UIImage(imageLiteralResourceName: "pencilDefault.png").resize(toTargetSize: CGSize(width: 52.22*objectRatio, height: 56.78*objectRatio))!.withRenderingMode(.alwaysOriginal)
    let MemoIconSelected : UIImage = UIImage(imageLiteralResourceName: "pencilSelected.png").resize(toTargetSize: CGSize(width: 52.22*objectRatio, height: 56.78*objectRatio))!.withRenderingMode(.alwaysOriginal)
    let DiaryIconDefault : UIImage = UIImage(imageLiteralResourceName: "noteDefault.png").resize(toTargetSize: CGSize(width: 52.22*objectRatio, height: 56.78*objectRatio))!.withRenderingMode(.alwaysOriginal)
    let DiaryIconSelected : UIImage = UIImage(imageLiteralResourceName: "noteSelected.png").resize(toTargetSize: CGSize(width: 52.22*objectRatio, height: 56.78*objectRatio))!.withRenderingMode(.alwaysOriginal)
   
    let SettingIconDefault : UIImage = UIImage(imageLiteralResourceName: "line3Default.png").resize(toTargetSize: CGSize(width: 52.22*objectRatio, height: 56.78*objectRatio))!.withRenderingMode(.alwaysOriginal)
    let SettingIconSelected : UIImage = UIImage(imageLiteralResourceName: "line3Selected.png").resize(toTargetSize: CGSize(width: 52.22*objectRatio, height: 56.78*objectRatio))!.withRenderingMode(.alwaysOriginal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstTab : UIViewController = MemoViewController()
        let secondTab : UIViewController = DiaryViewController()
        let thirdTab : UIViewController = SettingViewController()
        
        firstTab.tabBarItem = UITabBarItem(title: "메모", image: self.MemoIconDefault, tag: 0)
        firstTab.tabBarItem.selectedImage = MemoIconSelected
        
        secondTab.tabBarItem = UITabBarItem(title: "일기", image: self.DiaryIconDefault, tag: 1)
        secondTab.tabBarItem.selectedImage = DiaryIconSelected
        
        thirdTab.tabBarItem = UITabBarItem(title: "설정", image: self.SettingIconDefault, tag: 2)
        thirdTab.tabBarItem.selectedImage = SettingIconSelected
        
        let TabList : [UIViewController] = [firstTab, secondTab, thirdTab]
        
        self.tabBar.backgroundColor = .mainBackgroundColor
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.roundCorners(cornerRadius: 26, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        
        TabList.forEach {
            $0.tabBarItem.imageInsets.top = 5
        }

        
        self.viewControllers = TabList
    }
   
}
