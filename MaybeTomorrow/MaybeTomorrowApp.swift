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
    
    @StateObject private var model: listTaskViewModel
    
    init(listViewModel: listTaskViewModel) {
        _model = StateObject(wrappedValue: listViewModel)
    }
    
    init() {
        _model = StateObject(wrappedValue: listTaskViewModel())
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    HomeView()
//                        .environment(\.managedObjectContext, model.managedObjectContext)
//                        .environmentObject(model)
                }.tabItem {
                    Image(systemName: "book.closed.fill")
                    Text("Home")
                }
                NavigationStack {
                    ListTaskView()
                        .environment(\.managedObjectContext, model.managedObjectContext)
                        .environmentObject(model)
                }.tabItem {
                    Image(systemName: "books.vertical")
                    Text("List")
                }
            }
        }
    }
}
