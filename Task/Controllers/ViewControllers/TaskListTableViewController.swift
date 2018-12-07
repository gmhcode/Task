//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Greg Hughes on 12/6/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        
    
            guard let indexPath = tableView.indexPath(for: sender) else {return}
            
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            
            TaskController.shared.toggleIsCompleteFor(task: task)
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
            //THIS
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       TaskController.shared.fetchedResultsController.delegate = self
    }

    // MARK: - Table view data source
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return TaskController.shared.fetchedResultsController.sections?.count ?? 0
    }
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sectionInfo = TaskController.shared.fetchedResultsController.sections?[section] else { fatalError("No sections in fetchedResultsController")}
        
        return sectionInfo.numberOfObjects
    }
    
  

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell
        
        let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
        
        cell?.delegate = self
        cell?.update(withTask: task)
        return cell ?? UITableViewCell()
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let sectionInfo = TaskController.shared.fetchedResultsController.sections?[section] else {return nil}
        switch sectionInfo.name {
        case "0": return "Incomplete"
        case "1": return "Complete"
        default: return ""
            
        }
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
            
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath)
            
            TaskController.shared.remove(task: task)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        i
        if segue.identifier == "taskSegue"{
            //        i
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            //        d
            let destinationVC = segue.destination as? TaskDetailTableViewController
            //        o
            guard let taskTakeOff = TaskController.shared.fetchedResultsController.fetchedObjects? [indexPath.row] else {return}
            //        o
            destinationVC?.taskLandingPad = taskTakeOff
            
            destinationVC?.dueDateValue = taskTakeOff.dueDate
        }
    }
}


extension TaskListTableViewController: NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        case .insert:
            guard let newIndexPath = indexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .fade)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .fade)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        tableView.endUpdates()
        }
        
       
    }
}

