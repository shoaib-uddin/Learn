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
    
    var cnter = UNUserNotificationCenter.current();
    
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
        
        var start_time = hhmmss(self.startTimeDp.date);
        var end_time = hhmmss(self.endTimeDp.date);
        
        if let _user = CoreDataHelper.returnUser(), let _id = _user.id{
            LearnottoApi.UpdateNotificationSettings(start_time, end_time, repeat_count: getRepeatCount(), NotificationON: 0, id: _id) { (success) in
                //
                print(success);
                print(success);
            }
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
        
        cnter = UNUserNotificationCenter.current();
        
        
        
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.startTimeDp.setDate(seminder.startTime!, animated: false);
                self.endTimeDp.setDate(seminder.endTime!, animated: false);
            }
            
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
    
    
    var secArray = [Double]();
    var dictArray = [EnFact]();
    
    func DeliverMyMessage(_ dict: EnFact, _ index: Int){
        
        
        let content = UNMutableNotificationContent();
        content.body = dict.Content!;
        content.categoryIdentifier = "learn";
        content.userInfo = ["dictid": "Random Fact -\(dict.ID!)- \(dict.Reference!)" ];
        content.sound = UNNotificationSound.default();
        content.badge = 1;
        
        
        var ui: Double = secArray[index];
        
        let ptype = UUID().uuidString + "\(Date().timeIntervalSinceNow)" + "\(ui)";
        
        
        print(ui);
        print(ptype);
        
        if(ui > 0){
            
            //UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [ptype])
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: ui , repeats: false)
            let request = UNNotificationRequest(identifier: ptype, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
                if let error = error {
                    // Something went wrong
                    print(error);
                }
                
                print("delivered");
                if(index < ( self.dictArray.count - 1) ){
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.DeliverMyMessage(self.dictArray[index + 1], index + 1);
                    })
                    
                }else{
                    print("all delivered");
                }
                
                
            })

        }else{
            self.DeliverMyMessage(self.dictArray[index + 1], index + 1);
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
            var start_time = hhmmss(startTimeDp.date);
            var end_time = hhmmss(endTimeDp.date);
            
            if let _user = CoreDataHelper.returnUser(), let _id = _user.id{
                
                LearnottoApi.UpdateNotificationSettings(start_time, end_time, repeat_count: getRepeatCount(), NotificationON: 1, id: _id) { (success) in
                    //
                    print(success);
                    print(success);
                }
            
            }
            
            
            
            
            
//            LearnottoApi.getRandomFacts(userModel.id!, completion: { (success, data) in
//                if(success){
//
//                    // set Data in CoreData
//                    print(data);
//                    self.setManyRemindersWithTime(dat: data!);
//                    self.dictArray = data!;
//
//                }
//            })
            
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
        removeAllPendingNotifications();
        self.reSwitch.setOn(false, animated: true);
    }
    
    fileprivate func getRepeatCount() -> Int{
        
        let getValue = lbl3x.text!;
        let index = xArray.index { (v) -> Bool in
            return v == getValue;
        }
        
        return index! + 1;
    }
    
    func setManyRemindersWithTime(dat: [EnFact]){
        
        let data = dat;
        self.dictArray = dat;
        
        let repeatCount = getRepeatCount();
        print(repeatCount);
        print(data.count);
        
        var calendar = Calendar.current;
        calendar.timeZone = .current;
        let currentTime = Date();
        var startTime = startTimeDp.date;
        var endTime = endTimeDp.date;
        
        let CurrentComponent = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: currentTime)
        let startingComponent = calendar.dateComponents([.hour, .minute], from: startTime)
        let endingComponent = calendar.dateComponents([.hour, .minute], from: endTime);
        
        var startingDateComponents = DateComponents();
        startingDateComponents.day = CurrentComponent.day;
        startingDateComponents.month = CurrentComponent.month;
        startingDateComponents.year = CurrentComponent.year;
        startingDateComponents.hour = startingComponent.hour;
        startingDateComponents.minute = startingComponent.minute;
        
        startTime = calendar.date(from: startingDateComponents)!
        
        var endingDateComponents = DateComponents();
        endingDateComponents.day = CurrentComponent.day;
        endingDateComponents.month = CurrentComponent.month;
        endingDateComponents.year = CurrentComponent.year;
        endingDateComponents.hour = endingComponent.hour;
        endingDateComponents.minute = endingComponent.minute;
        
        endTime = calendar.date(from: endingDateComponents)!
        
        
        print(startTime, endTime);
        
        // find difference between start time and end time
        var startingSecond = startTime
