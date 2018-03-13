//
//  LoginVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 05/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController{
    
    
    
    
    @IBOutlet weak var loginView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init header
        
        self.view.layoutIfNeeded();
        
        GBHFacebookHelper.shared.checklogin { (success, error) in
            if(success){
                PageRedirect.redirectToMainPage(self);
            }
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        
        GBHFacebookHelper.shared.login(controller: nil) { (success, prompt) in
            
            if(success){
                
                PageRedirect.redirectToMainPage(self);
                
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
}
