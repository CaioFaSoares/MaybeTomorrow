//
//  Tasks.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import SwiftUI
import CoreData

struct DraftTask: Identifiable {

    var id = ObjectIdentifier(AnyObject.self)

    var taskName: String
    var taskDueData: Date
    var taskLevel: taskImportanceLevels

    init(name: String, timestamp: Date, level: Int16) {
        self.taskName = name
        self.taskDueData = timestamp
        self.taskLevel = taskImportanceLevels(rawValue: Int(level))!
    }
}

extension CoreTask {
    
    @nonobjc public class func fetchAllTasks() -> NSFetchRequest<CoreTask> {
        let name = "\(Self.self)"
        print("Running fetch request \(name) for all")
        let request = NSFetchRequest<CoreTask>(entityName: name)
        request.sortDescriptors = []
        return request
    }
    
}
