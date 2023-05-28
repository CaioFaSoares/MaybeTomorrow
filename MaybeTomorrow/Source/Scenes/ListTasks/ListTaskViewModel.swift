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
    
    private var cancellableSet: Set<AnyCancellable> = []
    
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

    func deleteItems(offsets: IndexSet) {
        offsets.map { allTasks[$0] }.forEach(managedObjectContext.delete)
        PersistenceController.shared.saveContext()
    }
    
    // MARK: - Load and reload data in view
    
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
