//
//  RootModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 29/05/23.
//

import Foundation

import Combine
import CoreData

class rootModel: ObservableObject {
    
    init() {
        self.loadData()
    }
    
    // MARK: - Functionality
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    @Published var allTasks = [CoreTask]()
    
    // MARK: - Initing CK Stuff
    
    var managedObjectContext: NSManagedObjectContext {
        PersistenceController.shared.container.viewContext
    }
    
    // MARK: - Data Container manipulation
    // TODO: Implement this somehow.
//    func executioner(_ task: ( ) -> Void) {
//        
//    }
    
    // MARK: - Data Container fetching through Publisher to Combine
    
    func loadData() {
        CoreTaskPublisher(request: CoreTask.fetchAllTasks(), context: managedObjectContext)
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
    
    func reloadData() {
        managedObjectContext.reset()
        self.loadData()
    }
    
}
