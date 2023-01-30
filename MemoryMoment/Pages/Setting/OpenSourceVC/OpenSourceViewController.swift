//
//  OpenSourceViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/25.
//

import UIKit

class OpenSourceViewController: UIViewController {

    private let openSourceList = [ "Then",
                                   "SnapKit",
                                   "RxGesture",
                                   "FSCalendar",
                                   "CocoaPods"]
    private let openSourceURL = ["https://github.com/devxoul/Then",
                                 "https://github.com/SnapKit/SnapKit",
                                 "https://github.com/RxSwiftCommunity/RxGesture",
                                 "https://github.com/WenchaoD/FSCalendar",
                                 "https://github.com/CocoaPods/CocoaPods"]
    private let openSourceLisense = ["MIT License",
                                     "MIT License",
                                     "MIT License",
                                     "MIT License",
                                     "MIT License"]
    
    //view
    private let topTitleView = UIView()
    private let topTitleLabel = UILabel()
   
    private let openSourceTableView = UITableView()
    private var font = FontManager.getFont()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()

        addView()

        setLayout()
        
        addDelegate()
    }
   
    private func setAttribute() {
        self.view.backgroundColor = .mainColor
        topTitleView.do {
            $0.backgroundColor = .mainBackgroundColor
            $0.layer.addBorder([.bottom], color: .gray, width: 1)
            $0.layer.cornerRadius = 18
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
            $0.layer.addShadow(location: .bottom)
        }
        topTitleLabel.do {
            $0.text = "오픈 소스 정보"
            $0.font = font.extraLargeFont
            $0.textAlignment = .center
            $0.textColor = .mainTitleColor
        }
        openSourceTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
        }
        
    }
    private func addView() {
        self.view.addSubviews([topTitleView, openSourceTableView])
        topTitleView.addSubview(topTitleLabel)
    }
    private func setLayout() {
        topTitleView.snp.makeConstraints { make in
            make.height.equalTo(123)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        topTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
            make.height.equalTo(70)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        openSourceTableView.snp.makeConstraints { make in
            make.top.equalTo(topTitleView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(20)
        }
    }
    
    private func addDelegate() {
        openSourceTableView.delegate = self
        openSourceTableView.dataSource = self
        openSourceTableView.register(OpenSourceTableViewCell.self, forCellReuseIdentifier: "OpenSourceTableViewCell")
    }
}

extension OpenSourceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        openSourceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OpenSourceTableViewCell", for: indexPath) as? OpenSourceTableViewCell else { return UITableViewCell() }
        cell.openSourceNameLabel.text = openSourceList[indexPath.row]
        cell.openSourceURL.text = openSourceURL[indexPath.row]
        cell.openSourceLisence.text = openSourceLisense[indexPath.row]
//        cell.openSourceURL.text =
//        cell.openSourceLisence =
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextView = DetailLisenseViewController()
        var mainText = ""
        switch openSourceList[indexPath.row] {
        case "Then":
            mainText = Lisense().Then
        case "SnapKit":
            mainText = Lisense().SnapKit
        case "RxGesture":
            mainText = Lisense().RxGesture
        case "FSCalendar":
            mainText = Lisense().FSCalendar
        case "CocoaPods":
            mainText = Lisense().CocoaPods
        default:
            mainText = "오류발생"
        }
        print("main text is : \(mainText)")
        nextView.openSourceDetail.text = mainText
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .mainColor
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
