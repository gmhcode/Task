//
//  Task+Convenience.swift
//  Task
//
//  Created by Greg Hughes on 12/5/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import Foundation
import CoreData

extension Task{
    
    @discardableResult
    convenience init(name: String, notes: String?, dueDate: Date?, context: NSManagedObjectContext = CoreDataStack.context, isComplete: Bool? ){
        
        self.init(context: context)
        self.notes = notes
        self.dueDate = dueDate
        self.name = name
        self.isComplete = isComplete ?? false
        
    }
    
}
