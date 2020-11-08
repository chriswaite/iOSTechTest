//
//  TaskList.swift
//  UITestTechTest
//
//  Created by Alan Nichols on 7/30/18.
//  Copyright © 2018 Just Eat. All rights reserved.
//

import Foundation

enum TaskStatus {
    case toDo
    case completed
}

struct Task {
    var taskName: String
    var taskStatus: TaskStatus
}

class TaskList {
    
    static let shared = TaskList()
    
    var activeTaskList = [Task]()
    var archivedTaskList = [Task]()
    
    init() {
        if ProcessInfo.processInfo.arguments.contains("CONFIGURE_TEST_DATA") {
            configureTestData()
        }
    }
    
    func addTask(taskName: String) {
        activeTaskList.append(Task(taskName: taskName, taskStatus: .toDo))
    }
    
    func setTaskAsCompleted(atIndex: Int) {
        guard atIndex >= 0 else { return }
        let task = activeTaskList[atIndex]
        activeTaskList[atIndex] = Task(taskName: task.taskName, taskStatus: .completed)
    }
    
    func deleteActiveTask(atIndex: Int) {
        guard atIndex >= 0 else { return }
        activeTaskList.remove(at: atIndex)
    }
    
    func archiveCompletedTasks() {
        let completedTasks = activeTaskList.filter{ $0.taskStatus == .completed }
        let openTasks = activeTaskList.filter{ $0.taskStatus == .toDo }
        
        activeTaskList = openTasks
        
        for task in completedTasks {
            archivedTaskList.append(task)
        }
    }
    
    private func configureTestData() {
        addTask(taskName: "Test 1")
        addTask(taskName: "Test 2")
        addTask(taskName: "Test 3")
        addTask(taskName: "Test 4")
        addTask(taskName: "Test 5")
    }
}
