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

class CoreDataHelper: NSObject{
    
    var AssociatedCategories : [String] =  ["Fun", "Bizarre", "Interesting", "Boring", "Celebrities", "World", "Planets", "Women", "Men", "Electronics", "Red Robins", "Magnets", "Strange", "History", "Bees"];
    
    var AssociatedFacts: [[String: Any]] = [[:]];
    
    
    var backgrounds: [String] = ["baloon", "boxes", "bubbles", "flower", "leaf", "nebula", "planet", "spiderman", "texture" , "water" ];
    
    override init() {
        super.init();
        
    }
    
    
}

extension CoreDataHelper{
    
    // input UIImageView -> output asset image of the size of input view
    func createRecords(){
        
        let bg = "smiley.jpg";
        let image = UIImage(named: bg);
        FileApi.copyImageToDocFolder(image: image!, fileName: "smiley.jpg") { (url, pixelsize, filesize) in
            //
            let appDelegate =  AppDelegate.getAppDelegate();
            let context = appDelegate.persistentContainer.viewContext;
            let cEntity = NSEntityDescription.entity(forEntityName: "Categories", in: context)
            
            for category in self.AssociatedCategories {
                let newCategory = NSManagedObject(entity: cEntity!, insertInto: context);
                newCategory.setValue(category, forKey: "name");
            }
            
            let nEntity = NSEntityDescription.entity(forEntityName: "Facts", in: context)
            
            self.AssociatedFacts = UtilityHelper.getPlistContent(name: "sampleFacts");
            
            for fact in self.AssociatedFacts {
                let newFact = NSManagedObject(entity: nEntity!, insertInto: context);
                
                
                newFact.setValue(fact["text"], forKey: "text");
                newFact.setValue(fact["category"], forKey: "category");
                newFact.setValue(bg, forKey: "background");
            }
            
            do {
                try context.save();
                UtilityHelper.setBoolKey(Setting.isInitializeCategories, KeyValue: true);
            } catch {
                print("Failed saving")
            }
        }
        
        
        
        
    }
    
    func returnCategories() -> [String]{
        
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
    
    func returnFacts(ofCategory: String) -> [[String: Any]]{
        
        
        var facts: [[String: Any]] = [[:]];
        
        let appDelegate =  AppDelegate.getAppDelegate();
        let context = appDelegate.persistentContainer.viewContext;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Facts");
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                
                let fact: [String: Any] = [
                    "text" : data.value(forKey: "text") as! String,
                    "category" : data.value(forKey: "category") as! String,
                    "background" : data.value(forKey: "background") as! String
                ];
                
                
                
                facts.append(fact);
            }
            
        } catch {
            
            print("Failed")
        }
        
        facts.remove(at: 0);
        
        return facts;
        
    }
    
    
    
    
    
    
    
    
    
}

