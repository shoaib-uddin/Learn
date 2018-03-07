//
//  FileHelperApi.swift
//  Learn
//
//  Created by Xtreme Hardware on 20/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import Photos;

class FileApi{
    
    class func clearTempFolder() {
        let fileManager = FileManager.default
        let tempFolderPath = NSTemporaryDirectory()
        do {
            let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
            for filePath in filePaths {
                try fileManager.removeItem(atPath: tempFolderPath + filePath)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
    
    
    class func copyImageToDocFolder(image: UIImage, fileName: String, completion: @escaping (_ url: URL, _ size: CGSize, _ totalSize: Int?) -> Void){
        
        if let data = UIImageJPEGRepresentation(image, 1) {
            
            self.saveImageInDocDirectory(data: data, fileName: fileName, successblock: { (path) in
                // if path is not nil
                if let filepath = path{
                    
                    let url = URL(fileURLWithPath: filepath);
                    let size = self.sizeOfImage(at: url);
                    var fileSize: Int!;
                    
                    let filemanager:FileManager = FileManager();
                    do {
                        fileSize = try filemanager.attributesOfItem(atPath: url.path)[FileAttributeKey.size]! as! Int;
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    print(size);
                    completion(url, size, fileSize);
                    
                }
                
            })
            
        }
        
    }
    
    class func retrieveImageFromDocFolder(name: String, completion: @escaping (_ image: UIImage) -> Void){
        
        // Get the document directory url
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        var list: [URL] = [URL]();
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            //print(directoryContents)
            
            // if you want to filter the directory contents you can do like this:
            let gifFiles = directoryContents.filter{ $0.pathExtension == "jpg" }
            //print("gif urls:",gifFiles);
            
            //let gifFilesStringPath = gifFiles.map{ $0.path }
            //print("gif StringUrls:",gifFilesStringPath);
            
            
            //let gifFileNames = gifFiles.map{ $0.deletingPathExtension().lastPathComponent }
            //print("gif list:", gifFileNames)
            
            list = gifFiles;
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        print(list) ;
        
        // Get the document directory url
        let documentsDirectory =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fullImgNm: URL = documentsDirectory.appendingPathComponent(name)
        let image = UIImage(contentsOfFile: fullImgNm.path)!
        completion(image);
        
        
    }
    
    class func sizeOfImage(at imageURL: URL) -> CGSize {
        // With CGImageSource we avoid loading the whole image into memory
        var imageSize = CGSize.zero
        
        
        let source: CGImageSource? = CGImageSourceCreateWithURL(imageURL as CFURL, nil)
        if source != nil {
            let options: [AnyHashable: Any]? = [ kCGImageSourceShouldCache as String : Int(truncating: false) ]
            let properties: CFDictionary? = (CGImageSourceCopyPropertiesAtIndex(source!, 0, options as CFDictionary?))
            
            if properties != nil {
                let width = (properties as? [AnyHashable: Any])?[(kCGImagePropertyPixelWidth as String)] as? NSNumber ?? 0
                let height = (properties as? [AnyHashable: Any])?[(kCGImagePropertyPixelHeight as String)] as? NSNumber ?? 0
                if (width != 0) && (height != 0) {
                    
                    imageSize = CGSize(width: CGFloat(truncating: width), height: CGFloat(truncating: height));
                }
            }
        }
        return imageSize
    }
    
    class func saveImageInDocDirectory(data: Data?, fileName: String?, successblock: @escaping (_ path: String?) -> Void) { // To add the image to cache for given identifier.
        
        let filemanager:FileManager = FileManager()
        
        let paths = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true)[0] as String
        let path = paths.appending("/\(fileName!)")
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(at: URL(fileURLWithPath: path), withIntermediateDirectories: false, attributes: nil)
            } catch {
                print("Error creating images folder in Doc dir: \(error.localizedDescription)")
            }
        }
        
        if (filemanager.fileExists(atPath: path)) {
            try! filemanager.removeItem(atPath: path)
        }
        do {
            try data?.write(to: URL(fileURLWithPath: path, isDirectory: false))
            successblock(path)
        } catch {
            successblock(nil)
            print("Error while caching the data in Doc folder.")
        }
        
        
    }
    
    
    
    
    
}

