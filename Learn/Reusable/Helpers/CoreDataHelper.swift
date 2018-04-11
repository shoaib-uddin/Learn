//
//  CoreDataHelper.swift
//  Learn
//
//  Created by Xtreme Hardware on 18/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import Photos
import PhotosUI
import CoreData

class CoreDataHelper{
    
    class func updateReminderSetting(startDate: Date, endDate: Date, isON: Bool, repeatCount: Int, completion: @escaping (_ success: Bool) -> Void){
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ReminderSettings");
        request.returnsObjectsAsFaults = false;
        
        
        do {
            let result = try context.fetch(request) as! [ReminderSettings];
            if(result.count > 0){ // Atleast one record
                
                result[0].startTime = startDate;
                result[0].endTime = endDate;
                result[0].isReminderOn = isON;
                result[0].repeatCount = Int64(repeatCount) ;
                
                
                try context.save();
                completion(true);
            }else{
                print("Boo");
                
                self.createReminderSetting(startDate: startDate, endDate: endDate, isON: isON, repeatCount: repeatCount, completion: { (success) in
                    completion(true);
                })
            }
        } catch {
            
            print("Failed")
            completion(false);
        }
        
        
        
        
        
        
    }
    
    class func createReminderSetting(startDate: Date, endDate: Date, isON: Bool, repeatCount: Int, completion: @escaping (_ success: Bool) -> Void){
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        
        // setting backgrounds paths
        let cSign = NSEntityDescription.entity(forEntityName: "ReminderSettings", in: context)
        
        
        // setting Settings Global
        let newUser = NSManagedObject(entity: cSign!, insertInto: context) as! ReminderSettings;
        newUser.setValue(startDate, forKey: "startTime");
        newUser.setValue(endDate, forKey: "endTime");
        newUser.setValue(isON, forKey: "isReminderOn");
        newUser.setValue(repeatCount, forKey: "repeatCount");
        
        do{
            
            try context.save();
            completion(true);
            
        } catch {
            
            print("Failed")
            completion(false);
        }
        
        
        
        
        
        
    }
    
    class func returnReminderSettings() -> ReminderSettings!{
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ReminderSettings");
        request.returnsObjectsAsFaults = false
        
        
        
        var firstElement: ReminderSettings!;
        
        do {
            let result = try context.fetch(request) as! [ReminderSettings];
            if(result.count == 0){
                return nil
            }else{
                firstElement = result.first
            }
            
            
        } catch {
            
            print("Failed")
        }
        
        return firstElement;
        
        
        
    }

    
    class func updateUser(signup: EnSignUp, completion: @escaping (_ success: Bool) -> Void){
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User");
        request.returnsObjectsAsFaults = false;
        
        
        do {
            let result = try context.fetch(request) as! [User];
            if(result.count > 0){ // Atleast one record
                
                result[0].email = signup.Email!;
                result[0].gender = signup.Gender!;
                result[0].id = signup.Id!;
                result[0].imageUrl = signup.ImageUrl!;
                result[0].name = signup.Name!;
                result[0].password = signup.password!;
                
                try context.save();
                completion(true);
            }else{
                print("Boo");
                self.createUser(signup: signup, completion: { (flag) in
                    completion(false);
                })
            }
        } catch {
            
            print("Failed")
            completion(false);
        }
        
        
        
        
        
        
    }
    
    class func createUser(signup: EnSignUp, completion: @escaping (_ success: Bool) -> Void){
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        
        // setting backgrounds paths
        let cSign = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        
        // setting Settings Global
            let newUser = NSManagedObject(entity: cSign!, insertInto: context) as! User;
            newUser.setValue("\(signup.Email!)", forKey: "email");
            newUser.setValue("\(signup.Gender!)", forKey: "gender");
            newUser.setValue("\(signup.Id!)", forKey: "id");
            newUser.setValue("\(signup.ImageUrl!)", forKey: "imageUrl");
            newUser.setValue("\(signup.Name!)", forKey: "name");
            newUser.setValue("\(signup.password!)", forKey: "password");
        
        do{
                
                try context.save();
                completion(true);
            
        } catch {
            
            print("Failed")
            completion(false);
        }
        
        
        
        
        
        
    }
    
    class func returnUser() -> User{
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User");
        request.returnsObjectsAsFaults = false
        
        
        
        var firstElement: User!;
        
        do {
            let result = try context.fetch(request)
            firstElement = result.first as! User
            
        } catch {
            
            print("Failed")
        }
        
        return firstElement;
        
        
        
    }
    
    class func insertSettings(data: Background, completion: @escaping (_ success: Bool) -> Void){
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Settings");
        request.returnsObjectsAsFaults = false;
        
        do {
            let result = try context.fetch(request) as! [Settings];
            if(result.count > 0){ // Atleast one record
                
                result[0].background = data.background;
                result[0].font = data.font;
                result[0].ttype = data.ttype;
                result[0].fcolor = data.fcolor;
                result[0].bcolor = data.bcolor;
                
                globalSettings.background = data.background;
                globalSettings.font = data.font;
                globalSettings.ttype = data.ttype;
                globalSettings.fcolor = data.fcolor;
                globalSettings.bcolor = data.bcolor;
                
                
            }
            
        } catch {
            
            print("Failed")
            completion(false);
        }
        
        do {
            try context.save();
            completion(true);
        } catch {
            print("Failed saving")
            completion(false);
        }
        
        
        
        
    }
    
    class func copyImageToDocFolder(index: Int, completion: @escaping (_ urls: [String]) -> Void){
    
