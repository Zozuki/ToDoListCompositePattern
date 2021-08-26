//
//  TaskProtocol.swift
//  ToDoList
//
//  Created by user on 26.08.2021.
//

import Foundation

protocol Task {
    var name: String { get }
    var subTasks: [Task] { get }
    var countOfSubTasks: Int { get }
    func addSubTask(taskName: String)
}

class KernelTask: Task {
    
    var name: String
    var subTasks: [Task] = []
    var countOfSubTasks: Int { return subTasks.count }
    
    init(name: String) {
        self.name = name
    }
    
    func addSubTask(taskName: String) {
        let task = KernelTask(name: taskName)
        subTasks.append(task)
    }
    
    
}
