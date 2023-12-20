//
//  NewToDoView.swift
//  ToDoApp
//
//  Created by Eduard Ptushko on 19.12.2023.
//

import SwiftUI

struct NewToDoView: View {
//    @Bindable var toDoVM: ToDoViewModel
    @Environment(ToDoViewModel.self) private var toDoVM
    var todo: ToDo?
    @Environment(\.dismiss)
    var dismiss
    @State private var isComplete = false
    @State private var title = ""
    @State private var dueDate = Date().addingTimeInterval(24 * 60 * 60)
    @State private var notes = ""
    @State private var isDatePickerSectionOpen = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information".uppercased()) {
                    HStack {
                        Toggle("", isOn: $isComplete)
                            .toggleStyle(CheckboxToggleStyle())

                        TextField("Remind me...", text: $title)
                    }
                }

                Section {
                    Button {
                        withAnimation {
                            isDatePickerSectionOpen.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Due Date")
                            Spacer()
                            Text(dueDate.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute()))
                        }
                        .tint(.black)
                    }

                    if isDatePickerSectionOpen {
                        DatePicker("Due Date", selection: $dueDate)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(width: 260)
                            .clipped()
                    }
                }

                Section {
                    TextEditor(text: $notes)
                } header: {
                    Text("Notes")
                        .textCase(.uppercase)
                }
            }
            .formStyle(.grouped)
            .onAppear {
                if let todo {
                    isComplete = todo.isComplete
                    title = todo.title
                    dueDate = todo.dueDate
                    notes = todo.notes ?? ""
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(todo == nil ? "New ToDo" : "To-Do")
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let todo {
                            if let index = toDoVM.toDos.firstIndex(where: { $0.id == todo.id }) {
                                toDoVM.toDos[index].title = title
                                toDoVM.toDos[index].isComplete = isComplete
                                toDoVM.toDos[index].dueDate = dueDate
                                toDoVM.toDos[index].notes = notes
                            }
                        } else {
                            let toDo = ToDo(
                                title: title,
                                isComplete: isComplete,
                                dueDate: dueDate,
                                notes: notes
                            )
                            toDoVM.toDos.append(toDo)
                        }

                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    NewToDoView()
        .environment(ToDoViewModel())
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .font(.title)
        }
    }
}
