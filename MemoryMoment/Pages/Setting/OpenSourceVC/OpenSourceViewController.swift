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
        self.view.addSubviews([topTitleLabel, openSourceTableView])
    }
    private func setLayout() {
        topTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-20)
            make.leading.equalToSuperview().offset(20)
        }
        openSourceTableView.snp.makeConstraints { make in
            make.top.equalTo(topTitleLabel.snp.bottom).offset(30)
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
        let nextView : DetailLisenseViewController = DetailLisenseViewController()
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
        nextView.openSourceDetail.text = mainText
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .mainColor
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
