//
//  Constants.swift
//  Learn
//
//  Created by Xtreme Hardware on 18/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation;
import UIKit;


// global variables
var AssociatedPaths = [String]();
var globalSettings: Settings!;
var globalCatId: String!;
var globalNotiFact: EnFact!;

struct api {
    //static let SERVICEURL = "http://52.90.115.73:84/api/Default/";
    static let SERVICEURL = "http://learnotto.pixtechcreation.com/api/Default/";
    
    static let SignIn = "SigIn";
    static let SignUp = "SignUp";
    static let getFacts = "GetFacts";
    static let UpdateNotificationSettings = "UpdateNotificationSettings";
    static let getMyFavouriteFacts = "GetMyFavouriteFacts";
    static let getCategories = "GetCategories";
    static let getDefaultCategories = "GetDefaultCategories";
    static let getSubCategories = "GetSubCategories";
    static let getRandomFacts = "GetRandomFacts";
    static let myFavouriteCount = "MyFavouriteCount";
    static let AddLike = "AddLike";
    static let AddFeedBack = "AddFeedBack";
    static let Addpayments = "AddPayments";
    static let AddView = "AddView";
    static let savedCatId : String = "saveCatId";
    static let savedSubCatId : String = "savedSubCatId";
}

struct settings
{
    static let timeOut :Double = 5.0;
    static let gPassword : String = "EEAFBF4D";
    static let albumName : String = "Learnotto";
    
    
    
    
}

struct Errors {
    static let FbLoginFailed = "401: Facebook Unreachable";
    static let dbLoginFailed = "402: Databse Unreachable";
    static let dbSignupFailed = "403: Signup failed";
    
}


struct  localv {
    static let isInitializeCategories = "isInitializeCategories";
    static let AssociatedCategories : [String] =  ["Fun", "Bizarre", "Interesting", "Boring", "Celebrities", "World", "Planets", "Women", "Men", "Electronics", "Birds", "Magnets", "Strange", "History", "Bees"];
    
    static let AssociatedBackgrounds: [String] = ["1@1x", "2@1x", "3@1x", "4@1x", "5@1x", "6@1x", "7@1x", "8@1x", "9@1x" ];
    
}
