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

    
    class func redirectToMainPageFromAppDelegate(text: String){
        
        
        
        
        
    }
    
    class func redirectToFeedbackPage(_ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "FeedbackVC") as! FeedbackVC
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    class func redirectToLoginPage(_ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        // destination.signup = signup;
        viewController.navigationController?.pushViewController(destination, animated: true);
        
    }
    
    class func redirectToMainPage(_ viewController: UIViewController, signup: EnSignUp){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        // destination.signup = signup;
        viewController.navigationController?.pushViewController(destination, animated: true);
        
    }
    
    class func redirectToSettingsPage(_ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        destination.vcDelegate = viewController as! SettingsVCDelegate
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    class func redirectToPreSidemenuPage(_ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "PreSidemenuVC") as! PreSidemenuVC
        destination.vcDelegate = viewController as! PreSidemenuVCDelegate
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    class func redirectToCatSidemenuPage(_ viewController: UIViewController, _ sidemenu: Bool = false){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "CatSidemenuVC") as! CatSidemenuVC
        destination.vcDelegate = viewController as! CatSidemenuVCDelegate;
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    class func redirectToReminderPage(_ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "ReminderVC") as! ReminderVC
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    class func redirectToSearchCatPage(_ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "SearchCatSideVC") as! SearchCatSideVC
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    class func redirectToFavFactsPage(count: Int, _ viewController: UIViewController){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main);
        let destination = storyboard.instantiateViewController(withIdentifier: "FavoritiesVC") as! FavoritiesVC
        destination.FavCount = count;
        viewController.present(destination, animated: true, completion: nil);
        
    }
    
    
    
    
    
    
        
    

}
