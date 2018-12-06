//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Greg Hughes on 12/5/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    
    
    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var dueDateField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    
    
    var taskLandingPad : Task? {
        
        didSet {
             updateViews()
        }
        
    }
    
    var dueDateValue : Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       dueDateField.inputView = dueDatePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userTappedView))
        view.addGestureRecognizer(tapGesture)
        
        updateViews()
        
    }

    
    // MARK: - Table view data source

    func updateViews(){
        if let taskLandingPad = taskLandingPad {
            taskNameField?.text = taskLandingPad.name
            notesTextField?.text = taskLandingPad.notes
            dueDateField?.text = taskLandingPad.dueDate?.stringvalue()

        }
    }
 
    
    
    func updateTask(){
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        
        guard taskNameField.text != nil,
        
        let name = taskNameField.text,
        let dueDate = dueDateValue,
        let notes = notesTextField.text else {return}

        if let task = taskLandingPad {
            TaskController.shared.update(task: task, name: name, notes: notes, dueDate: dueDate)
        }
        else {
            TaskController.shared.add(taskWithName: name, notes: notes, dueDate: dueDate, isComplete: false )
        }
        navigationController?.popViewController(animated: true)
        updateViews()
    }
    
    
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        dueDateValue = dueDatePicker.date
        
        dueDateField.text =  dueDatePicker.date.stringvalue()
    }
    
    @objc func userTappedView(_ sender: Any) {
        view.resignFirstResponder()
        dueDateField.resignFirstResponder()
        taskNameField.resignFirstResponder()
        notesTextField.resignFirstResponder()
    }
    
    
  
}
