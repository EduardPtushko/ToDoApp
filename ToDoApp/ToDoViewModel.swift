//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Eduard Ptushko on 18.12.2023.
//

import Foundation

@Observable
final class ToDoViewModel {
    var toDos: [ToDo] = []

    func load() {
        if let savedTodos = ToDo.loadToDos() {
            toDos = savedTodos
        } else {
            toDos = ToDo.loadSampleToDos()
        }
    }
}