//            .timeIntervalSince1970
            .timeIntervalSince(currentTime);
        
//        let difference = Calendar.current.dateComponents([.hour, .minute, .second], from: startTime, to: endTime);
//        print(difference.second);
        
        let numberOfSecInDifference = endTime.timeIntervalSince(startTime);
        var secSections: Double = Double(Int(numberOfSecInDifference) / repeatCount) ;
        
        print(startingSecond, numberOfSecInDifference, secSections);
        
//        if(secSections < 60){
//            secSections = 60.00;
//        }
        
        
        
        
        
        
        
        for inde in 0...Int(data.count / getRepeatCount()){

            var newStartTime = startingSecond;
            for each in 0...(getRepeatCount() - 1){

                newStartTime = newStartTime + secSections;

                if(secArray.contains(newStartTime)){
                    startingSecond = startingSecond + 86400;
                    newStartTime = startingSecond;
                    secArray.append(newStartTime)
                }else{
                    secArray.append(newStartTime)
                };

            }

            newStartTime = startingSecond;

        }


        print("peep", secArray);
        
        print()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.DeliverMyMessage(self.dictArray[0], 0);
        })
        
        
//
//
//
//        // fired notification difference will be
//            for (index, dict) in data.enumerated(){
//
//                let content = UNMutableNotificationContent();
//                content.body = dict.Content!;
//                content.categoryIdentifier = "learn";
//                content.userInfo = ["dictid": "Random Fact -\(dict.ID!)- \(dict.Reference!)" ];
//                content.sound = UNNotificationSound.default();
//                content.badge = 1;
//
//
//                print(secArray[index]);
//                print(TimeInterval(secArray[index]))
//                if(secArray[index] > 0) {
//
//                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secArray[index]), repeats: false)
//                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                    cnter.add(request, withCompletionHandler: { (error) in
//                        if let error = error {
//                            // Something went wrong
//                            print(error);
//                        }
//
//                        print("delivered");
//
//                    })
//
//
//                }
//
//
//            }
//
//
//
//
//
//
//
//
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//
//
//
//        //let currentDateTime = UtilityHelper.getCurrentDateTime();
//        let currentDateTime = Date();
//        print(currentDateTime);
//
//
//
//        var startTIme = UtilityHelper.getCurrentDateTime(date: startTimeDp.date)
//        let endTIme = UtilityHelper.getCurrentDateTime(date: endTimeDp.date)
//        //var startTIme = startTimeDp.date
//        //let endTIme = endTimeDp.date
//        print(startTIme);
//        print(endTIme);
//
//        let ti : TimeInterval = endTIme.timeIntervalSince(startTIme);
//        let betweenminutes: Int = Int(ti / 60);
//        print(betweenminutes);
//
//        let minDistance = betweenminutes / repeatCount;
//        print(minDistance);
//
//
//        var dateArray: [Date] = [Date]();
//        let vi: [Int] = [2,3,1];
//
//
//        let today = startTIme
//        var calendar = Calendar.current
//        calendar.timeZone = .current
//        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: today)
//
//        let day = components.day
//        let hour = components.hour
//        let minute = components.minute
//        print("day = \(day)\nhour = \(hour)\nminute = \(minute)")
////        let abb = TimeZone.current.abbreviation()! ?? "GMT";
////        calendar.timeZone = NSTimeZone(abbreviation: "\(abb)") as! TimeZone;
//
//        for inde in 0...Int(data.count / getRepeatCount()){
//
//            var newStartTime = startTIme;
//            for each in 1...getRepeatCount(){
//
//                newStartTime = calendar.date(byAdding: .minute, value: minDistance, to: newStartTime)!;
//
//
//                if(dateArray.contains(newStartTime)){
//                    startTIme = calendar.date(byAdding: .day, value: 1, to: startTIme)!;
//                    newStartTime = startTIme;
//                    dateArray.append(newStartTime)
//                }else{
//                   dateArray.append(newStartTime)
//                };
//
//                print("peep", newStartTime);
//
//            }
//
//            newStartTime = startTIme;
//
//        }
//
//        print("dateArray", dateArray);
//
//
//
//
//
//
//
//
//        for (index, dict) in data.enumerated(){
//
//            print(index, dict);
//
//            let content = UNMutableNotificationContent();
//            // content.title = "Random Fact -\(dict.ID!)- \(dict.Reference!)";
//            content.body = dict.Content!;
//            content.categoryIdentifier = "learn";
//            content.userInfo = ["dictid": "Random Fact -\(dict.ID!)- \(dict.Reference!)" ];
//            content.sound = UNNotificationSound.default();
//            content.badge = 1
//
//            //let ndate = UtilityHelper.getCurrentDateTime(date: dateArray[index])
//            //let ndate = Date().adding(minutes: index);
//
//            let ndate = dateArray[index];
//
//            print(ndate);
//            let comp2 = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: ndate)
//            print(comp2);
//            //let trigger = UNCalendarNotificationTrigger(dateMatching: comp2, repeats: false);
//            //let trigger = timeIntervalTrigger(from: ndate, repeats: true);
//
//
//
//
//
//
//           // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//
////            let p = Int.random(range: 2000..<9000);
////            let identifier = "learn.id.\(dict.ID!)";
////            print("identifiwe", identifier, "date : ", comp2)
////            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
////
////
////
////            cnter.add(request, withCompletionHandler: { (error) in
////                if let error = error {
////                    // Something went wrong
////                    print(error);
////                }
////
////                print("delivered");
////
////            })
//
//        }
        
        
    }
    
    
    
    
    
    
    func timeIntervalTrigger(from date: Date, repeats: Bool) -> UNTimeIntervalNotificationTrigger! {
        let timeInterval = date.timeIntervalSinceNow
        print(timeInterval)
        if(timeInterval > 0){
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
            return trigger
        }else{
            return nil
        }
        
    }
    
    func hhmmss(_ date: Date) -> Int{
        
        //let ndate = UtilityHelper.getCurrentDateTime(date: date)
        
        let ndate = self.makeDate(pdate: date)
        let ss = ndate.timeIntervalSinceNow
        print(ss);
        return Int(ss);
        
//        let calendar = Calendar.current
//        let comp = calendar.dateComponents([.hour, .minute, .second], from: date)
//        let hh = comp.hour
//        let mm = comp.minute
//        let ss = comp.second
//
//        let comp2 = calendar.dateComponents([.hour, .minute, .second], from: date)
//        let hh = comp.hour
//        let mm = comp.minute
//        let ss = comp.second
//
//
//        return "\(hh ?? 00):\(mm ?? 00):\(ss ?? 00)";
//
        
    }
    
    func makeDate(pdate: Date) -> Date {
        
        let calendar = Calendar.current;
        let date = Date();
        
        let components = NSDateComponents();
        components.year = calendar.component(.year, from: date);
        components.month = calendar.component(.month, from: date);
        components.day = calendar.component(.day, from: date);
        components.hour = calendar.component(.hour, from: pdate);
        components.minute = calendar.component(.minute, from: pdate);
        components.second = calendar.component(.second, from: pdate);
        let ndate = calendar.date(from: components as DateComponents)
        return ndate! as Date
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}
