//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Greg Hughes on 12/5/18.
//  Copyright © 2018 Greg Hughes. All rights reserved.
//

import UIKit



class ButtonTableViewCell: UITableViewCell {

    
    @IBOutlet weak var primaryLabel: UILabel!
    
    @IBOutlet weak var completeButton: UIButton!
    
    
    weak var delegate: ButtonTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
        
    }
    
    
}


extension ButtonTableViewCell{
    
    func updateButton(_ isComplete: Bool){
        if isComplete == true{
            
            completeButton.setImage(UIImage(named: "complete"), for: .normal)
            
        } else {
            
            completeButton.setImage(UIImage(named: "incomplete"), for: .normal)
        }
    }
    
    func update(withTask task: Task){
        primaryLabel.text = task.name
        updateButton(task.isComplete)
        
    }
    
}

protocol ButtonTableViewCellDelegate: class {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
    
}

