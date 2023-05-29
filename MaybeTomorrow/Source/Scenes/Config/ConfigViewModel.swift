//
//  ConfigViewModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 28/05/23.
//

import Foundation

import CoreData
import Combine

class ConfigViewModel: ObservableObject {
    
    init(_ root: rootModel) {
        self.rm = root
    }
    
    // MARK: - Functionality
    
    public var rm: rootModel
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    @Published var allTasks = [CoreTask]()
    
    // MARK: - Core Data manipulation.

    func nukeTasks() {
        rm.allTasks.forEach(rm.managedObjectContext.delete)
        
    }
    
    func nukeAndSave() {
        self.nukeTasks()
        PersistenceController.shared.saveContext()
    }
    
    func setDefaultLevel() {
        
    }
    
}
