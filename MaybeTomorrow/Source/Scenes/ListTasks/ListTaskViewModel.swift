//
//  ListTaskViewModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation

import CoreData
import Combine

class ListTaskViewModel: ObservableObject {
    
    init(_ root: rootModel) {
        self.rm = root
    }
    
    // MARK: - Functionality
    
    public var rm: rootModel
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    @Published var showingSheet = false
    
    func raiseSheet() {
        showingSheet.toggle()
    }
    
    // MARK: - Core Data state mutations.
    
    func archiveTask(_ task: CoreTask) {
        task.toggleArchival()
        PersistenceController.shared.saveContext()
    }
    
    func concludeTaskAndArchive(_ task: CoreTask) {
        task.toggleDone()
        task.toggleArchival()
        PersistenceController.shared.saveContext()
    }
    
}
