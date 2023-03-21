//
//  SettingViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit

final class SettingViewController: UIViewController, ViewControllerBaseProtocol {
    
    //view
    private let topTitleView : UIView = UIView()
    private let topTitleLabel : UILabel = UILabel()
    
    //미구현
//    private let secureBtn = UIButton()
    private let fontSettingBtn : UIButton = UIButton()
//    private let noticeBtn = UIButton()
//    private let bugReportBtn = UIButton()
    private let openSourceCheckBtn : UIButton = UIButton()
    
    var font : Font = FontManager.getFont()

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()

        addView()

        setLayout()
        
        addTargetFunc()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        font = FontManager.getFont()
        resetFont()
    }
    internal func setAttribute(){
        self.view.backgroundColor = .mainColor

        topTitleView.do {
            $0.backgroundColor = .mainBackgroundColor
            $0.layer.addBorder([.bottom], color: .gray, width: 1)
            $0.layer.addShadow(location: .bottom)
        }
        topTitleLabel.do {
            $0.text = "설정"
            $0.font = font.extraLargeFont
            $0.textAlignment = .center
            $0.textColor = .mainTitleColor
        }
        fontSettingBtn.do {
            $0.setTitle("폰트 설정", for: .normal)
            $0.titleLabel?.font = font.largeFont
            $0.setTitleColor(.mainTitleColor, for: .normal)
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
            $0.backgroundColor = .mainBackgroundColor
        }
//        noticeBtn.do {
//            $0.setTitle("공지 사항", for: .normal)
//            $0.titleLabel?.font = font.largeFont
//            $0.titleLabel?.backgroundColor = .mainTitleColor
//            $0.backgroundColor = .mainBackgroundColor
//            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
//        }
//        bugReportBtn.do {
//            $0.setTitle("버그 신고", for: .normal)
//            $0.titleLabel?.font = font.largeFont
//            $0.titleLabel?.backgroundColor = .mainTitleColor
//            $0.backgroundColor = .mainBackgroundColor
//            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
//        }
        openSourceCheckBtn.do {
            $0.setTitle("오픈소스 라이선스", for: .normal)
            $0.titleLabel?.font = font.largeFont
            $0.setTitleColor(.mainTitleColor, for: .normal)
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
            $0.backgroundColor = .mainBackgroundColor
        }
    }

    internal func addView(){
        self.view.addSubviews([topTitleView, fontSettingBtn, openSourceCheckBtn])
        topTitleView.addSubview(topTitleLabel)

    }

    internal func setLayout(){

        topTitleView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height/8)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        topTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(view.frame.height/40)
            make.height.equalTo(70)
            make.width.equalTo(90)
        }
        fontSettingBtn.snp.makeConstraints { make in
            make.top.equalTo(topTitleView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(70)
        }
//        noticeBtn.snp.makeConstraints { make in
//            make.top.equalTo(fontSettingBtn.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.height.equalTo(70)
//        }
//        bugReportBtn.snp.makeConstraints { make in
//            make.top.equalTo(noticeBtn.snp.bottom).offset(20)
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.height.equalTo(70)
//        }
        openSourceCheckBtn.snp.makeConstraints { make in
            make.top.equalTo(fontSettingBtn.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(70)
        }
    }
    
    private func addTargetFunc(){
        fontSettingBtn.addTarget(self, action: #selector(fontSettingVC), for: .touchUpInside)
//        noticeBtn.addTarget(self, action: #selector(noticeView), for: .touchUpInside)
//        bugReportBtn.addTarget(self, action: #selector(bugReportView), for: .touchUpInside)
        openSourceCheckBtn.addTarget(self, action: #selector(openSourceVC), for: .touchUpInside)
    }
    @objc
    func fontSettingVC() {
        let nextView = FontChangeViewController()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(nextView, animated: true)
    }
//    @objc
//    func noticeView() {
//
//    }
//    @objc
//    func bugReportView() {
//
//    }
    @objc
    func openSourceVC() {
        let nextView : UIViewController = OpenSourceViewController()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    private func resetFont() {
        topTitleLabel.font = font.extraLargeFont
        fontSettingBtn.titleLabel?.font = font.largeFont
//        noticeBtn.titleLabel?.font = font.largeFont
//        bugReportBtn.titleLabel?.font = font.largeFont
        openSourceCheckBtn.titleLabel?.font = font.largeFont
    }
}
