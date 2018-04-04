//
//  ReminderCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 03/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class ReminderCVC: UICollectionViewCell {

    @IBOutlet var LabelsPlural: [UILabel]!
    @IBOutlet weak var lbl3x: UILabel!
    @IBOutlet weak var plusminus: UISegmentedControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        let bclr = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        
        plusminus.tintColor = bclr;
        for all in LabelsPlural as! [UILabel]{
            all.textColor = clr
        }
        
    }
    
    @IBAction func doOnDailyReminder(_ sender: UISwitch) {
        
        
        
    }
    
    @IBAction func doRepeatReminder(_ sender: UISegmentedControl) {
        
        
        
        
    }
    
    @IBAction func doChangeStartTime(_ sender: UIDatePicker) {
        
        
        
        
    }
    
    @IBAction func doChangeEndTIme(_ sender: UIDatePicker) {
        
        
        
    }
    
    
    
    
    
    
    
    
    
    

}
