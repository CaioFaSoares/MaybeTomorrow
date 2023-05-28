//
//  AddTaskSheet.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI

struct AddTaskSheet: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = AddTaskSheetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Adding New Task!")
                    .padding(.all)
                    .frame(alignment: .leading)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            TextField("Task Name", text: $viewModel.draftTask.taskName)
                .textFieldStyle(.roundedBorder)
                .padding(.all)
            DatePicker("Due date", selection: $viewModel.draftTask.taskDueData, displayedComponents: .date)
                .datePickerStyle(.compact)
//                .padding(.all)
                .scaledToFit()
            HStack {
                ForEach(taskImportanceLevels.allCases.filter({ $0.rawValue != -1 }), id: \.id) { level in
                    Button(action: {
                        viewModel.draftTask.taskLevel = level
                    }, label: {
                        Text(LocalizedStringKey(stringLiteral: "\(level)"))
                            .foregroundColor(Color.black)
                    })
//                    .padding(.all)
                    .buttonStyle(taskButtonStyle(levelColor: level.color,selectedLevel: viewModel.draftTask.taskLevel))
                }
            }
            .padding(.all)
//            .scaledToFit()
            switch viewModel.draftTask.taskLevel {
            case .Simple:
                Text("We'll start bothering you 2 days before that.")
            case .Medium:
                Text("We'll start bothering you 5 days before that.")
            case .Hard:
                Text("We'll start bothering you 7 days before that.")
            case .Complex:
                Text("We'll start bothering you 10 days before that.")
            default:
                Text("When should we start bothering you?")
            }
            Button {
                viewModel.submitTask()
                dismiss()
            } label: {
                Text("Add Task")
                    .fontWeight(.bold)
            }
            .padding(.all)
            .buttonStyle(.bordered)

        }
//        .padding(.all)
    }
}

struct AddTaskSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskSheet()
    }
}
