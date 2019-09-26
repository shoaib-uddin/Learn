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
    
    
    
    
    @IBOutlet weak var btnlogin: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var loginView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init header
        
        self.view.layoutIfNeeded();
        
        Losding(true)
        if let _user = CoreDataHelper.returnSignup(){
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.Losding(false)
                PageRedirect.redirectToMainPage(self, signup: _user)
            }
            
        }else{
            Losding(false)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    @IBAction func doLogin(_ sender: UIButton) {
        
        
        Losding(true);
        
        GBHFacebookHelper.shared.login(controller: nil) { (success1, prompt) in
            if(success1){
                self.tryLogin();
            }else{
                self.Losding(false)
            }
        }
        
    }
    
    fileprivate func tryLogin() {
        
        
        GBHFacebookHelper.shared.fbDataRequest(completion: { (success2, signup) in
            //
            if (success2) {
                
                guard let _signup = signup else { self.Losding(false);  return }
                LearnottoApi.Signup(_signup, completion: { (success4) in
                        //
                        if(success4){
                            self.Losding(true)
                            PageRedirect.redirectToMainPage(self, signup: _signup);
                        }else{
                            self.Losding(false)
                            UtilityHelper.AlertMessage(Errors.dbSignupFailed);
                        }
                })
                
            }else{
                self.Losding(false)
                UtilityHelper.AlertMessage(Errors.FbLoginFailed)
            }
            
        });
        
        
    }
    
    
    func Losding(_ flag: Bool){
        
        loader.isHidden = !flag;
        if(flag){
            loader.startAnimating();
        }else{
            loader.stopAnimating();
        }
        btnlogin.isHidden = flag;
        
    }
    
    
    
    
    
    
    
    
    
}
