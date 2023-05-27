//
//  AddTaskSheetModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import CoreData
import SwiftUI

class AddTaskSheetViewModel: ObservableObject {
    
    // MARK: - Initing the draft task
    
    @Published var draftTask = Task(
        taskName: "Task ",
        taskDueData: .now,
        taskLevel: .Medium)
    
    // MARK: - Initing CK Stuff
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    var context: NSManagedObjectContext
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CoreTask.timestamp, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<CoreTask>
    
    // MARK: - Methods
    
    /// submits the drafted task to ck
    func submitTask() {
        withAnimation {
//            let newItem = Item(context: viewContext)
            let newItem = CoreTask(context: context)
            newItem.timestamp = draftTask.taskDueData
            newItem.name = draftTask.taskName
            newItem.level = Int16(draftTask.taskLevel.rawValue)

            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
