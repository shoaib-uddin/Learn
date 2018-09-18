//
//  ExtensionHelper.swift
//  Learn
//
//  Created by Xtreme Hardware on 18/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



extension Date {
    var localizedDescription: String {
        return description(with: .current)
    }
    
    var convertedDate:Date {
        
        let dateFormatter = DateFormatter();
        
        let dateFormat = "dd MMM yyyy";
        dateFormatter.dateFormat = dateFormat;
        let formattedDate = dateFormatter.string(from: self);
        
        dateFormatter.locale = NSLocale.current;
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00");
        
        dateFormatter.dateFormat = dateFormat as String;
        let sourceDate = dateFormatter.date(from: formattedDate as String);
        
        return sourceDate!;
    }
    
    func adding(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
}

extension String {
    
    func ToDictionary() -> [String:AnyObject]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}


extension UIView{
    
    func setBorder(color: UIColor, radius: Int, width: Int){
        self.layoutIfNeeded();
        self.layer.cornerRadius = CGFloat(radius);
        self.clipsToBounds = true;
        self.layer.borderColor = color.cgColor;
        self.layer.borderWidth = CGFloat(width);
    }
    
    func snapshot(of rect: CGRect? = nil) -> UIImage? {
        // snapshot entire view
        
        if(rect == nil){
            UIGraphicsBeginImageContextWithOptions(CGSize(width: round(self.bounds.size.width), height: round(self.bounds.size.height)), false, 0.0)
            let contextx: CGContext? = UIGraphicsGetCurrentContext()
            self.layer.render(in: contextx!)
            let capturedScreen: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return capturedScreen!
        }else{
            
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0);
            
            
            //UIGraphicsBeginImageContext(self.frame.size)
            drawHierarchy(in: bounds, afterScreenUpdates: true)
            let wholeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // if no `rect` provided, return image of whole view
            
            guard let image = wholeImage, let rect = rect else { return wholeImage }
            
            // otherwise, grab specified `rect` of image
            
            let scale = image.scale
            let scaledRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
            guard let cgImage = image.cgImage?.cropping(to: scaledRect) else { return nil }
            return UIImage(cgImage: cgImage, scale: scale, orientation: .up)
            
        }
        
    }
    
}



extension NSArray
{
    
    func ToString() ->String
    {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            return jsonString;
            // here "jsonData" is the dictionary encoded in JSON data
        } catch let error as NSError {
            print(error)
        }
        return "";
    }
    
}

extension Int{
    func  toString() -> String{
        return String(describing: self);
    }
    
    static func random(range: Range<Int> ) -> Int
    {
        var offset = 0
        
        if range.lowerBound < 0   // allow negative ranges
        {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
    
}

