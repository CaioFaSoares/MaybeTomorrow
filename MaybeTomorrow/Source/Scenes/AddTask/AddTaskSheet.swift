//
//  AddTaskSheet.swift
//  MaybeTomorrow
//
//  Created by Caio Soares on 27/05/23.
//

import SwiftUI

struct AddTaskSheet: View {
    
    internal init(taskCount: Int) {
        self.viewModel = AddTaskSheetViewModel(taskCount: taskCount)
    }
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: AddTaskSheetViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Adding Task #\(viewModel.taskCount)!")
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
                        Text(LocalizedStringKey(stringLiteral: "\(level.emoji)"))
                            .shadow(radius: CGFloat(level.color == viewModel.draftTask.taskLevel.color ? 0 : 100))
//                            .foregroundColor(Color.black)
                    })
//                    .padding(.all)
                    .buttonStyle(taskButtonStyle(level: level,
                                                 selectedLevel: viewModel.draftTask.taskLevel))
                }
            }
            .padding(.all)
//            .scaledToFit()
            switch viewModel.draftTask.taskLevel {
            case .Unselected:
                Text("When should we start bothering you?")
            default:
                Text("We'll start bothering you \(viewModel.draftTask.taskLevel.days) days before that.")
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
        AddTaskSheet(taskCount: 0)
    }
}
