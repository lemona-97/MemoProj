//
//  ModiMemoViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/23.
//

import UIKit
import RxSwift
import RxGesture
import CoreData

final class ModiMemoViewController: UIViewController {
   
    private var disposeBag = DisposeBag()
    
    //view
    private let memoTextView : UITextView = UITextView()
    private let memoCompletedBtn : UIButton = UIButton()
    private let nowDate : Date = Date()
    private let myDateFommatter : DateFormatter = DateFormatter()
    private var font : Font = FontManager.getFont()

    //fetch
    var item : MEMODATA = MEMODATA()
    var container: NSPersistentContainer!
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var objectId : NSManagedObjectID!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        addView()
        setLayout()
        addTargetFunc()
        bindBtn()
        fetchCoreData(objectID: objectId)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    private func setAttribute() {
        self.view.backgroundColor = .mainColor
        memoTextView.do {
            $0.backgroundColor = .clear
            $0.font = font.largeFont
        }
        memoCompletedBtn.do {
            $0.setTitle("저장", for: .normal)
            $0.isHidden = true
            $0.titleLabel?.font = font.mediumFont
        }
    }
    private func addView() {
        self.view.addSubviews([memoTextView, memoCompletedBtn])
    }
    private func setLayout() {
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
    private func saveCoreData() { //기존 데이터 수정 후 저장
        self.item.memoContent = self.memoTextView.text
        do {
              try context.save()
                    print("데이터 업데이트 완료!")
          } catch {
              print("context 저장중 에러 발생 : \(error.localizedDescription)")
          }
    }
    private func getPresentTime() -> String {
        myDateFommatter.dateFormat = "yyyy.MM.dd a hh시 mm분"
        myDateFommatter.locale = Locale(identifier: "ko_KR")
        return myDateFommatter.string(from: nowDate)
    }
    private func fetchCoreData(objectID : NSManagedObjectID) {
        do {
              // ObjectID 받아서 일치하는 Object 반환.
            item = try context.existingObject(with: objectID) as! MEMODATA // 데이터 가져오기
              print("업데이트 대상 데이터 로딩성공")
                    self.viewWillAppear(true) // 데이터 로딩 후 기존 Data를 적재적소에 로드합니다.
          } catch {
              print("데이터 가져오기 에러 : \(error.localizedDescription)")
          }
    }
    
    private func setupData() {
        self.memoTextView.text = item.memoContent // 텍스트필드에 기존 데이터의 텍스트 반영
    }
}
