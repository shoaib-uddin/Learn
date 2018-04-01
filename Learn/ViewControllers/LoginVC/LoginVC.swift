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
                self.tryLogin();
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
        
        UtilityHelper.ShowLoader();
        
        GBHFacebookHelper.shared.login(controller: nil) { (success1, prompt) in
            if(success1){
                self.tryLogin();
            }
        }
        
    }
    
    fileprivate func tryLogin(){
        
        
        GBHFacebookHelper.shared.fbDataRequest(completion: { (success2, signup) in
            //
            if(success2){
                
                let email = signup?.Email;
                let password = settings.gPassword;
                
                LearnottoApi.Login(email!, password, signup!, completion: { (success3) in
                    //
                    if(success3){
                            PageRedirect.redirectToMainPage(self, signup: signup!);
                    }else{
                        
                        LearnottoApi.Signup(signup!, completion: { (success4) in
                            //
                            if(success4){
                                LearnottoApi.Login(email!, password, signup!, completion: { (success5) in
                                    //
                                    if(success5){
                                            PageRedirect.redirectToMainPage(self, signup: signup!);
                                    }else{
                                        UtilityHelper.AlertMessage(Errors.dbLoginFailed);
                                    }
                                })
                            }else{
                                UtilityHelper.AlertMessage(Errors.dbSignupFailed);
                            }
                        })
                    }
                })
            }else{
                UtilityHelper.AlertMessage(Errors.FbLoginFailed)
            }
            
        });
        
        
    }
    
    
    
    
    
    
    
    
    
}
