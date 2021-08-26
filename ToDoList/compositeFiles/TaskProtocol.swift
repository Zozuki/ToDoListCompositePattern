//
//  TaskProtocol.swift
//  ToDoList
//
//  Created by user on 26.08.2021.
//

import Foundation

protocol Task {
    var name: String { get }
    var subTasksDescription: (names: [String], countOfSubTasks: [Int]) { get }
    var countOfSubTasks: Int { get }
    func addSubTask(taskName: String)
}

class KernelTask: Task {
    
    var name: String
    var subTasks: [Task] = []
    var countOfSubTasks: Int { return subTasks.count }
    
    var subTasksDescription: (names: [String], countOfSubTasks: [Int]) {
        let names = subTasks.compactMap {$0.name}
        let count = subTasks.compactMap {$0.countOfSubTasks}
        return (names: names, countOfSubTasks: count)
    }
    
    init(name: String) {
        self.name = name
    }
    
    func addSubTask(taskName: String) {
        let task = KernelTask(name: taskName)
        subTasks.append(task)
    }
    
    
}
