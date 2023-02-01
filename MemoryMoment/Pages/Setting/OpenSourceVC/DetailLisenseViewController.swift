//
//  DetailLisenseViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/26.
//

import UIKit

class DetailLisenseViewController: UIViewController {
    
    var openSourceDetail : UITextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()

        addView()

        setLayout()
    }
    
    private func setAttribute() {
        self.view.backgroundColor = .mainColor
        openSourceDetail.do {
            $0.font = .systemFont(ofSize: 11)
            $0.textColor = .black
            $0.backgroundColor = .clear
        }
    }
    private func addView() {
        self.view.addSubview(openSourceDetail)
    }
    private func setLayout() {
        openSourceDetail.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}
