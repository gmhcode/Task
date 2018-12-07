//
//  TaskController.swift
//  Task
//
//  Created by Greg Hughes on 12/5/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import Foundation
import CoreData

class TaskController{
    
    
    
    static var shared = TaskController()
    
//    var tasks : [Task] = [] {
//        didSet {
//            print(tasks.count, "😈")
//        }
//    }
    
    
    
    let fetchedResultsController : NSFetchedResultsController <Task> = {
        
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "isComplete", ascending: true)]
        request.sortDescriptors = [NSSortDescriptor(key: "dueDate", ascending: true)]
        
        
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
    }()
    
    
    init(){
        //        self.tasks = fetchTasks()
        do{
         try fetchedResultsController.performFetch()
        }
        catch{
            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
        }
            
            
    }
  
    
    var mockTasks: [Task] {
        
        let task1 = Task(name: "task 2", notes: "ad", dueDate: Date(timeIntervalSinceNow: 2000), context: CoreDataStack.context, isComplete: true)
        let task2 = Task(name: "task 3", notes: "asd", dueDate: Date(timeIntervalSinceNow: 2000), context: CoreDataStack.context, isComplete: true)
        let task3 = Task(name: "task 1", notes: "a", dueDate: Date(timeIntervalSinceNow: 2000), context: CoreDataStack.context, isComplete: true)
        let task4 = Task(name: "task 4", notes: "da", dueDate: Date(timeIntervalSinceNow: 2000), context: CoreDataStack.context, isComplete: true)
        
        return [task1, task2, task3, task4]
    }
    
    
    func toggleIsCompleteFor(task: Task){
        task.isComplete.toggle()
    }
    
    
    func add(taskWithName name: String, notes: String?, dueDate: Date?, isComplete: Bool){
        
        Task(name: name, notes: notes, dueDate: dueDate, isComplete: false)
        saveToPersistentStore()
        
    }
    
    
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?){
        
        task.dueDate = dueDate
        task.name = name
        task.notes = notes
        saveToPersistentStore()
        
    }
    
    
    
    
    func remove(task: Task){
        
        CoreDataStack.context.delete(task)
        saveToPersistentStore()
//        tasks = self.fetchTasks()
    }
    
    
    
    func saveToPersistentStore(){
        
        do{
            
        try CoreDataStack.context.save()
            
        } catch{
            
            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
            
        }
    }
    
    
    
//    func fetchTasks() -> [Task]{
//
//        let request : NSFetchRequest<Task> = Task.fetchRequest()
//
//        do{
//        return try CoreDataStack.context.fetch(request)
//        }catch{
//            print("There was an error in \(#function) \(error) : \(error.localizedDescription)")
//            return []
//        }
//
//
//        //TODO: - Delete this return and un comment ^^
//    }
    
}
