//
//  ListTaskView.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI


struct ListTaskView: View {
    
    @EnvironmentObject var viewModel: listTaskViewModel
    
    @State private var showSheet = false
    @State private var sheetHeight: CGFloat = .zero
    
    var body: some View {
        List {
            ForEach(viewModel.allTasks) { task in
                NavigationLink {
                    
                } label: {
                    Text("\(task.name ?? "") | \(task.timestamp ?? Date.now)")
                }
            }
            .onDelete(perform: viewModel.deleteItems)
        }
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
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Tasks")
        .sheet(isPresented: $viewModel.showingSheet) {
            AddTaskSheet(taskCount: viewModel.allTasks.count)
                .onDisappear() {
                    withAnimation {
                        viewModel.reloadData()
                    }
                }
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.preference(key: InnerHeightPreferenceKey.self, value: geometry.size.height)
                    }
                }
                .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                    sheetHeight = newHeight
                }
                .presentationDetents([.height(sheetHeight)])
        }
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ListTaskView_Previews: PreviewProvider {
    static var previews: some View {
        ListTaskView()
    }
}
