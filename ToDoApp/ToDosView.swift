//
//  ToDosView.swift
//  ToDoApp
//
//  Created by Eduard Ptushko on 18.12.2023.
//

import SwiftUI

struct ToDosView: View {
    @Environment(\.dismiss)
    var dismiss
    @State private var toDoVM = ToDoViewModel()
    @State private var showingNewTodo = false
    @State private var todoItem: ToDo?
    @State var editMode: EditMode = .inactive
    @State private var searchText = ""
    @State private var filteredToDos: [ToDo] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(searchText.isEmpty ? $toDoVM.toDos : $filteredToDos) { $todo in
                    Button {
                        if editMode == .inactive {
                            todoItem = todo
                        }
                    } label: {
                        HStack {
                            Toggle("", isOn: $todo.isComplete)
                                .toggleStyle(CheckboxToggleStyle())
                            Text(todo.title)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    toDoVM.toDos.remove(atOffsets: indexSet)
                })
            }

            .listStyle(.inset)
            .navigationTitle("My To-Dos")
            .onAppear {
                toDoVM.load()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    EditButton()
                }
                ToolbarItem(placement: .principal) {
                    Text("")
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingNewTodo.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $showingNewTodo) {
                NewToDoView()
                    .environment(toDoVM)
            }
            .sheet(item: $todoItem) { todo in
                NewToDoView(todo: todo)
                    .environment(toDoVM)
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { _, _ in
            filteredToDos = toDoVM.toDos.filter { $0.title.hasPrefix(searchText) }
        }
    }
}

#Preview {
    ToDosView()
}
