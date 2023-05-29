//
//  CoreTask Extension.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 28/05/23.
//

import Foundation
import CoreData

extension CoreTask {
    
    @nonobjc public class func fetchAllTasks() -> NSFetchRequest<CoreTask> {
        let name = "\(Self.self)"
        print("Running fetch request \(name) for all")
        let request = NSFetchRequest<CoreTask>(entityName: name)
        request.sortDescriptors = []
        return request
    }
    
    func toggleArchival() {
        self.isArchived.toggle()
    }
    
    
    func toggleDone() {
        self.isDone.toggle()
    }
    
}
