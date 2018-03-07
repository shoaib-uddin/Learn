//
//  AssetImageApi.swift
//  Learn
//
//  Created by Xtreme Hardware on 17/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import Photos
import PhotosUI

class AssetImageApi: NSObject{
    
    var AssociatedImages : [String] =  [String]();
    var assetCollection: PHAssetCollection!
    var fetchResult: PHFetchResult<PHAsset>!
    var smartAlbums: PHFetchResult<PHAssetCollection>!
    var userCollections: PHFetchResult<PHCollection>!
    fileprivate let imageManager = PHCachingImageManager()
    fileprivate var thumbnailSize: CGSize!
    fileprivate var previousPreheatRect = CGRect.zero;
    
    override init() {
        super.init();
        
    }
    
    func initialize(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 , execute: {
            // dequeue code here
            
        })
        
    }
    
    
}

extension AssetImageApi{
    
    // input UIImageView -> output asset image of the size of input view
    func getImageforView(imageView: UIImageView, asset: PHAsset,  completion: @escaping (_ callback: UIImage) -> Void){
        
        var targetSize: CGSize {
            let scale = UIScreen.main.scale
            return CGSize(width: imageView.bounds.width * scale,
                          height: imageView.bounds.height * scale)
        }
        
        // Prepare the options to pass when fetching the (photo, or video preview) image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.progressHandler = { progress, _, _, _ in
            
        }
        
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { image, _ in
            // Hide the progress view now the request has completed.
            
            // If successful, show the image view and display the image.
            guard let image = image else { return }
            completion(image);
            
            
        })
        
    }
    
    // input UIImageView -> output asset image of the size of input view
    func getImage(asset: PHAsset,  completion: @escaping (_ callback: UIImage) -> Void){
        
        // Prepare the options to pass when fetching the (photo, or video preview) image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        options.progressHandler = { progress, _, _, _ in
            
        }
        
        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options, resultHandler: { image, _ in
            // Hide the progress view now the request has completed.
            
            // If successful, show the image view and display the image.
            guard let image = image else { return }
            completion(image);
            
            
        })
        
    }
    
    
    
    // input UIImageView -> output asset image of the size of input view
    func getImageOfSize(width: CGFloat, height: CGFloat, asset: PHAsset,  completion: @escaping (_ callback: UIImage) -> Void){
        
        var targetSize: CGSize {
            return CGSize(width: width, height: height)
        }
        
        // Prepare the options to pass when fetching the (photo, or video preview) image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat;
        options.resizeMode = .exact;
        
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options, resultHandler: { image, _ in
            // Hide the progress view now the request has completed.
            
            // If successful, show the image view and display the image.
            guard let image = image else { return }
            completion(image);
            
            
        })
        
    }
    
    // input UIImageView -> output asset image of the size of input view
    func getImageOfSizeFit(width: CGFloat, height: CGFloat, asset: PHAsset,  completion: @escaping (_ callback: UIImage) -> Void){
        
        var targetSize: CGSize {
            return CGSize(width: width, height: height)
        }
        
        // Prepare the options to pass when fetching the (photo, or video preview) image.
        let options = PHImageRequestOptions()
        options.deliveryMode = .opportunistic;
        options.resizeMode = .exact;
        
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { image, _ in
            // Hide the progress view now the request has completed.
            
            // If successful, show the image view and display the image.
            guard let image = image else { return }
            completion(image);
            
            
        })
        
    }
    
    
    
    
}
