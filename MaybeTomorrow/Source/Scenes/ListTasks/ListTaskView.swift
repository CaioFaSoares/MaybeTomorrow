//
//  ListTaskView.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI


struct ListTaskView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(
            keyPath: \CoreTask.timestamp,
            ascending: true)],
        animation: .default)
    var tasks: FetchedResults<CoreTask>
    
    @ObservedObject var viewModel = listTaskViewModel.shared
    
    var body: some View {
        NavigationView {
            List {
                ForEach() { task in
                    NavigationLink {
                        
                    } label: {
                        Text("\(task.name!) | \(task.level)")
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
        }
    }
}

struct ListTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ListTaskView()
    }
}
