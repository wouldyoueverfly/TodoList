//
//  Todo.swift
//  TodoList
//
//  Created by Ruslan Khusainov on 23.06.2025.
//

import Foundation

struct Todo {
    let title: String
    let isCompleted: Bool
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
