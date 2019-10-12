//
//  ReminderVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 11/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications


class ReminderVC: BaseVC, UniHeaderCVCDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var globalImageView: UIImageView!
    
    var collectionArray: [[String: Any]] = [[String: Any]]();
    let center = UNUserNotificationCenter.current();
    let options: UNAuthorizationOptions = [.alert, .sound];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        loadBackground(vc: self, globalImageView: self.globalImageView)
        
        collectionView.register(UINib(nibName: "SidemenuTableHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader");
        collectionView.register(UINib(nibName: "HeadViewCVC", bundle: nil), forCellWithReuseIdentifier: "HeadViewCVC");
        collectionView.register(UINib(nibName: "UniHeaderCVC", bundle: nil), forCellWithReuseIdentifier: "UniHeaderCVC");
        collectionView.register(UINib(nibName: "ReminderCVC", bundle: nil), forCellWithReuseIdentifier: "ReminderCVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        self.collectionArray = UtilityHelper.getPlistContent(name: "sidemenu");
        self.collectionView.reloadData();
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                
                self.dismiss(animated: true, completion: {
                    UtilityHelper.AlertMessage("Please allow access to notifications")
                })
                
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
        
    }
    
    func UniHeaderCVCClose(cell: UniHeaderCVC, doCLose: Bool) {
        //
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
}

extension ReminderVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // this collectionView is for Bottom Part of Screen where collectionView flow is vertical
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = self.collectionView.frame.width
        return CGSize(width: width, height: 0);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //
        var reusableView: UICollectionReusableView? = nil;
        
        if(kind == UICollectionElementKindSectionHeader){
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader", for: indexPath) as! SidemenuTableHeader;
            //
            reusableView =  header;
        }
        
        return reusableView!;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        
        
        if(indexPath.row == 0 || indexPath.row == 1){
            let width = (collectionView.frame.width);
            return CGSize(width: width, height: 60);
        }else{
            let width = (collectionView.frame.width);
            return CGSize(width: width, height: 540);
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
        
        
        if(indexPath.section == 0){
            
            if(indexPath.row == 0){
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UniHeaderCVC", for: indexPath) as? UniHeaderCVC
                    else { fatalError("unexpected cell in collection view") }
                cell.setData(heading: "REMINDERS");
                cell.cellDelegate = self;
                return cell;
                
            }else
            if(indexPath.row == 1){
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadViewCVC", for: indexPath) as? HeadViewCVC
                    else { fatalError("unexpected cell in collection view") }
                cell.setData(heading: "Setup Reminders for your day");
                
                return cell;
                
            }
            else{
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCVC", for: indexPath) as? ReminderCVC
                    else { fatalError("unexpected cell in collection view") }
                
                return cell;
            }
            
            
            
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageTitleDesTVC", for: indexPath) as? ImageTitleDesTVC
                else { fatalError("unexpected cell in collection view") }
            
            let data = collectionArray[indexPath.row + 6];
            cell.setData(icon: (data["icon"] as! String), heading: ( data["Name"] as! String), subHeading: "");
            
            
            return cell;
            
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return 3;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
        
    }
    
}


