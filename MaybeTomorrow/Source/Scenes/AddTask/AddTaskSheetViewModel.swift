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
        
        saveContext()
    }
    
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                print("Saving data")
                try managedObjectContext.save()
            } catch {
                /* This is straight out of Apple's default implementation. As such Apple advises to replace
                 this implementation with code to handle the error appropriately.
                 In particular fatalError() will causes the application to generate a crash log and terminate.
                 And as such, you are advised not use this function in a shipping application, although it may be useful during development.
                 */
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private var cancellableSet: Set<AnyCancellable> = []

    
}
