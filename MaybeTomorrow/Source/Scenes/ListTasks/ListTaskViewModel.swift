//
//  ListTaskViewModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import Combine
import SwiftUI
import CoreData
import CloudKit

class listTaskViewModel: ObservableObject {
    
    // MARK: - Functionality
    
    @Published var showingSheet = false
    @Published var allTasks = [CoreTask]()
    
    func raiseSheet() {
        showingSheet.toggle()
    }
    
    // MARK: - Initing CK Stuff
    
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data state mutations.

    func addItem() {
        _ = CoreTask(context: managedObjectContext)
    }

    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { allTasks[$0] }.forEach(managedObjectContext.delete)
            
//            _ = allTasks.map { task in managedObjectContext.delete }
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

        print("Setting up Core Data update subscriptions  ")
        
        CDPublisher(request: CoreTask.fetchAllTasks(), context: managedObjectContext)
            .sink(
                receiveCompletion: {
                    print("Completion from fetchItemsAll")
                    print($0)
                },
                receiveValue: { [weak self] tasks in
                    self?.allTasks = tasks
                })
            .store(in: &cancellableSet)
        
    }
    
    // MARK: - Reload data in view
    
    func reloadData() {
        CDPublisher(request: CoreTask.fetchAllTasks(), context: managedObjectContext)
            .sink(
                receiveCompletion: {
                    print("Reloaded data")
                    print($0)
                },
                receiveValue: { [weak self] tasks in
                    self?.allTasks = tasks
                })
            .store(in: &cancellableSet)
    }
    
}
