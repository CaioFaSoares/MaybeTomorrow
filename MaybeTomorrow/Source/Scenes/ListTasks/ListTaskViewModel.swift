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
    
    init() {
        self.loadData()
    }
    
    // MARK: - Functionality
    
    @Published var showingSheet = false
    @Published var allTasks = [CoreTask]()
    
    func raiseSheet() {
        showingSheet.toggle()
    }
    
    // MARK: - Initing CK Stuff
    
    var managedObjectContext: NSManagedObjectContext {
        PersistenceController.shared.container.viewContext
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
    
    func loadData() {
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
    
}
