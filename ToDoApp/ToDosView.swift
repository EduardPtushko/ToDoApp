//
//  ToDosView.swift
//  ToDoApp
//
//  Created by Eduard Ptushko on 18.12.2023.
//

import SwiftUI

struct ToDosView: View {
    @State private var toDoVM = ToDoViewModel()
    @State private var showingNewTodo = false
    @Environment(\.dismiss)
    var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(toDoVM.toDos) { todo in
                    Text(todo.title)
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
            .sheet(isPresented: $showingNewTodo) {
                NewToDoView()
            }
        }
    }
}

#Preview {
    ToDosView()
}
