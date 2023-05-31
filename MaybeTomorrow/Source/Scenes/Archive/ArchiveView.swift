//
//  ArchivalView.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 28/05/23.
//

import SwiftUI

struct ArchiveView: View {
    
    init(_ root: rootModel) {
        self.viewModel = ArchiveViewModel(root)
    }
    
    @ObservedObject private var viewModel: ArchiveViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.rm.allTasks.filter {$0.isArchived == true} ) { task in
                    Group {
                        ZStack {
                            Color.accentColor.clipShape(RoundedRectangle(cornerRadius: 10))
                                
                        }.frame(idealWidth: UIScreen.main.bounds.width / 2, idealHeight: UIScreen.main.bounds.width / 2)
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            print("[\(type(of: self))]: Aha!")
                        } label: {
                            Label("Filter", systemImage:  "line.3.horizontal.decrease.circle")
                        }

                    }

                }
            }
        }
    }
}

//struct ArchivalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchivalView()
//    }
//}
