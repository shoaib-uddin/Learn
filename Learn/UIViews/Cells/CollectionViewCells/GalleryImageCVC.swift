//
//  GalleryImageCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 17/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class GalleryImageCVC: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var coverView: UIView!
    @IBOutlet var lblText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(_ data: [String: Any]){
        
        let width = self.imageView.frame.width;
        let height = self.imageView.frame.height;
        
        do {
            
            FileApi.retrieveImageFromDocFolder(name: (data["background"] as! String), completion: { (image) in
                //
                self.imageView.image = image;
                self.lblText.text = data["text"] as! String;
            })
            
        } catch {
            print("Error loading image : \(error)")
        }
        
        
        
        
        
        
    }

}
