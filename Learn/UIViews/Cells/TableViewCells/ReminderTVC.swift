//
//  ReminderTVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 02/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit
import EventKit

class ReminderTVC: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: EKReminder){
        self.lblTitle?.text = data.title
        let formatter:DateFormatter = DateFormatter();
        formatter.dateFormat = "yyyy-MM-dd";
        if let dueDate = data.dueDateComponents?.date{
            self.lblDate.text = formatter.string(from: dueDate);
        }else{
            self.lblDate.text = "N/A";
        }
        
    }
    
}
