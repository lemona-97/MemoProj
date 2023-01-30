//
//  MemoViewController.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/21.
//

import UIKit
import Then
import SnapKit
import CoreData

class MemoViewController: UIViewController {

    private let topTitleView = UIView()
    private let topTitleLabel = UILabel()
    private let addMemoBtn = UIButton()
    
    let memoTableView = UITableView()
    
    var memoContainer: NSPersistentContainer!
    var fetchedMemoDataArray = [MEMODATA]()
    var memoTableViewCellCount = 1
    var font = FontManager.getFont()
    
    var sampleDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkFirst()
        
        setAttribute()
        addView()
        setLayout()
        
        addDelegate()
        addTargetFunc()
        
        fetchCoreData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        resetFont()
        memoTableView.reloadData()
        fetchCoreData()
    }
    
    private func checkFirst() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memoContainer = appDelegate.persistentContainer
        checkAppFirstrunOrUpdateStatus {
            print("앱 설치 후 최초 실행할때만 실행됨")
            firstCoreData(memoContainer)
        } updated: {
            print("버전 변경시마다 실행됨")
        } nothingChanged: {
            print("변경 사항 없음")
        }
    }
    private func setAttribute() {
        view.backgroundColor = .mainColor
        topTitleView.do {
            $0.backgroundColor = .mainBackgroundColor
            $0.layer.addBorder([.bottom], color: .gray, width: 1)
            $0.layer.cornerRadius = 18
            $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
            $0.layer.addShadow(location: .bottom)
        }
        topTitleLabel.do {
            $0.text = "메모"
            $0.textAlignment = .center
            $0.textColor = .mainTitleColor
        }
        addMemoBtn.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setImage(#imageLiteral(resourceName: "AddMemoBtnNormal.png"), for: .normal)
        }
        memoTableView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.separatorColor = .mainBackgroundColor
        }
    }
    private func addView(){
        self.view.addSubviews([topTitleView, memoTableView, addMemoBtn])
        
        topTitleView.addSubview(topTitleLabel)
    }
    private func setLayout() {
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
        memoTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(133)
            make.bottom.equalToSuperview().offset(-100)
        }
        addMemoBtn.snp.makeConstraints { make in
            make.trailing.equalTo(memoTableView.snp.trailing)
            make.bottom.equalTo(memoTableView.snp.bottom)
            make.width.height.equalTo(72)
        }
    }
    private func addDelegate() {
        memoTableView.delegate = self
        memoTableView.dataSource = self
        memoTableView.register(MemoTableViewCell.self, forCellReuseIdentifier: "MemoTableViewCell")
    }
    private func addTargetFunc() {
        addMemoBtn.addTarget(self, action: #selector(pushAddMemoVC), for: .touchUpInside)
    }
    
    @objc func pushAddMemoVC() {
        let nextView = AddMemoViewController()
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    private func fetchCoreData() {
        do {
            let fetchedMemoData = try self.memoContainer.viewContext.fetch(MEMODATA.fetchRequest()) as [MEMODATA]
            memoTableViewCellCount = fetchedMemoData.count
            fetchedMemoDataArray = fetchedMemoData
            memoTableView.reloadData()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    private func resetFont() {
        font = FontManager.getFont()
        topTitleLabel.font = font.extraLargeFont
    }
}

extension MemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memoTableViewCellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoTableViewCell", for: indexPath) as? MemoTableViewCell else { return UITableViewCell() }
        let record = self.fetchedMemoDataArray[indexPath.row]
        cell.cellSubjectLabel.font = font.mediumFont
        cell.cellSubjectLabel.text = record.value(forKey: "memoSubject") as? String
        
        cell.cellDateLabel.text = String(((record.value(forKey: "memoDate") as? String)?.components(separatedBy: " ")[0])!)
        cell.cellDateLabel.font = font.mediumFont
        
        cell.cellContent.text = record.value(forKey: "memoContent") as? String
        cell.cellContent.font = font.smallFont
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextView = ModiMemoViewController()
        nextView.objectId = fetchedMemoDataArray[indexPath.row].objectID
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(nextView, animated: true)        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.memoContainer.viewContext.delete(fetchedMemoDataArray[indexPath.row])
        
        if editingStyle == .delete {
            fetchedMemoDataArray.remove(at: indexPath.row)
            memoTableViewCellCount -= 1
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}