        if(index < localv.AssociatedBackgrounds.count){
            
            let item = localv.AssociatedBackgrounds[index];
            
            if let image = UIImage(named: item){
                
                FileApi.copyImageToDocFolder(image: image, fileName: "\(item).png", completion: { (url, size, fileSize) in
                    //
                    AssociatedPaths.append(url.path);
                    self.copyImageToDocFolder(index: index + 1, completion: { (urls) in
                        print(urls);
                    })
                    
                })
                
            }
            
        }else{
            completion(AssociatedPaths);
        }
    
        
    }
    
    class func returnSettings() -> Settings{
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Settings");
        request.returnsObjectsAsFaults = false
        
        
        
        var firstElement: Settings!;
        
        do {
            let result = try context.fetch(request)
            firstElement = result.first as! Settings
            
        } catch {
            
            print("Failed")
        }
        
        return firstElement;
        
        
        
    }
    
    class func returnFonts() -> [Font]{
        
        var fonts = [Font]();
        
        for family: String in UIFont.familyNames
        {
            
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                
                print("== \(names)");
                var font = Font();
                font.family = family;
                font.type = names;
                
                fonts.append(font);
                
            }
        }
        
        return fonts;
        
    }
    
    class func returnBackgrounds() -> [Background]{
        
        var bgs = [Background]();
        
        for each in self.returnBackgroundPaths()
        {
            let b = Background();
            b.background = each.path;
            
            
            bgs.append(b);
            
        }
        
        return bgs;
        
    }
    
    class func settingPlist() -> [Background]{
        
        var b: [Background] = [Background]();
        let r = UtilityHelper.getPlistContent(name: "themes");
        
        for each in r {
            
            let p = Background();
            p.background = each["background"] as? String;
            p.font = each["font"] as? String;
            p.fcolor = each["fcolor"] as? String;
            p.bcolor = each["bcolor"] as? String;
            p.ttype = each["ttype"] as? String;
            b.append(p);
        }
        
        return b;
        
    }
    
    
    
    
    class func returnCategories() -> [String]{
        
        var cat = [String]();
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            
            for data in result as! [NSManagedObject] {
                let v = data.value(forKey: "name") as! String;
                print(v)
                cat.append(v);
            }
            
        } catch {
            
            print("Failed")
        }
        
        return cat;
        
    }
    
    class func returnBackgroundPaths() -> [Backgrounds]{
        
        var cat = [Backgrounds]();
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Backgrounds")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            
            cat = result as! [Backgrounds];
            
        } catch {
            
            print("Failed")
        }
        
        return cat;
        
    }
    
    class func returnFacts(ofCategory: String, completion: @escaping (_ facts: [Facts]) -> Void){
        
        
        var facts = [Facts]();
        
        self.createFacts();
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Facts");
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            facts = result as! [Facts];
        } catch {
            
            print("Failed")
        }

        completion(facts);
        
    }
    
    class func createFacts(){
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let nEntity = NSEntityDescription.entity(forEntityName: "Facts", in: context);
        
        // simulate network facts here and save to Facts
        let AssociatedFacts = UtilityHelper.getPlistContent(name: "sampleFacts");
        
        for fact in AssociatedFacts {
            let newFact = NSManagedObject(entity: nEntity!, insertInto: context);
            newFact.setValue(fact["text"], forKey: "text");
            newFact.setValue(fact["category"], forKey: "category");
        }
        
        
        // save all default features
        do {
            try context.save();
        } catch {
            print("Failed saving")
        }
        
        
    }
    
    class func createRecords(){

        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        
        // setting backgrounds paths
        let cBgs = NSEntityDescription.entity(forEntityName: "Backgrounds", in: context)
        self.copyImageToDocFolder(index: 0) { (urls) in
            
        }
        
        // setting Settings Global
        // Font Arial-ItalicMT
        let cSets = NSEntityDescription.entity(forEntityName: "Settings", in: context)
        
        if AssociatedPaths[0].lowercased().range(of:"png") != nil {
            let newSettings = NSManagedObject(entity: cSets!, insertInto: context);
            let p: [[String: Any]] = UtilityHelper.getPlistContent(name: "themes");
            newSettings.setValue(p[0]["background"], forKey: "background");
            newSettings.setValue(p[0]["font"], forKey: "font");
            newSettings.setValue(p[0]["fcolor"], forKey: "fcolor");
            newSettings.setValue(p[0]["bcolor"], forKey: "bcolor");
            newSettings.setValue(p[0]["ttype"], forKey: "ttype");
            
        }
        
        for bg in localv.AssociatedBackgrounds {
            let newBackground = NSManagedObject(entity: cBgs!, insertInto: context);
            newBackground.setValue("\(bg).png", forKey: "path");
        }
        
        // setting Categories
        let cEntity = NSEntityDescription.entity(forEntityName: "Categories", in: context)
        
        for category in localv.AssociatedCategories {
            let newCategory = NSManagedObject(entity: cEntity!, insertInto: context);
            newCategory.setValue(category, forKey: "name");
        }
        
        
        // settings Temp Facts
        let nEntity = NSEntityDescription.entity(forEntityName: "Facts", in: context)
        let AssociatedFacts = UtilityHelper.getPlistContent(name: "sampleFacts");
        
        for fact in AssociatedFacts {
            let newFact = NSManagedObject(entity: nEntity!, insertInto: context);
            newFact.setValue(fact["text"], forKey: "text");
            newFact.setValue(fact["category"], forKey: "category");
        }
        
        // set pre category Ids for user
        UtilityHelper.setKey(api.savedCatId, KeyValue: "1");
        UtilityHelper.setKey(api.savedSubCatId, KeyValue: "1");
        
        
        
        // save all default features
        do {
            try context.save();
            UtilityHelper.setBoolKey(localv.isInitializeCategories, KeyValue: true);
        } catch {
            print("Failed saving")
        }
        
    }

    
    
    
    
    
    
    
}

