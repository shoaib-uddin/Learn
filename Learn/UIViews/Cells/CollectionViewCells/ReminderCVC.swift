//
//  ReminderCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 03/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class ReminderCVC: UICollectionViewCell {

    @IBOutlet weak var reSwitch: UISwitch!
    @IBOutlet var LabelsPlural: [UILabel]!
    @IBOutlet weak var lbl3x: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var startTimeDp: UIDatePicker!
    @IBOutlet weak var endTimeDp: UIDatePicker!
    
    let cnter = UNUserNotificationCenter.current();
    let options: UNAuthorizationOptions = [.alert, .sound];
    
    var xArray: [String] = ["1x", "2x", "3x", "4x", "5x", "6x", "7x", "8x", "9x"];
    private enum DatePickerProperties: String {
        case TextColor = "textColor"
        case HighlightsToday = "highlightsToday"
    }
    
    // MARK: - Helping content
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // setting x in loop
        
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        let bclr = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        
        lbl3x.text = xArray[2];
        
        plusBtn.setTitleColor(clr, for: .normal);
        plusBtn.setBorder(color: clr, radius: 0, width: 1);
        minusBtn.setTitleColor(clr, for: .normal);
        minusBtn.setBorder(color: clr, radius: 0, width: 1);
        
        
        self.startTimeDp.setValue(clr, forKey: DatePickerProperties.TextColor.rawValue)
        self.startTimeDp.setValue(false, forKey: DatePickerProperties.HighlightsToday.rawValue)
        self.endTimeDp.setValue(clr, forKey: DatePickerProperties.TextColor.rawValue)
        self.endTimeDp.setValue(false, forKey: DatePickerProperties.HighlightsToday.rawValue)
        startTimeDp.timeZone = TimeZone(identifier: "UTC")
        endTimeDp.timeZone = TimeZone(identifier: "UTC");
        
        
        
        
        for all in LabelsPlural as! [UILabel]{
            all.textColor = clr
        }
        
        
        
    }
    
    
    
    
    @IBAction func minusRepeatCount(_ sender: UIButton) {
        
        turnOffSwitch()
        
        let setValue = lbl3x.text!;
        let index = xArray.index { (v) -> Bool in
            return v == setValue;
        }
        
        if(!(index! <= 0)){
            
            print(index, xArray[index!]);
            let t = xArray[index! - 1]
            lbl3x.text = t;
        }
        
    }
    
    @IBAction func plusRepeatCount(_ sender: UIButton) {
        
        turnOffSwitch()
            
        let setValue = lbl3x.text!;
        let index = xArray.index { (v) -> Bool in
            return v == setValue;
        }
        
        if(!(index! >= 8)){
            
            print(index, xArray[index!]);
            let t = xArray[index! + 1]
            lbl3x.text = t;
        }
        
    }
    
    @IBAction func doOnDailyReminder(_ sender: UISwitch) {
        
        print(sender.isOn);
        if(sender.isOn){
            
            print("turn on random facts");
            let userModel = CoreDataHelper.returnUser();
            LearnottoApi.getRandomFacts(userModel.id!, completion: { (success, data) in
                if(success){
                    
                    // set Data in CoreData
                    print(data);
                    self.setManyRemindersWithTime(data: data!);
                    
                    
                }
            })
            
        }else{
            
            print("turn off random facts");
            
        }
        
        
        
        
    }
    
    @IBAction func doChangeStartTime(_ sender: UIDatePicker) {
        
        turnOffSwitch()
        print(sender.date)
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date);
        let hour = components.hour!
        let minute = components.minute!
        
        sender.date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
        
        if(endTimeDp.date < sender.date){
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .hour, value: getRepeatCount(), to: sender.date)
            endTimeDp.date = date!;
        }
        
        
        
        
        
        
        
    }
    
    @IBAction func doChangeEndTIme(_ sender: UIDatePicker) {
        
        turnOffSwitch()
        print(sender.date);
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: sender.date);
        let hour = components.hour!
        let minute = components.minute!
        
        sender.date = Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
        
        if(startTimeDp.date > sender.date){
            let calendar = Calendar.current
            let date = calendar.date(byAdding: .hour, value: -getRepeatCount(), to: sender.date)
            startTimeDp.date = date!;
        }
        
        
        
    }
    
    fileprivate func turnOffSwitch(){
        self.reSwitch.setOn(false, animated: true);
    }
    
    fileprivate func getRepeatCount() -> Int{
        
        let getValue = lbl3x.text!;
        let index = xArray.index { (v) -> Bool in
            return v == getValue;
        }
        
        return index! + 1;
    }
    
    func setManyRemindersWithTime(data: [EnFact]){
        
        let repeatCount = getRepeatCount();
        print(repeatCount);
        print(data.count);
        let currentDateTime = UtilityHelper.getCurrentDateTime();
        print(currentDateTime);
        
        let startTIme = startTimeDp.date
        let endTIme = endTimeDp.date
        
        print(startTIme);
        print(endTIme);
        
        let ti : TimeInterval = endTIme.timeIntervalSince(startTIme);
        let betweenminutes: Int = Int(ti / 60);
        print(betweenminutes);
        
        let minDistance = Int(betweenminutes / repeatCount);
        print(minDistance);
        
        
        var dateArray: [Date] = [Date]();
        var newStartTime = startTIme;
        var newEndTime = endTIme;
        
        for indec in 0...23{
            
            let calendar = Calendar.current;
            newStartTime = calendar.date(byAdding: .minute, value: minDistance, to: newStartTime)!;
            print("peep", newStartTime)
//            if(newStartTime < newEndTime){
//                dateArray.append(newStartTime);
//
//                print("peep2", newStartTime)
//            }else{
//
//            }
            
            
            
            
        }
        
        print(dateArray);
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        for (index, dict) in data.enumerated(){
//
//            print(index, dict);
//
//            let content = UNMutableNotificationContent()
//            content.title = "New Random Fact : \(dict.Reference!)";
//            content.body = dict.Content!;
//            content.sound = UNNotificationSound.default()
//
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(10 + 2*index), repeats: false)
//
//            let identifier = "learn.id.\(dict.ID!)";
//            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
//
//            cnter.add(request, withCompletionHandler: { (error) in
//                if let error = error {
//                    // Something went wrong
//                }
//
//                print("delivered");
//
//            })
//
//        }
        
        
    }
    
    func returnNoOfMinutesOnly(start: Date, end: Date){
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
