//
//  MaybeTomorrowApp.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI

@main
struct MaybeTomorrowApp: App {
    
    //    let persistenceController = PersistenceController.shared
    
    @StateObject private var model: rootModel
    
    init(rootModel: rootModel) {
        _model = StateObject(wrappedValue: rootModel)
    }
    
    init() {
        _model = StateObject(wrappedValue: rootModel())
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    HomeView(model)
                }.tabItem {
                    Image(systemName: "book.closed.fill")
                    Text("Home")
                }
                
                NavigationStack {
                    ListTaskView(model)
                }.tabItem {
                    Image(systemName: "books.vertical")
                    Text("Tasks")
                }
                
                NavigationStack {
                    ArchiveView(model)
                }.tabItem {
                    Image(systemName: "archivebox.fill")
                    Text("Archival")
                }
                
                NavigationStack {
                    ConfigView(model)
                }.tabItem {
                    Image(systemName: "gearshape.2.fill")
                    Text("Config")
                }
            }
        }
    }
}
