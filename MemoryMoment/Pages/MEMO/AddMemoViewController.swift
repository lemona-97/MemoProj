//
//  AddMemoViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit
import RxSwift
import RxGesture
import CoreData
class AddMemoViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private let memoTextView = UITextView()
    private let memoCompletedBtn = UIButton()
    
    private let nowDate = Date()
    private let myDateFommatter = DateFormatter()
    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        addView()
        setLayout()
        addTargetFunc()
        bindBtn()
        
    }

    private func setAttribute() {
        self.view.backgroundColor = .mainColor
        memoTextView.do {
            $0.backgroundColor = .clear
            $0.font = .systemFont(ofSize: 15)
        }
        memoCompletedBtn.do {
            $0.setTitle("완료", for: .normal)
            $0.isHidden = true
        }
    }
    private func addView() {
        self.view.addSubviews([memoTextView])
        self.navigationController?.navigationBar.addSubview(memoCompletedBtn)
    }
    private func setLayout() {
//        self.navigationController?.isNavigationBarHidden = true
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        memoCompletedBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(20)
            make.width.equalTo(40)
        }
    }
    private func bindBtn() {
        memoTextView.rx.tapGesture()
            .when(.recognized)
            .asObservable()
            .subscribe(onNext: { [self] result in
                self.memoCompletedBtn.isHidden = false
                print("완료 버튼 등장!")
            }).disposed(by: disposeBag)
        
    }
    private func addTargetFunc() {
        self.memoCompletedBtn.addTarget(self, action: #selector(dismissKeyboard), for: .touchUpInside)
    }
    @objc func dismissKeyboard() {
        print("버튼 눌렸는데?")
        self.view.endEditing(false)
        self.memoCompletedBtn.isHidden = true
        saveCoreData()
    }
    private func saveCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
        guard let entity = NSEntityDescription.entity(forEntityName: "MEMODATA", in: self.container.viewContext) else { return }
        let oneOfMemo = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        oneOfMemo.setValue(memoTextView.text.components(separatedBy: " ")[0], forKey: "memoSubject")
        oneOfMemo.setValue(getPresentTime(), forKey: "memoDate")
        oneOfMemo.setValue(memoTextView.text, forKey: "memoContent")
        do {
            try self.container.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    private func getPresentTime() -> String {
        myDateFommatter.dateFormat = "yyyy.MM.dd a hh시 mm분"
        myDateFommatter.locale = Locale(identifier: "ko_KR")
        return myDateFommatter.string(from: nowDate)
    }
}
