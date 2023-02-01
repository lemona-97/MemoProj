//
//  IndicatorView.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/26.
//

import UIKit

open class IndicatorView {
    static let shared : IndicatorView = IndicatorView()
        
    let containerView : UIView = UIView()
    let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    open func show() {
        let window : UIWindow = UIWindow(frame: UIScreen.main.bounds)
        
        self.containerView.frame = window.frame
        self.containerView.center = window.center
        self.containerView.backgroundColor = .clear
        
        self.containerView.addSubview(self.activityIndicator)
        UIApplication.shared.windows.first?.addSubview(self.containerView)
    }
    //로딩화면 -> containerView + activityIndicator
    open func showIndicator() {
        self.containerView.backgroundColor = UIColor(white: 0x000000, alpha: 0.4)
        
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.style = .large
        self.activityIndicator.color = UIColor(hex: 0x808080)
        self.activityIndicator.center = self.containerView.center
        
        self.activityIndicator.startAnimating()
    }
    
    open func dismiss() {
        self.activityIndicator.stopAnimating()
        self.containerView.removeFromSuperview()
    }
}
