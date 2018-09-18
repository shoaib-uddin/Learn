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
    
    override func prepareForReuse() {
        //
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        self.lblText.textColor = clr
        self.lblRef.textColor = clr
        //setTextViewColor()

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        self.lblText.textColor = clr
        self.lblRef.textColor = clr
        
        //setTextViewColor()
        
        
        
    }
    
    func setTextViewColor(){
        
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        
        // create the attributed colour
        let attributedStringColor = [NSAttributedStringKey.foregroundColor : clr];
        let attributedString = NSMutableAttributedString(string: self.lblRef.text!, attributes: attributedStringColor)
        
        self.lblRef.attributedText = attributedString
        //self.lblRef.tintColor = clr;
        
    }
    
    @IBAction func doOpenUrl(_ sender: UIButton) {
        
        if let urlString = self.lblRef.text {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                if( UIApplication.shared.canOpenURL(url as URL) ){
                    UIApplication.shared.open(url as URL, options: [:]) { (success) in
                        //
                    }
                }
            }
        }
        
        
    }
    
    
    
    func setData(_ data: EnFact){
        
        print(data);
        self.lblText.text = data.Content;
        self.lblRef.text = data.Reference;
        // self.lblRef.text = "https://google.com";
        //setTextViewColor()
        
    }
    
    func setData(_ data: Background){
        
        print(data);
        self.lblText.text = "Abcd";
        
        
        if(data.ttype == "B"){
            
            if(data.background != nil){
                FileApi.retrieveImageFromDocFolder(name: data.background!) { (image) in
                    self.imageView.image = image;
                }
            }
            
            self.imageView.isHidden = false;
            
        }else{
            
            self.imageView.isHidden = true;
            
        }
        
        self.contentView.backgroundColor = StyleHelper.colorWithHexString(data.bcolor!);
        self.lblText.textColor = StyleHelper.colorWithHexString(data.fcolor!);
        self.lblText.font = UIFont(name: data.font!, size: self.lblText.font.pointSize);
        
        
        
        
        
        
        
        
        
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
