//
//  OpenSourceTableViewCell.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/26.
//

import UIKit

class OpenSourceTableViewCell: UITableViewCell {

    var openSourceNameLabel : UILabel = UILabel()
    var openSourceURL : UILabel = UILabel()
    var openSourceLisence : UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: .value1, reuseIdentifier: "OpenSourceTableViewCell")
        setAttribute()
        addView()
        setLayout()
    }
    private func setAttribute() {
        self.contentView.backgroundColor = .mainColor
        openSourceNameLabel.do {
            $0.text = "오픈 소스 이름"
            $0.font = .systemFont(ofSize: 15, weight: .bold)
        }
        openSourceURL.do {
            $0.font = .systemFont(ofSize: 12)
            $0.text = "URL 나타날 곳"
            $0.textColor = .black
        }

        openSourceLisence.do {
            $0.text = "라이센스 나타날 곳"
            $0.font = .systemFont(ofSize: 12, weight: .bold)
        }
    }
    private func addView() {
        self.contentView.addSubviews([openSourceNameLabel, openSourceURL, openSourceLisence])
    }
    private func setLayout() {
        openSourceNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(15)
        }
        openSourceURL.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(openSourceNameLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(13)
        }
        openSourceLisence.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalTo(openSourceURL.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(13)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
