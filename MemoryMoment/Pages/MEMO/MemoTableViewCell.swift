//
//  MemoTableViewCell.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit

class MemoTableViewCell: UITableViewCell {

    let cellSubjectLabel : UILabel = UILabel()
    let cellDateLabel : UILabel = UILabel()
    let cellContent : UILabel = UILabel()
    var font : Font = FontManager.getFont()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: .value1, reuseIdentifier: "MemoTableViewCell")
        setAttribute()
        addView()
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setAttribute() {
        self.contentView.backgroundColor = .mainColor
        cellSubjectLabel.do {
            $0.text = "제목이 들어갈 곳"
            $0.font = font.mediumFont
            $0.textColor = .black
            print("중간 폰트 적용 했지롱")
        }
        cellDateLabel.do {
            $0.text = "2023.01.21"
            $0.textColor = .black
            $0.font = font.mediumFont
        }
        cellContent.do {
            $0.backgroundColor = .mainColor
            $0.numberOfLines = 4
            $0.textColor = .black
            $0.font = font.smallFont
            print("small font 적용 했지롱")
            $0.text = "내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. 내용이 들어갈 곳. "
        }
    }
    private func addView() {
        self.contentView.addSubviews([cellSubjectLabel,cellDateLabel,cellContent])
    }
    private func setLayout() {
        cellSubjectLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        cellDateLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        cellContent.snp.makeConstraints { make in
            make.top.equalTo(cellSubjectLabel.snp.bottom).offset(10)
            make.leading.equalTo(cellSubjectLabel)
            make.trailing.equalTo(cellDateLabel)
            make.bottom.equalToSuperview()
        }
    }
    
}
