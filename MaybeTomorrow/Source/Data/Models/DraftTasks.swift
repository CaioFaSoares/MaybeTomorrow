//
//  Tasks.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation

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
    
    // TODO: - Maybe implement a version of the submit task but with a quicker way to do it?
//    init(name: String, timestamp: Date, level: Int16) {
//        
//    }
}


