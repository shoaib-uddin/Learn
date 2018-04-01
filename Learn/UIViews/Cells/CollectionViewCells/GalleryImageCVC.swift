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
    @IBOutlet var lblRef: UILabel!
    
    
    @IBOutlet weak var quoteView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    
    
    
    func setData(_ data: EnFact){
        
        print(data);
        self.lblText.text = data.Content;
        self.lblRef.text = data.Reference;
        
    }
    
    func setData(_ data: Background){
        
        print(data);
        self.lblText.text = data.text
        
        if(data.background != nil){
            FileApi.retrieveImageFromDocFolder(name: data.background!) { (image) in
                self.imageView.image = image;
            }
        }
        
        
    }
    
    
    
    func setFont(name: String){
        self.lblText.font = UIFont(name: name, size: lblText.font.pointSize);
    }
    
    func addTickMark(){
        let width = self.frame.width;
        let height = self.frame.height;
        
        let imageName = "check.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: width - (width * 0.2) - 10, y: height - (width * 0.2) - 10, width: width * 0.2, height: width * 0.2);
        imageView.tag = 34;
        
        
        let blurOverlay: UIView = UIView();
        blurOverlay.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4);
        blurOverlay.frame = CGRect(x: 0, y: 0, width: width, height: height);
        blurOverlay.tag = 35
        self.addSubview(blurOverlay);
        self.addSubview(imageView);
        
        
        
        
        
        
    }
    
    func removeTickMark(){
        
        for view in self.subviews {
            if(view.tag == 34 || view.tag == 35){
                view.removeFromSuperview();
            }
            
        }
        
    }

}
