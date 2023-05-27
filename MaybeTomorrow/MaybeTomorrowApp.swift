//
//  MaybeTomorrowApp.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI

@main
struct MaybeTomorrowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ListTaskView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
