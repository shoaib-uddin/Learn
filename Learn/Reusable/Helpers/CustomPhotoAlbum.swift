//
//  CustomPhotoAlbum.swift
//  PolaroidPopLayouts
//
//  Created by clines227 on 13/06/2017.
//  Copyright © 2017 matech. All rights reserved.
//

import Foundation
import Photos
import PhotosUI


class CustomPhotoAlbum: NSObject {
    static let albumName = settings.albumName;
    static let sharedInstance = CustomPhotoAlbum()
    
    var assetCollection: PHAssetCollection!
    
    override init() {
        super.init()
        
        if let assetCollection = fetchAssetCollectionForAlbum() {
            self.assetCollection = assetCollection
            return
        }
        
        
        
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                ()
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            self.createAlbum()
        } else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            // ideally this ensures the creation of the photo album even if authorization wasn't prompted till after init was done
            print("trying again to create the album")
            self.createAlbum()
        } else {
            print("should really prompt the user to let them know it's failed")
        }
    }
    
    func createAlbum() {
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: CustomPhotoAlbum.albumName)   // create an asset collection with the album name
        }) { success, error in
            if success {
                self.assetCollection = self.fetchAssetCollectionForAlbum()
            } else {
                print("error \(error)")
            }
        }
    }
    
    func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", CustomPhotoAlbum.albumName)
        let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
        
        if let _: AnyObject = collection.firstObject {
            return collection.firstObject
        }
        return nil
    }
    
    func NoReturnSave(image: UIImage) {
        if assetCollection == nil {
            return                          // if there was an error upstream, skip the save
        }
        
        var placeholder: PHObjectPlaceholder?
        PHPhotoLibrary.shared().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            var assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
            
            guard let photoPlaceholder = assetChangeRequest.placeholderForCreatedAsset else { return }
            placeholder = photoPlaceholder
            
            
            let enumeration: NSArray = [assetPlaceHolder!]
            albumChangeRequest!.addAssets(enumeration)
            
            }, completionHandler: { success, error in
                
            })
    }

    
    func save(image: UIImage, completion: @escaping (_ callback: PHAsset?) -> Void) {
        if assetCollection == nil {
            return                          // if there was an error upstream, skip the save
        }
        
        var placeholder: PHObjectPlaceholder?
        var php = PHPhotoLibrary.shared();
        php.performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            var assetPlaceHolder = assetChangeRequest.placeholderForCreatedAsset;
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: self.assetCollection)
            
            guard let photoPlaceholder = assetChangeRequest.placeholderForCreatedAsset else { return }
            placeholder = photoPlaceholder
            
            
            let enumeration: NSArray = [assetPlaceHolder!]
            albumChangeRequest!.addAssets(enumeration)
            
            }, completionHandler: { success, error in
                
                if success {
                    
                    let asst:PHFetchResult<PHAsset> = PHAsset.fetchAssets(withLocalIdentifiers: [(placeholder?.localIdentifier)!], options: nil)
                    
                    let asset:PHAsset? = asst.firstObject;
                    completion(asset!)
                } else {
                    completion(nil)
                }
        })
    }
    
    func delete(asset: PHAsset, completion: @escaping (_ callback: Bool) -> Void) {
        
        let php = PHPhotoLibrary.shared();
        php.performChanges({
            PHAssetChangeRequest.deleteAssets([asset] as NSFastEnumeration);
            
            }, completionHandler: { success, error in
                
                if success {
                    completion(true);
                } else {
                    completion(false);
                }
        })
    }

}
