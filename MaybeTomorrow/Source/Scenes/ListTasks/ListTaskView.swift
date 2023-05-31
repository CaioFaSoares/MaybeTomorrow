//
//  ListTaskView.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI


struct ListTaskView: View {
    
    init(_ root: rootModel) {
        self.viewModel = ListTaskViewModel(root)
    }
    
    @ObservedObject private var viewModel: ListTaskViewModel
    
    @State private var sheetHeight: CGFloat = .zero
    
    var body: some View {
        List {
            ForEach(viewModel.rm.allTasks.filter { $0.isArchived == false && $0.isDone == false } ) { task in
                NavigationLink {
                    
                } label: {
                    Text("\(task.name ?? "") | \(task.timestamp ?? Date.now)")
                }
                .swipeActions(edge: .trailing,
                              allowsFullSwipe: true
                ) {
                    Button (role: .destructive) {
                        withAnimation {
                            viewModel.concludeTaskAndArchive(task)
                        }
                    } label: {
                        Label("Conclude", systemImage: "checkmark.fill")
                    }
                    .tint(.green)

                }
                .swipeActions(edge: .trailing,
                              allowsFullSwipe: false
                ) {
                    Button (role: .destructive) {
                        withAnimation {
                            viewModel.archiveTask(task)
                        }
                    } label: {
                        Label("Archive", systemImage: "archivebox.fill")
                    }
                    .tint(.brown)

                }
            }
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
            AddTaskSheet(taskCount: viewModel.rm.allTasks.count)
                .onDisappear() {
                    withAnimation {
                        viewModel.rm.loadData()
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

//struct ListTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListTaskView(rm)
//    }
//}
