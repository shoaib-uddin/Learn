//
//  BaseVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 15/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init header
        
        
        
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().isHidden = true;
        
//
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;




    }

//    override func viewWillDisappear(_ animated: Bool) {
//        //
//        self.navigationController?.isNavigationBarHidden = false;
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showNavigationBar(){
        UINavigationBar.appearance().isHidden = false;
    }
    
    func hideNavigationBar(){
        UINavigationBar.appearance().isHidden = true;
    }
    
    
    
    
}

