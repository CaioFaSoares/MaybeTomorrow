//
//  AddTaskSheetModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import CoreData
import Combine

class AddTaskSheetViewModel: ObservableObject {
    
    init(taskCount: Int) {
        self.taskCount = taskCount
        self.draftTask = DraftTask(
            name: "Task #\(taskCount)",
            timestamp: .now,
            level: -1)
        
    }
    
    // MARK: - Functionality
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    var taskCount: Int = 0
    
    @Published var draftTask = DraftTask(name: String(), timestamp: Date(), level: Int16())
    
//    var draftTask = Published(wrappedValue: DraftTask(name: "Task #\(taskCount)", timestamp: .now, level: -1))
    
    // MARK: - Initing CK Stuff
    
    var managedObjectContext: NSManagedObjectContext {
        PersistenceController.shared.container.viewContext
    }
    
    // MARK: - Core Data state mutations.
    
    func submitTask() {
        let newItem = CoreTask(context: managedObjectContext)
        newItem.timestamp = draftTask.taskDueData
        newItem.name = draftTask.taskName
        newItem.level = Int16(draftTask.taskLevel.rawValue)
        
        PersistenceController.shared.saveContext()
    }

    
    
}
