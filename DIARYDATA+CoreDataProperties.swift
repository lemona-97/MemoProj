//
//  DIARYDATA+CoreDataProperties.swift
//  
//
//  Created by 임우섭 on 2023/01/24.
//
//

import Foundation
import CoreData


extension DIARYDATA {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DIARYDATA> {
        return NSFetchRequest<DIARYDATA>(entityName: "DIARYDATA")
    }

    @NSManaged public var diaryDate: String?
    @NSManaged public var diaryContent: String?

}
