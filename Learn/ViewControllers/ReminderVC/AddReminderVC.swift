//
//  AddReminderVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 02/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0


class AddReminderVC : BaseVC{
    
    
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    
    
    override func viewDidLoad() {
        //
        
    }
    
    @IBAction func setStartTime(_ sender: UIButton) {
        
        let datePicker = ActionSheetDatePicker(title: "DateAndTime:", datePickerMode: UIDatePickerMode.time, selectedDate: Date(), doneBlock: {
            picker, value, index in
            
            print("value = \(value!)")
            print("index = \(index!)")
            print("picker = \(picker!)")
            return
        }, cancel: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        let secondsInWeek: TimeInterval = 7 * 24 * 60 * 60;
        datePicker?.minimumDate = Date(timeInterval: -secondsInWeek, since: Date())
        datePicker?.maximumDate = Date(timeInterval: secondsInWeek, since: Date())
        datePicker?.minuteInterval = 20
        
        datePicker?.show()
        
    }
    
    @IBAction func setEndTime(_ sender: Any) {
        
    }
    
    
    
    
    
    
}
