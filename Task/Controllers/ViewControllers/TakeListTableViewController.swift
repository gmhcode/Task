//
//  TakeListTableViewController.swift
//  Task
//
//  Created by Greg Hughes on 12/5/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class TakeListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let task = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsCompleteFor(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        //THIS
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TaskController.shared.tasks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else {fatalError()}
        cell.update(withTask: TaskController.shared.tasks[indexPath.row])
        // Configure the cell...
        cell.delegate = self
        //WHY DOES THIS WORK WITHOUT
        
        return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let task = TaskController.shared.tasks[indexPath.row]
            
            TaskController.shared.remove(task: task)
            //^deletes object
            tableView.deleteRows(at: [indexPath], with: .fade)
            //deletes row
        }
    }
 

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        i
        if segue.identifier == "taskSegue"{
        //        i
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
        //        d
             let destinationVC = segue.destination as? TaskDetailTableViewController
        //        o
             let taskTakeOff = TaskController.shared.tasks[indexPath.row]
        //        o
            destinationVC?.taskLandingPad = taskTakeOff
            
            destinationVC?.dueDateValue = taskTakeOff.dueDate
        }
    }
    

}
