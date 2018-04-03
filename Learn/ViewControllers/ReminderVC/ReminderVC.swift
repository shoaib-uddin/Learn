//
//  ReminderVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 02/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class ReminderVC : BaseVC{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var eventStore: EKEventStore = EKEventStore()
    var reminders: [EKReminder] = [EKReminder]();
    let cellIdentifier = "ReminderTVC";
    
    override func viewDidLoad() {
        //
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 85.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero);
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
        self.eventStore = EKEventStore()
        self.reminders = [EKReminder]()
        
        self.eventStore.requestAccess(to: .reminder) { (granted, error) in
            //
            if(granted){
                let predicate = self.eventStore.predicateForReminders(in: nil);
                self.eventStore.fetchReminders(matching: predicate, completion: { (reminders) in
                    //
                    self.reminders = reminders!;
                    DispatchQueue.main.async {
                        self.tableView.reloadData();
                    }
                })
            }else{
                print("The app is not permitted to access reminders, make sure to grant permission in the settings and try again")
            }
        }
        
        
        
    }
    
    
    
}


extension ReminderVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reminders.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let stub = self.reminders[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderTVC", for: indexPath as IndexPath) as! ReminderTVC;
        cell.setData(data: stub);
        cell.selectionStyle = .none;
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
    }
    
    
    
    
}



