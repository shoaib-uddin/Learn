//
//  FontsCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 13/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class FontsCVC: UICollectionViewCell {

    @IBOutlet weak var lblFont: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setData(_ data: Font){
        
        lblFont.font = UIFont(name: data.type!, size: lblFont.font.pointSize);
        
        
    }
    
    func addTickMark(){
        let width = self.frame.width;
        let height = self.frame.height;
        
        let imageName = "check.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        
        imageView.frame = CGRect(x: width - (width * 0.2) - 10, y: height - (height * 0.2) - 10, width: width * 0.2, height: width * 0.2);
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
