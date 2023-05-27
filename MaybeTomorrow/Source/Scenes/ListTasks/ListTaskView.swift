//
//  ListTaskView.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI


struct ListTaskView: View {
    
    @EnvironmentObject var viewModel: listTaskViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.allTasks) { task in
                    NavigationLink {
                        
                    } label: {
                        Text("\(task.name ?? "") | \(task.timestamp ?? Date.now)")
                    }
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: viewModel.raiseSheet) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
        .sheet(isPresented: $viewModel.showingSheet) {
            AddTaskSheet()
                .onDisappear() {
                    viewModel.reloadData()
                }
        }
    }
}

struct ListTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ListTaskView()
    }
}
