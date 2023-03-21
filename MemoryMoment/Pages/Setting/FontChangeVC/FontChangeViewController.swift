//
//  FontChangeViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/25.
//

import UIKit

final class FontChangeViewController: UIViewController, ViewControllerBaseProtocol {

    private let sampleLabel = UILabel()
    private let sampleTextView = UITextView()
    private let fontListTableView = UITableView()
    private let fontList = ["기본폰트", "잘난체", "코트라 희망체", "교보손글씨2021성지영", "이서윤체", "메이플스토리체"]
    
    private let font = FontManager.getFont()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttribute()

        addView()

        setLayout()
        
        addDelegate()
        
    }
    
    internal func setAttribute() {
        self.view.backgroundColor = .mainColor

        sampleLabel.do {
            $0.text = "글꼴 예시"
            $0.textColor = .black
            $0.font = font.mediumFont
            $0.textAlignment = .center
        }
        sampleTextView.do {
            $0.text = "아무 글자나 입력해보세요!"
            $0.textColor = .black
            $0.font = font.mediumFont
            $0.textAlignment = .center
            $0.backgroundColor = .mainBackgroundColor
        }
//        fontList.do {
//
//        }
        fontListTableView.do {
            $0.showsVerticalScrollIndicator = false
            $0.backgroundColor = .mainBackgroundColor
            $0.separatorColor = .mainColor
        }
        
    }

    internal func addView() {
        self.view.addSubviews([sampleLabel, sampleTextView, fontListTableView])
    }

    internal func setLayout() {
        sampleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(20)
        }
        sampleTextView.snp.makeConstraints { make in
            make.top.equalTo(sampleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
        fontListTableView.snp.makeConstraints { make in
            make.top.equalTo(sampleTextView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    private func addDelegate() {
        fontListTableView.delegate = self
        fontListTableView.dataSource = self
        fontListTableView.register(FontChangeTableViewCell.self, forCellReuseIdentifier: "FontChangeTableViewCell")
    }
}

extension FontChangeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fontList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FontChangeTableViewCell", for: indexPath) as? FontChangeTableViewCell else { return UITableViewCell() }
        
        cell.fontName.text = fontList[indexPath.row]
        var cellfont = UIFont()
        switch fontList[indexPath.row] {
        case "기본폰트":
            cellfont = .systemFont(ofSize: 20)
        case "잘난체":
            cellfont = UIFont(name: "JalnanOTF", size: 20)!
        case "코트라 희망체":
            cellfont = UIFont(name: "KOTRA HOPE", size: 20)!
        case "교보손글씨2021성지영":
            cellfont = UIFont(name: "KyoboHandwriting2021sjy", size: 20)!
        case "이서윤체":
            cellfont = UIFont(name: "LeeSeoyun", size: 20)!
        case "메이플스토리체":
            cellfont = UIFont(name: "Maplestory OTF Light", size: 20)!
        default:
            cellfont = UIFont(name: "LeeSeoyun", size: 20)!
        }
        cell.fontName.font = cellfont
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch fontList[indexPath.row] {
        case "기본폰트":
            FontManager.setFont(font: .Basic)
            sampleLabel.font = .systemFont(ofSize: 15)
            sampleTextView.font = .systemFont(ofSize: 15)
            print("기본 폰트 설정")
        case "잘난체":
            FontManager.setFont(font: Font.JalnanOTF)
            sampleLabel.font =  UIFont(name: "JalnanOTF", size: 15)
            sampleTextView.font = UIFont(name: "JalnanOTF", size: 15)
            print("잘난체 설정")

        case "코트라 희망체":
            FontManager.setFont(font: Font.KOTRA)
            sampleLabel.font = UIFont(name: "KOTRA HOPE", size: 15)
            sampleTextView.font = UIFont(name: "KOTRA HOPE", size: 15)
            print("코트라 체 설정")
        case "교보손글씨2021성지영":
            FontManager.setFont(font: Font.Kyobo)
            sampleLabel.font = UIFont(name: "KyoboHandwriting2021sjy", size: 15)
            sampleTextView.font = UIFont(name: "KyoboHandwriting2021sjy", size: 15)
            print("교보 체 설정")
        case "이서윤체":
            FontManager.setFont(font: Font.Leeseoyun)
            sampleLabel.font = UIFont(name: "LeeSeoyun", size: 15)
            sampleTextView.font = UIFont(name: "LeeSeoyun", size: 15)
            print("이서윤 체 설정")
        case "메이플스토리체":
            FontManager.setFont(font: Font.MapleStory)
            sampleLabel.font = UIFont(name: "Maplestory OTF Light", size: 15)
            sampleTextView.font = UIFont(name: "Maplestory OTF Light", size: 15)
            print("메이플스토리 체 설정")
        default:
            FontManager.setFont(font: Font.Leeseoyun)
        }
        Thread.sleep(forTimeInterval: 1.0)
        self.presentAlert(title: "폰트 설정 완료")
    }
    
}
