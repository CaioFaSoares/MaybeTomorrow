//
//  ConfigView.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 29/05/23.
//

import SwiftUI

struct ConfigView: View {
    
    init(_ root: rootModel) {
        self.viewModel = ConfigViewModel(root)
    }
    
    @ObservedObject private var viewModel: ConfigViewModel
    
    var body: some View {
        List {
            Section {
                Button {
                    viewModel.nukeTasks()
                } label: {
                    Label("Nuke Tasks", systemImage: "hazardsign")
                }
            } header: {
                Text("Configurations")
            }
            Section {
                Button {
                    viewModel.nukeTasks()
                } label: {
                    Label("Nuke Tasks", systemImage: "hazardsign")
                }
                Button {
                    viewModel.nukeAndSave()
                } label: {
                    Label("REALLY nuke tasks", systemImage: "hazardsign.fill")
                }
            } header: {
                Text("Debug Stuff!")
            }
        }
        .navigationTitle("Configs")
        .listStyle(.grouped)
    }
}
