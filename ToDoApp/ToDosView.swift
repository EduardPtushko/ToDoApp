//
//  ToDosView.swift
//  ToDoApp
//
//  Created by Eduard Ptushko on 18.12.2023.
//

import SwiftUI

struct ToDosView: View {
    @State private var toDos: [ToDo] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(toDos) { todo in
                    Text(todo.title)
                }
            }
            .listStyle(.inset)
            .navigationTitle("My To-Dos")
            .onAppear {
                if let savedTodos = ToDo.loadToDos() {
                    toDos = savedTodos
                } else {
                    toDos = ToDo.loadSampleToDos()
                }
            }
        }
    }
}

#Preview {
    ToDosView()
}
