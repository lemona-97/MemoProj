//
//  firstStartAppFunc.swift
//  MemoryMoment
//
//  Created by 임우섭 on 2023/01/22.
//

import Foundation
import CoreData
import UIKit

func checkAppFirstrunOrUpdateStatus(firstrun: () -> (), updated: () -> (), nothingChanged: () -> ()) {
    let currentVersion : String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    let versionOfLastRun : String? = UserDefaults.standard.object(forKey: "VersionOfLastRun") as? String
    // print(#function, currentVersion ?? "", versionOfLastRun ?? "")
    if versionOfLastRun == nil {
        // First start after installing the app
        firstrun()
    } else if versionOfLastRun != currentVersion {
        // App was updated since last run
        updated()
    } else {
        // nothing changed
        nothingChanged()
    }
    UserDefaults.standard.set(currentVersion, forKey: "VersionOfLastRun")
    UserDefaults.standard.synchronize()
}

func firstCoreData(_ myContainer:  NSPersistentContainer) {
    let date : Date = Date()
    let myDateFommatter : DateFormatter = DateFormatter()
    myDateFommatter.dateFormat = "yyyy.MM.dd a hh시 mm분"
    myDateFommatter.locale = Locale(identifier: "ko_KR")
    
    guard let entity = NSEntityDescription.entity(forEntityName: "MEMODATA", in: myContainer.viewContext) else { return }
    let oneOfMemo = NSManagedObject(entity: entity, insertInto: myContainer.viewContext)
    oneOfMemo.setValue("메모는 모모!", forKey: "memoSubject")
    oneOfMemo.setValue(myDateFommatter.string(from: date), forKey: "memoDate")
    oneOfMemo.setValue("모모와 함께 순간순간을 기록해보세요!", forKey: "memoContent")
    do {
        try myContainer.viewContext.save()
    } catch {
        print(error.localizedDescription)
    }
    
}
