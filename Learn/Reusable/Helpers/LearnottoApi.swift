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
        //let token = CoreDataHelper.returnPushSettings().token ?? "";
        let token = "";
        
        var str = ""
        signup.toDictionary().forEach { (k,v) in
            print(k,v)
            if let _k = k as? String, let _v = v as? String{
                str = str + _k + "=" + _v + "&"
            }
            
        }
        
        
        // let post = "username=\(UserName)&password=\(Password)&APN_token=\(token)";
        let post = str.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
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
        
        var post: [String: Any] = [String:Any]() ;
        
        if let _password = signup.password{
            post["password"] = _password
        }else{
            post["password"] = settings.gPassword
        }
        
        if let _id = signup.Id{
            post["Id"] = _id
        }else{
            post["Id"] = "76565646765"
        }
        
        if let _name = signup.Name{
            post["Name"] = _name
        }else{
            post["Name"] = "Random name"
        }
        
        if let _gender = signup.Gender{
            post["Gender"] = _gender
        }else{
            post["Gender"] = "Male"
        }
        
        if let _email = signup.Email{
            post["Email"] = _email
        }else{
            post["Email"] = "testaccount@mail.com"
        }
        
        if let _username = signup.username{
            post["username"] = _username
        }else{
            post["username"] = ""
        }
        
        if let _token = signup.Token{
            post["Token"] = _token
        }else{
            post["Token"] = ""
        }
        
        if let _facebookId = signup.FacebookId{
            post["FacebookId"] = _facebookId
        }else{
            post["FacebookId"] = ""
        }
        
        if let _imageUrl = signup.ImageUrl{
            post["ImageUrl"] = _imageUrl
        }else{
            post["ImageUrl"] = ""
        }
        
//        let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        //Network Request
        NetworkHelper.MakePostRequestForArray(Url: "\(api.SignUp)", postData: post, showLoader: true, success: { (successData) -> Void in
            
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
    
    class func getFacts(_ id: String, _ page: Int, subCat: String!,   completion: @escaping (_ callback: Bool, _ data: [EnFact]?) -> Void){
        
        
        // Post Model Create
        var post = "";
        post += "userid=" + id + "&";
        post += "Page=\(page)&";
        post += "Size=500";
        if(subCat != nil){
            post += "&CategoryId=\(subCat!)";
        }
        
        //let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        //Network Request
        print()
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getFacts)?\(post)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
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
    
    class func getDefaultCategories(page: Int, size: Int, completion: @escaping (_ callback: Bool, _ data: [EnDDL]?) -> Void ){
        
        var post = "";
        post += "Page=\(page)&";
        post += "Size=\(size)";
        
        //Network Request
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getDefaultCategories)?\(post)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
            let response : [EnDDL] = [EnDDL](json: successData as? String);
            print(response);
            completion(true, response);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false, nil);
            
        })
        
        
    }
    
    class func getCategories(page: Int, size: Int, completion: @escaping (_ callback: Bool, _ data: [EnDDL]?) -> Void ){
        
        var post = "";
        post += "Page=\(page)&";
        post += "Size=\(size)";
        
        //Network Request
        NetworkHelper.MakeGetRequestForArray(Url: "\(api.getCategories)?\(post)", postData: nil, showLoader: true, success: { (successData) -> Void in
            
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
    
    class func UpdateNotificationSettings(_ start_time: Int, _ end_time: Int, repeat_count: Int, NotificationON: Int, id: String, completion: @escaping (_ callback: Bool) -> Void){
        
        // Post Model Create
        var post = "";
        post += "userid=\(id)&";
        post += "start_time=\(start_time)&";
        post += "end_time=\(end_time)&";
        post += "repeat_count=\(repeat_count)&";
        post += "NotificationON=\(NotificationON)";
        
        
        let encoded = post.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed);
        
        let post2 = [
            "start_time": start_time,
            "end_time": end_time,
            "repeat_count": repeat_count,
            "NotificationON": NotificationON,
            "user_ID": id
            ] as! [String: Any];
        
        //Network Request
        print(post2);
        NetworkHelper.MakePostRequestForArray(Url: "\(api.UpdateNotificationSettings)?\(encoded!)", postData: post2, showLoader: true, success: { (successData) -> Void in
            
            let response : [EnFact] = [EnFact](json: successData as? String);
            print(response);
            completion(true);
            
            
        },failure: { (error) -> Void in
            
            print(error?.localizedDescription ?? "ERROR");
            completion(false);
            
        })
        
        
    }
    
    
    
    

    
}
