//
//  LoginVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 05/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginVC: UIViewController, FBSDKLoginButtonDelegate{
    
    
    
    
    @IBOutlet weak var loginView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init header
        
        self.view.layoutIfNeeded();
        addLoginButton();
        
        if (FBSDKAccessToken.current() != nil) {
            PageRedirect.redirectToMainPage(self);
        }
        
        
    }
    
    func addLoginButton(){
        
        let loginButton = FBSDKLoginButton()
        loginButton.center = loginView.center
        loginButton.frame = CGRect(x: 0, y: 0, width: loginView.frame.width, height: loginView.frame.height);
        loginButton.readPermissions = ["public_profile", "email"];
        loginButton.delegate = self;
        loginView.addSubview(loginButton)
        
    }
    
    
    
    // delegate method don't delete
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        //
        
        if(FBSDKAccessToken.current() != nil){
            
            PageRedirect.redirectToMainPage(self);
            
        }
        
        
        
    }
    
    // delegate method don't delete
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("user logged out now");
    }
    
    
    
    
    
    
}
