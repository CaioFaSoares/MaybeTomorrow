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
    
    // MARK: - Initing the draft task
    
    @Published var draftTask = DraftTask(
        name: "Task ",
        timestamp: .now,
        level: 2)
    
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

    private var cancellableSet: Set<AnyCancellable> = []

    
}
