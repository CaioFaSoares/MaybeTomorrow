//
//  AddTaskSheetModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import CoreData
import Combine
import SwiftUI

class AddTaskSheetViewModel: ObservableObject {
    
    // MARK: - Initing the draft task
    
    @Published var draftTask = DraftTask(
        name: "Task ",
        timestamp: .now,
        level: 2)
    
    // MARK: - Initing CK Stuff
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CoreTask.timestamp, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<CoreTask>
    
    // MARK: - Core Data state mutations.
    
    func submitTask() {
        withAnimation {
//            let newItem = Item(context: viewContext)
            let newItem = CoreTask(context: managedObjectContext)
            newItem.timestamp = draftTask.taskDueData
            newItem.name = draftTask.taskName
            newItem.level = Int16(draftTask.taskLevel.rawValue)
            
            saveContext()
        }
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

    let persistentContainer: NSPersistentContainer

    init(inMemory: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "MaybeTomorrow")
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        persistentContainer.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
    }

    
}
