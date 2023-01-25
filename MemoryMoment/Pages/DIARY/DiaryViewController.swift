//
//  DiaryViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit
import FSCalendar
import CoreData

class DiaryViewController: UIViewController {
    
    //view
    private let topTitleView = UIView()
    private let topTitleLabel = UILabel()
    
    //calender
    private let diaryCalendar = FSCalendar()
    private let dateFormatter = DateFormatter()
    
    //textview
    private let diaryTextView = UITextView()
    private let diaryTextViewPlaceHolder = "오늘을 기록해보세요!"
    private var focusedDate = String()
    var diaryContext: NSManagedObjectContext!
    var fetchedDiaryDataArray = [DIARYDATA]()
    private let diaryTextViewStartBtn = UIButton()
    private let diaryTextViewStopBtn = UIButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setAttribute()

        addView()

        setLayout()
        
        addTargetFunc()
        
        addDelegate()

        fetchCoreData()

    }

    
    
    private func setAttribute(){
        topTitleView.do {
            $0.backgroundColor = .mainBackgroundColor
            $0.layer.addBorder([.bottom], color: .gray, width: 1)
            $0.layer.cornerRadius = 18
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
            $0.layer.addShadow(location: .bottom)
        }
        topTitleLabel.do {
            $0.text = "일기"
            $0.font = .systemFont(ofSize: 30)
            $0.textAlignment = .center
            $0.textColor = .mainTitleColor
        }
        diaryCalendar.do {
            $0.backgroundColor = .mainBackgroundColor
            $0.appearance.selectionColor = .mainColor
            $0.appearance.todayColor = .black
            $0.appearance.titleTodayColor = .yellow
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
        }
        dateFormatter.do {
            $0.dateFormat = "yyyy-MM-dd"
        }
        diaryTextView.do {
            $0.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            $0.text = diaryTextViewPlaceHolder
            $0.isHidden = true
            $0.backgroundColor = .mainBackgroundColor
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])

        }
        diaryTextViewStartBtn.do {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle("일기 쓰기", for: .normal)
            $0.backgroundColor = .mainBackgroundColor
            $0.roundCorners(cornerRadius: 15, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
            $0.isHidden = true
        }
        diaryTextViewStopBtn.do {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle("일기 저장", for: .normal)
            $0.backgroundColor = .mainBackgroundColor
            $0.roundCorners(cornerRadius: 15, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
            $0.isHidden = true
        }
    }
    private func addView() {
        self.view.addSubviews([topTitleView,
                               diaryCalendar,
                               diaryTextView,
                               diaryTextViewStartBtn,
                               diaryTextViewStopBtn])
        topTitleView.addSubview(topTitleLabel)
    }
    private func setLayout() {
        self.view.backgroundColor = .mainColor
        topTitleView.snp.makeConstraints { make in
            make.height.equalTo(123)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        topTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(20)
            make.height.equalTo(70)
            make.width.equalTo(90)
        }
        diaryCalendar.snp.makeConstraints { make in
            make.top.equalTo(topTitleView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(400)
        }
        diaryTextView.snp.updateConstraints { make in
            make.top.equalTo(diaryCalendar.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-110)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(80)
        }
        diaryTextViewStartBtn.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(diaryCalendar.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        diaryTextViewStopBtn.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(diaryTextViewStartBtn.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
    }
    private func addDelegate() {
        diaryCalendar.delegate = self
        diaryCalendar.dataSource = self
        diaryTextView.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        diaryContext = appDelegate.persistentContainer.viewContext
    }
    
    private func fetchCoreData() {
        do {
            let fetchedDiaryData = try self.diaryContext.fetch(DIARYDATA.fetchRequest()) as [DIARYDATA]
            print("Diary Count is \(fetchedDiaryData.count)")
            if fetchedDiaryData.count != 0 {
                fetchedDiaryDataArray = fetchedDiaryData
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func addTargetFunc() {
        diaryTextViewStartBtn.addTarget(self, action: #selector(startDiaryTextView), for: .touchUpInside)
        diaryTextViewStopBtn.addTarget(self, action: #selector(stopDiaryTextView), for: .touchUpInside)
    }
    
    @objc
    private func startDiaryTextView(){
        diaryTextView.isHidden = false
        if fetchedDiaryDataArray.count != 0 {
            fetchedDiaryDataArray.forEach { data in
                if data.diaryDate == focusedDate {
                    diaryTextView.text = data.diaryContent
                    print("\(focusedDate) 일기 불러오기 성공!")
                    return
                }
            }
        }
        diaryTextViewStopBtn.isHidden = false
        diaryTextViewStartBtn.isHidden = true
    }
    @objc
    private func stopDiaryTextView(){
        diaryTextView.isHidden = true
        diaryTextViewStopBtn.isHidden = true
        view.endEditing(true)
    }
}

extension DiaryViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
            
            switch dateFormatter.string(from: date) {
            case dateFormatter.string(from: Date()):
                return "오늘"
            default:
                return nil
            }
        }
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        fetchCoreData()
        focusedDate = dateFormatter.string(from: date)
        diaryTextViewStartBtn.isHidden = false
        diaryTextView.textColor = .black

    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if diaryTextViewStopBtn.isHidden == false {
            diaryTextViewStopBtn.isHidden = true
        }
        if diaryTextView.isHidden == false {
            diaryTextView.isHidden = true
        }
        print(dateFormatter.string(from: date) + " 해제됨")
        diaryTextView.text = diaryTextViewPlaceHolder
        diaryTextView.textColor = .lightGray
    }
}

extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == diaryTextViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
        self.view.frame.origin.y = -(diaryTextView.fs_height + 50)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = diaryTextViewPlaceHolder
            textView.textColor = .lightGray
        } else {
            var wannaDeleteIndex = -1
            if fetchedDiaryDataArray.count > 0 {
                for i in 0..<fetchedDiaryDataArray.count {
                    if fetchedDiaryDataArray[i].diaryDate == focusedDate {
                        diaryContext.delete(fetchedDiaryDataArray[i])
                        wannaDeleteIndex = i
                        break
                    }
                }
            }
            if wannaDeleteIndex != -1 {
                fetchedDiaryDataArray.remove(at: wannaDeleteIndex)
            }
            saveCoreData()
            
        }
        self.view.frame.origin.y = 0
    }
    
    private func saveCoreData() {
        guard let entity = NSEntityDescription.entity(forEntityName: "DIARYDATA", in: self.diaryContext) else { return }
        let oneOfDiary = NSManagedObject(entity: entity, insertInto: self.diaryContext)
        oneOfDiary.setValue(focusedDate, forKey: "diaryDate")
        oneOfDiary.setValue(diaryTextView.text, forKey: "diaryContent")
        print("focused Date is : \(focusedDate)")
        do {
            try self.diaryContext.save()
            print("Diary core data saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}
