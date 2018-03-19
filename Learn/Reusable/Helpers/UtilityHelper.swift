//
//  UtilityHelper.swift
//  Learn
//
//  Created by Xtreme Hardware on 18/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

open class UtilityHelper
{
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
    
    
    
}
