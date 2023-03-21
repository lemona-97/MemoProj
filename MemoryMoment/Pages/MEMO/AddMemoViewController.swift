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
final class AddMemoViewController: UIViewController, ViewControllerBaseProtocol {
    
    private var disposeBag : DisposeBag = DisposeBag()
    private let memoTextView : UITextView = UITextView()
    private let memoCompletedBtn : UIButton = UIButton()
    
    private let nowDate : Date = Date()
    private let myDateFommatter : DateFormatter = DateFormatter()
    var container: NSPersistentContainer!
    var font : Font = FontManager.getFont()

    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
        addView()
        setLayout()
        addTargetFunc()
        bindBtn()
        
    }

    internal func setAttribute() {
        self.view.backgroundColor = .mainColor
        memoTextView.do {
            $0.backgroundColor = .clear
            $0.font = font.largeFont
        }
        memoCompletedBtn.do {
            $0.setTitle("저장", for: .normal)
            $0.titleLabel?.font = font.mediumFont
            $0.isHidden = true
        }
    }
    internal func addView() {
        self.view.addSubviews([memoTextView, memoCompletedBtn])
    }
    internal func setLayout() {
//        self.navigationController?.isNavigationBarHidden = true
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        memoCompletedBtn.snp.makeConstraints { make in
            make.top.equalTo(memoTextView.snp.top).offset(-20)
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
