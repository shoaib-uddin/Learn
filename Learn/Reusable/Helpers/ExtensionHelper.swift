//
//  ExtensionHelper.swift
//  Learn
//
//  Created by Xtreme Hardware on 18/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
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
