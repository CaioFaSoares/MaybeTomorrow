//
//  ListTaskViewModel.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import Foundation
import SwiftUI
import CoreData

class listTaskViewModel: ObservableObject {
    
    // MARK: - Functionality
    
    static let shared = listTaskViewModel()
    
    @Published var showingSheet = false
    
    // MARK: - Initing CK Stuff
    
    init() {
        self.context = PersistenceController.shared.container.viewContext
    }
    
    var context: NSManagedObjectContext
    
    private let persistenceController = PersistenceController.shared
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CoreTask.timestamp, ascending: true)],
        animation: .default)
    public var tasks: FetchedResults<CoreTask>
    
    // MARK: - List Functionality
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(context.delete)

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
    
    func raiseSheet() {
        showingSheet.toggle()
    }
    
}
