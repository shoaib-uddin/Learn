//
//  LearnottoApi.swift
//  Learn
//
//  Created by Xtreme Hardware on 23/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

class LearnottoApi{
    
    class func Login(_ UserName: String, _ Password: String, _ signup: EnSignUp, completion: @escaping (_ callback: Bool) -> Void){
        
        // Post Model Create
        let post = "username=\(UserName)&password=\(Password)";
        
        //Network Request
        NetworkHelper.MakePostRequest("\(api.SignIn)?\(post)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            
            let response : [EnSignUp] = [EnSignUp](json: successData as? String);
            print(response);
            let sig = response[0];
            signup.Id = sig.Id;
            
            print(signup);
            CoreDataHelper.updateUser(signup: signup, completion: { (flag) in
                completion(true);
            })
            
            
            
            
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false);
            
        })
        
        
    }
    
    class func Signup(_ signup: EnSignUp, completion: @escaping (_ callback: Bool) -> Void){
        
        // Post Model Create
        let post = [
            "password": "\(signup.password!)",
            "Id" :"\(signup.Id!)",
            "Name" : "\(signup.Name!)",
            "Gender" : "\(signup.Gender!)",
            "Email": "\(signup.Email!)",
            "username" : "\(signup.username!)",
            "Token" : "\(signup.Token!)",
            "FacebookId" : "\(signup.FacebookId!)",
            "ImageUrl" : "\(signup.ImageUrl!)"
        ] as? [String: Any];
//        let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        //Network Request
        NetworkHelper.MakePostRequestForArray(Url: "\(api.SignUp)", postData: post, showLoader: true, success: { (successData) -> Void in
            
            
            CoreDataHelper.createUser(signup: signup, completion: { (flag) in
                completion(true);
            })
            
            
            
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false);
            
        })
        
        
    }
    
    class func getFacts(_ id: String, _ page: Int, subCat: String!,   completion: @escaping (_ callback: Bool, _ data: [EnFact]?) -> Void){
        
        // Post Model Create
        var post = "";
        post += "userid=\(id)&";
        post += "Page=\(page)&";
        post += "Size=100";
        if(subCat != nil){
            post += "&SubCategoryId=\(subCat!)";
        }
        
        let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        //Network Request
        print()
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getFacts)?\(encoded!)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            let response : [EnFact] = [EnFact](json: successData as? String);
            print(response);
            completion(true, response);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false, nil);
            
        })
        
        
    }
    
    class func getFavFacts(_ id: String, _ page: Int, size: Int, completion: @escaping (_ callback: Bool, _ data: [EnFact]?) -> Void){
        
        // Post Model Create
        var post = "";
        post += "userid=\(id)&";
        post += "Page=\(page)&";
        post += "Size=\(size)";
        
        
        let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        //Network Request
        print()
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getMyFavouriteFacts)?\(encoded!)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            let response : [EnFact] = [EnFact](json: successData as? String);
            print(response);
            completion(true, response);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false, nil);
            
        })
        
        
    }
    
    class func getCategories( completion: @escaping (_ callback: Bool, _ data: [EnDDL]?) -> Void ){
        
        //Network Request
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getCategories)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            let response : [EnDDL] = [EnDDL](json: successData as? String);
            print(response);
            completion(true, response);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false, nil);
            
        })
        
        
    }
    
    class func getSubCategories(item: EnDDL,  completion: @escaping (_ callback: Bool, _ data: [EnDDL]?) -> Void ){
        
        let post = "CategoryId=\(item.ID!)";
        
        //Network Request
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getSubCategories)?\(post)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            let response : [EnDDL] = [EnDDL](json: successData as? String);
            print(response);
            completion(true, response);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false, nil);
            
        })
        
        
    }
    
    class func addLike(userid: String, factid: String,  completion: @escaping (_ callback: Bool) -> Void ){
        
        let post = "userid=\(userid)&factid=\(factid)";
        
        //Network Request
        NetworkHelper.MakePostRequestForArray(Url: "\(api.AddLike)?\(post)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            completion(true);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false);
            
        })
        
        
    }
    
    class func getRandomFacts(_ id: String,   completion: @escaping (_ callback: Bool, _ data: [EnFact]?) -> Void){
        
        // Post Model Create
        var post = "";
        post += "\(id)?";
        post += "count=100";
        
        let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        //Network Request
        print()
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getRandomFacts)/\(post)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            let response : [EnFact] = [EnFact](json: successData as? String);
            print(response);
            completion(true, response);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false, nil);
            
        })
        
        
    }
    
    class func getFavFactCount(_ id: String,   completion: @escaping (_ callback: Bool, _ data: FavCount?) -> Void){
        
        // Post Model Create
        var post = "";
        post += "?userid=\(id)";
        
        let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        //Network Request
        print()
        NetworkHelper.MakePostRequestForArray(Url: "\(api.myFavouriteCount)/\(post)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            let response : [FavCount] = [FavCount](json: successData as? String);
            print(response);
            completion(true, response[0]);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false, nil);
            
        })
        
        
    }
    
    class func getSingleFacts(_ id: String, _ factId: String, completion: @escaping (_ callback: Bool, _ data: EnFact?) -> Void){
        
        // Post Model Create
        var post = "";
        post += "userid=\(id)&";
        post += "Page=0&";
        post += "Size=1&";
        post += "factId=\(factId)";
        
        
        let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        //Network Request
        print()
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getFacts)?\(encoded!)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            let response : [EnFact] = [EnFact](json: successData as? String);
            print(response);
            completion(true, response[0]);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false, nil);
            
        })
        
        
    }
    
    

    
}
