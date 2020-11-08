//
//  ArchivedTasksViewController.swift
//  UITestTechTest
//
//  Created by Alan Nichols on 7/30/18.
//  Copyright © 2018 Just Eat. All rights reserved.
//

import UIKit

class ArchivedTasksViewController: UIViewController {

    @IBOutlet weak var completedTasksTableView: UITableView!
    @IBOutlet weak var completedTasksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelCount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.completedTasksTableView.reloadData()
        setLabelCount()
    }
    
    private func setLabelCount() {
        let completedTasksCount = TaskList.shared.archivedTaskList.count
        guard completedTasksCount != 1 else {
            completedTasksLabel.text = "1 task completed!"
            return
        }
        completedTasksLabel.text = "\(completedTasksCount) tasks completed!"
    }
}

// MARK: - UITableView

extension ArchivedTasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskList.shared.archivedTaskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedTaskCell", for: indexPath)
        let task = TaskList.shared.archivedTaskList[indexPath.row]
        cell.textLabel?.text = task.taskName
        return cell
    }
}
