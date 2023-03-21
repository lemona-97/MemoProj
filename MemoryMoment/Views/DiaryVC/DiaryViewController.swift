//
//  DiaryViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit
import FSCalendar
import CoreData

final class DiaryViewController: UIViewController, ViewControllerBaseProtocol {
    
    //view
    private let topTitleView  : UIView = UIView()
    private let topTitleLabel : UILabel = UILabel()
    
    //calender
    private let diaryCalendar : FSCalendar = FSCalendar()
    private let dateFormatter : DateFormatter = DateFormatter()
    
    //textview
    private let diaryTextView : UITextView = UITextView()
    private let diaryTextViewPlaceHolder : String = "오늘을 기록해보세요!"
    private let diaryImageView : UIImageView = UIImageView()
    private let diaryTextViewStartBtn : UIButton = UIButton()
    private let diaryTextViewStopBtn : UIButton = UIButton()
    private let diaryImageInsertBtn : UIButton = UIButton()
    
    private var focusedDate : String = String()
    var diaryContext: NSManagedObjectContext!
    var fetchedDiaryDataArray : [DIARYDATA] = [DIARYDATA]()
    var diaryWrittenDate : Set = Set<String>()
    var font : Font = FontManager.getFont()


    override func viewDidLoad() {
        super.viewDidLoad()

        setAttribute()

        addView()

        setLayout()
        
        addTargetFunc()
        
        addDelegate()

        fetchCoreData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        font = FontManager.getFont()
        resetFont()
    }
    
    
    internal func setAttribute(){
        topTitleView.do {
            $0.backgroundColor = .mainBackgroundColor
            $0.layer.addBorder([.bottom], color: .gray, width: 1)
            $0.layer.addShadow(location: .bottom)
        }
        topTitleLabel.do {
            $0.text = "일기"
            $0.font = font.extraLargeFont
            $0.textAlignment = .center
            $0.textColor = .mainTitleColor
        }
        diaryCalendar.do {
            $0.backgroundColor = .mainBackgroundColor
            $0.appearance.selectionColor = .mainColor
            $0.appearance.todayColor = .black
            $0.appearance.titleTodayColor = .yellow
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
            $0.locale = Locale(identifier: "Ko_KR")
            $0.appearance.headerDateFormat = "YYYY년 MM월"
            $0.appearance.headerMinimumDissolvedAlpha = 0.0
            $0.appearance.headerTitleColor = UIColor(hex: 0x345545)
            $0.appearance.weekdayTextColor = UIColor(hex: 0x345545)
            $0.calendarWeekdayView.weekdayLabels[0].text = "일"
            $0.calendarWeekdayView.weekdayLabels[1].text = "월"
            $0.calendarWeekdayView.weekdayLabels[2].text = "화"
            $0.calendarWeekdayView.weekdayLabels[3].text = "수"
            $0.calendarWeekdayView.weekdayLabels[4].text = "목"
            $0.calendarWeekdayView.weekdayLabels[5].text = "금"
            $0.calendarWeekdayView.weekdayLabels[6].text = "토"
        }
        dateFormatter.do {
            $0.dateFormat = "yyyy-MM-dd"
        }
        diaryTextView.do {
            $0.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
            $0.text = diaryTextViewPlaceHolder
            $0.font = font.smallFont
            $0.textColor = .black
            $0.isHidden = true
            $0.backgroundColor = .mainBackgroundColor
            $0.roundCorners(cornerRadius: 10, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
        }
        diaryImageView.do {
            $0.layer.borderWidth = 3
            $0.layer.borderColor = CGColor(red: 76, green: 100, blue: 46, alpha: 0.5)
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.isHidden = true
        }
        diaryTextViewStartBtn.do {
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle("일기 쓰기", for: .normal)
            $0.titleLabel?.font = font.smallFont
            $0.backgroundColor = .mainBackgroundColor
            $0.roundCorners(cornerRadius: 15, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
            $0.isHidden = true
        }
        diaryImageInsertBtn.do {
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle("사진 추가", for: .normal)
            $0.titleLabel?.font = font.smallFont
            $0.backgroundColor = .mainBackgroundColor
            $0.roundCorners(cornerRadius: 15, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
            $0.isHidden = true
        }
        diaryTextViewStopBtn.do {
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle("일기 저장", for: .normal)
            $0.titleLabel?.font = font.smallFont
            $0.backgroundColor = .mainBackgroundColor
            $0.roundCorners(cornerRadius: 15, maskedCorners: [.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner])
            $0.isHidden = true
        }
    }
    internal func addView() {
        self.view.addSubviews([topTitleView,
                               diaryCalendar,
                               diaryTextView,
                               diaryImageView,
                               diaryTextViewStartBtn,
                               diaryImageInsertBtn,
                               diaryTextViewStopBtn])
        topTitleView.addSubview(topTitleLabel)
    }
    internal func setLayout() {
        self.view.backgroundColor = .mainColor
        topTitleView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height/8)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }
        topTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(view.frame.height/40)
            make.height.equalTo(70)
            make.width.equalTo(90)
        }
        diaryCalendar.snp.makeConstraints { make in
            make.top.equalTo(topTitleView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(400)
        }
        diaryTextView.snp.makeConstraints { make in
            make.top.equalTo(diaryCalendar.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-190) //원래 -110
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(80)
        }
        diaryImageView.snp.makeConstraints { make in
            make.top.equalTo(diaryCalendar.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-100)
            make.leading.equalTo(diaryTextView.snp.trailing).offset(10)
            make.height.equalTo(80)
        }
        diaryTextViewStartBtn.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(diaryCalendar.snp.bottom).offset(20)
            make.height.equalTo(30)
        }
        diaryImageInsertBtn.snp.makeConstraints { make in
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
                markWrittenDay()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func addTargetFunc() {
        diaryTextViewStartBtn.addTarget(self, action: #selector(startDiaryTextView), for: .touchUpInside)
        diaryTextViewStopBtn.addTarget(self, action: #selector(stopDiaryTextView), for: .touchUpInside)
        diaryImageInsertBtn.addTarget(self, action: #selector(insertDiaryImage), for: .touchUpInside)
    }
    @objc
    private func insertDiaryImage() {
        print("눌리죠?")
        let imagePicker : UIImagePickerController = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    @objc
    private func startDiaryTextView(){
        diaryTextView.isHidden = false
        if fetchedDiaryDataArray.count != 0 {
            fetchedDiaryDataArray.forEach { data in
                if data.diaryDate == focusedDate {
                    diaryTextView.text = data.diaryContent
                    diaryImageView.image = data.diaryImage.map({ data in
                        UIImage(data: data)!
                    })
                    print("\(focusedDate) 일기 불러오기 성공!")
                    return
                }
            }
        }
        diaryImageView.isHidden = false // 사진
        diaryImageInsertBtn.isHidden = false // 사진 추가 버튼
        diaryTextViewStopBtn.isHidden = false // 일기 저장 버튼
        diaryTextViewStartBtn.isHidden = true
    }
    @objc
    private func stopDiaryTextView(){
        diaryTextView.isHidden = true
        diaryImageView.isHidden = true
        diaryTextViewStopBtn.isHidden = true
        diaryImageInsertBtn.isHidden = true
        diaryWrittenDate.update(with: focusedDate)
        
        view.endEditing(true)
        self.presentAlert(title: "일기 저장 완료")
    }
    private func resetFont() {
        topTitleLabel.font = font.extraLargeFont
        diaryTextView.font = font.smallFont
        diaryImageInsertBtn.titleLabel?.font = font.smallFont
        diaryTextViewStopBtn.titleLabel?.font = font.smallFont
        diaryTextViewStartBtn.titleLabel?.font = font.smallFont
    }
    private func markWrittenDay() {
        
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
        print(diaryWrittenDate)
        if diaryWrittenDate.contains(focusedDate) {
            diaryImageView.isHidden = false
            diaryTextView.isHidden = false
            diaryImageInsertBtn.isHidden = false
            diaryTextViewStopBtn.isHidden = false
            diaryTextView.isHidden = false
            if fetchedDiaryDataArray.count != 0 {
                fetchedDiaryDataArray.forEach { data in
                    if data.diaryDate == focusedDate {
                        diaryTextView.text = data.diaryContent
                        diaryImageView.image = data.diaryImage.map({ data in
                            UIImage(data: data)!
                        })
                        print("\(focusedDate) 일기 불러오기 성공!")
                        return
                    }
                }
            }
        } else {
            diaryTextViewStartBtn.isHidden = false
            diaryTextView.textColor = .black
        }
        

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
        diaryImageView.image = UIImage()
        diaryImageView.isHidden = true
        diaryImageInsertBtn.isHidden = true
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        fetchedDiaryDataArray.forEach {
            diaryWrittenDate.update(with: $0.diaryDate!)
        }
        if diaryWrittenDate.contains(dateFormatter.string(from: date)) {
            return 1
        } else {
            return 0
        }
    }
}

extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == diaryTextViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
        
        self.view.frame.origin.y = -(diaryTextView.fs_height + 150)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = diaryTextViewPlaceHolder
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
        oneOfDiary.setValue(diaryImageView.image?.pngData(), forKey: "diaryImage")
        print("focused Date is : \(focusedDate)")
        do {
            try self.diaryContext.save()
            print("Diary core data saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension DiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            diaryImageView.image = pickedImage.resize(toTargetSize: CGSize(width: 80, height: 80))
        }
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
