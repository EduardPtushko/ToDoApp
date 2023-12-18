//
//  ToDo.swift
//  ToDoApp
//
//  Created by Eduard Ptushko on 18.12.2023.
//

import Foundation

struct ToDo: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?

    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        lhs.id == rhs.id
    }

    static func loadToDos() -> [ToDo]? {
        nil
    }

    static func loadSampleToDos() -> [ToDo] {
        let toDo1 = ToDo(
            title: "To-Do One",
            isComplete: false,
            dueDate: Date(),
            notes: "Notes 1"
        )
        let toDo2 = ToDo(
            title: "To-Do Two",
            isComplete: false,
            dueDate: Date(),
            notes: "Notes 2"
        )
        let toDo3 = ToDo(
            title: "To-Do Three",
            isComplete: false,
            dueDate: Date(),
            notes: "Notes 3"
        )

        return [toDo1, toDo2, toDo3]
    }
}
