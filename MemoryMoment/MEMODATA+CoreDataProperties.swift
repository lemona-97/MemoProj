//
//  MEMODATA+CoreDataProperties.swift
//  
//
//  Created by 임우섭 on 2023/01/24.
//
//

import Foundation
import CoreData


extension MEMODATA {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MEMODATA> {
        return NSFetchRequest<MEMODATA>(entityName: "MEMODATA")
    }

    @NSManaged public var memoContent: String?
    @NSManaged public var memoDate: String?
    @NSManaged public var memoSubject: String?

}
