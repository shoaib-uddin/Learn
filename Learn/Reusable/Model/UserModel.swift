//
//  UserModel.swift
//  Learn
//
//  Created by Xtreme Hardware on 23/12/2017.
//  Copyright © 2017 pixel. All rights reserved.
//

import UIKit
import Foundation

class UserModel{
    
    class func isUserLoggedIn() -> Bool{
        
        
        return false;
    }
    
    class func isSessionExpired() -> Bool{
        
        return true;
    }
    
    
    class func setLoginUser(_ response: EnSignUp){
        
        
        
    }
    
    class func GetInfo() -> EnSignUp!
    {
        
        return EnSignUp();
    }
    
    
    
    class func setLoggedOutUser(){
        
    }
    
    class func setExpireUser(){
        
    }
    
    
    
}

