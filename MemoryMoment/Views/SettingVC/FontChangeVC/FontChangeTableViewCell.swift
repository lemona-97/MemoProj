//
//  FontChangeTableViewCell.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/25.
//

import UIKit

final class FontChangeTableViewCell: UITableViewCell, ViewControllerBaseProtocol {
    
    let fontName : UILabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: .value1, reuseIdentifier: "FontChangeTableViewCell")
        setAttribute()
        addView()
        setLayout()
    }
    
    
    internal func setAttribute() {
        self.contentView.backgroundColor = .mainBackgroundColor
        fontName.do {
            $0.font = .systemFont(ofSize: 15)
            $0.textColor = .black
            $0.backgroundColor = .mainBackgroundColor
        }
    }
    internal func addView() {
        self.contentView.addSubview(fontName)
    }
    internal func setLayout() {
        fontName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
