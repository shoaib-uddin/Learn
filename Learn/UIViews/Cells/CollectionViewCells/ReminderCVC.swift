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
    
    fileprivate func getPreSettings(){
        
    }
    
    fileprivate func removeAllPendingNotifications(){
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
            var identifiers: [String] = []
            for notification:UNNotificationRequest in notificationRequests {
                if notification.identifier.contains("learn") {
                    identifiers.append(notification.identifier)
                }
            }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // setting x in loop
        
        // remove all reminders
        
        
        
        if(!reSwitch.isOn){
            removeAllPendingNotifications();
        }
        
        
        
        //
        
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
        
        startTimeDp.date = UtilityHelper.getCurrentDateTime();
        endTimeDp.date = UtilityHelper.getCurrentDateTime();
        
        if let seminder = CoreDataHelper.returnReminderSettings() as? ReminderSettings{
            reSwitch.setOn(seminder.isReminderOn, animated: true);
            let i: Int = Int(seminder.repeatCount) - 1;
            lbl3x.text = xArray[i];
            startTimeDp.date = seminder.startTime!;
            endTimeDp.date = seminder.endTime!;
        }
        
        
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
        
        CoreDataHelper.updateReminderSetting(startDate: startTimeDp.date, endDate: endTimeDp.date, isON: reSwitch.isOn, repeatCount: getRepeatCount()) { (success) in
            //
            print(success);
        }
        
        
        
        
        
        
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
            removeAllPendingNotifications();
            
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
        
        var startTIme = startTimeDp.date
        let endTIme = endTimeDp.date
        
        print(startTIme);
        print(endTIme);
        
        let ti : TimeInterval = endTIme.timeIntervalSince(startTIme);
        let betweenminutes: Int = Int(ti / 60);
        print(betweenminutes);
        
        let minDistance = Int(betweenminutes / repeatCount);
        print(minDistance);
        
        
        var dateArray: [Date] = [Date]();
        let vi: [Int] = [2,3,1];
        
        var newEndTime = endTIme;
        let calendar = Calendar.current;
        
        for inde in 0...Int(data.count / getRepeatCount()){
            
            var newStartTime = startTIme;
            for each in 1...getRepeatCount(){
                
                newStartTime = calendar.date(byAdding: .minute, value: minDistance, to: newStartTime)!;
                
                
                if(dateArray.contains(newStartTime)){
                    startTIme = calendar.date(byAdding: .day, value: 1, to: startTIme)!;
                    newStartTime = startTIme;
                    dateArray.append(newStartTime)
                }else{
                   dateArray.append(newStartTime)
                };
                
                print("peep", newStartTime);
                
            }
            
            newStartTime = startTIme;
            
        }
        
        print("dateArray", dateArray);
        
        
        
        
        
        
        
        
        for (index, dict) in data.enumerated(){

            print(index, dict);

            let content = UNMutableNotificationContent();
            content.title = "Random Fact -\(dict.ID!)- \(dict.Reference!)";
            content.body = dict.Content!;
            content.sound = UNNotificationSound.default()
            
            let comp2 = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: dateArray[index])
            let trigger = UNCalendarNotificationTrigger(dateMatching: comp2, repeats: true);
            print(comp2);
            

            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(10 + 2*index), repeats: false)
            let identifier = "learn.id.\(dict.ID!).\(dateArray[index])";
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)


            cnter.add(request, withCompletionHandler: { (error) in
                if let error = error {
                    // Something went wrong
                    print(error);
                }

                print("delivered");

            })

        }
        
        
    }
    
    func returnNoOfMinutesOnly(start: Date, end: Date){
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
