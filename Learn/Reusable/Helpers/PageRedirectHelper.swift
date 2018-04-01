//
//  PageRedirectHelper.swift
//  PolaroidPop
//
//  Created by clines227 on 05/07/2017.
//  Copyright © 2017 matech. All rights reserved.
//

import Foundation
import UIKit

class PageRedirect {

    
    class func redirectToMainPage(_ viewController: UIViewController, signup: EnSignUp){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        destination.signup = signup;
        viewController.navigationController?.pushViewController(destination, animated: true);
        
    }
    
    class func redirectToSettingsPage(_ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        destination.vcDelegate = viewController as? SettingsVCDelegate;
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    class func redirectToSidemenuPage(_ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "SidemenuVC") as! SidemenuVC
        destination.vcDelegate = viewController as? SidemenuVCDelegate;
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    class func navToChildSubmenu(item: EnDDL, viewController: UIViewController){
    
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "SidemenuVC") as! SidemenuVC
        destination.vcDelegate = viewController as? SidemenuVCDelegate;
        destination.isSubCategory = true;
        destination.parentCat = item;
        destination.vcDelegate = viewController as? SidemenuVCDelegate;
        viewController.present(destination, animated: true, completion: nil);
    
    }
        
    

}
