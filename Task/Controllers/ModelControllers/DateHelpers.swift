//
//  DateHelpers.swift
//  Task
//
//  Created by Greg Hughes on 12/5/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import Foundation
extension Date{
    func stringvalue() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}
