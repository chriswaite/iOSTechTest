//
//  ActiveTasksViewController.swift
//  UITestTechTest
//
//  Created by Alan Nichols on 7/30/18.
//  Copyright © 2018 Just Eat. All rights reserved.
//

import UIKit

class ActiveTasksViewController: UIViewController {
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var activeTasksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        archiveCompletedAndReloadData()
    }
    
    @IBAction func addTaskToList(_ sender: Any) {
        let alert = UIAlertController(title: "Add Task", message: "Add a new task to your list.", preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "Add Task Panel" // Added this identifier to help with UI tests
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (action) -> Void in
            
            guard
                let textFields = alert.textFields,
                let textField = textFields.first,
                let taskName = textField.text,
                taskName.count > 0
            else {return}
            
            
            
            TaskList.shared.addTask(taskName: taskName)
            self?.archiveCompletedAndReloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
        alert.addTextField(configurationHandler: {textField in textField.accessibilityIdentifier = "Add Task Text Field"})
    }
    
    
    private func archiveCompletedAndReloadData() {
        TaskList.shared.archiveCompletedTasks()
        taskTableView.reloadData()

        let activeTasksCount = TaskList.shared.activeTaskList.count
        guard activeTasksCount != 1 else {
            activeTasksLabel.text = "1 task active."
            return
        }
        activeTasksLabel.text = "\(activeTasksCount) tasks active."
    }
}

// MARK: - UITableView

extension ActiveTasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskList.shared.activeTaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        let task = TaskList.shared.activeTaskList[indexPath.row]
        cell.textLabel?.text = task.taskName
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (action, indexPath) in
            TaskList.shared.deleteActiveTask(atIndex: indexPath.row)
            self?.archiveCompletedAndReloadData()
        }
        
        let complete = UITableViewRowAction(style: .default, title: "Complete") { [weak self] (action, indexPath) in
            TaskList.shared.setTaskAsCompleted(atIndex: indexPath.row)
            self?.archiveCompletedAndReloadData()
        }
        complete.backgroundColor = UIColor.green
        
        return [complete, delete]
    }
}
