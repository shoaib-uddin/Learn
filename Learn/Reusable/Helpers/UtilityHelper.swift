//
//  UtilityHelper.swift
//  Learn
//
//  Created by Xtreme Hardware on 18/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import LKAlertController
import AVFoundation

open class UtilityHelper
{
    class func setKey(_ KeyName : String , KeyValue : String){
        let prefs:UserDefaults = UserDefaults.standard
        prefs.set(KeyValue, forKey: KeyName)
        prefs.synchronize();
    }
    
    class func getKey(_ KeyName : String) -> String!{
        let prefs:UserDefaults = UserDefaults.standard
        let KeyValue =  prefs.object(forKey: KeyName);
        if(KeyValue != nil ){
            return KeyValue! as! String;
        }
        return nil;
        
    }
    
    class func setBoolKey(_ KeyName : String , KeyValue : Bool){
        let prefs:UserDefaults = UserDefaults.standard
        prefs.set(KeyValue, forKey: KeyName)
        prefs.synchronize();
    }
    
    class func getBoolKey(_ KeyName : String) -> Bool{
        let prefs:UserDefaults = UserDefaults.standard
        let KeyValue =  prefs.object(forKey: KeyName);
        if(KeyValue != nil ){
            return KeyValue! as! Bool;
        }
        return false;
    }
    
    class func getPlistContent(name: String) -> [[String: Any]]{
        
        var plist: [[String: Any]]!;
        
        if let path = Bundle.main.path(forResource: name, ofType: "plist") {
            
            //If your plist contain root as Array
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                //print(array);
                plist = array;
            }
            
        }
        
        return plist;
        
    }
    
    class func AlertMessage(_ msg: String) {
        Alert(title: nil, message: msg)
            .addAction("Ok")
            .show()
    }
    
    class func AlertMessagewithCallBack(_ msg: String,  success: @escaping () -> Void) {
        
        
        Alert(title: nil, message: msg).addAction("OK", style: .default) { (_) -> Void in
            success();
            }.show();
        
    }
    
    class func ShowLoader(_ title:String = "Loading") {
        
        
        
        if ARSLineProgress.shown { return }
        
        ARSLineProgress.showWithPresentCompetionBlock { () -> Void in
            print("Showed with completion block")
        }
        
    }
    
    class func HideLoader() {
        
        if !ARSLineProgress.shown { return }
        DispatchQueue.main.async {
            ARSLineProgress.hideWithCompletionBlock({ () -> Void in
                print("Hidden with completion block")
            })
        }
        
    }
    
    
    
    
}
