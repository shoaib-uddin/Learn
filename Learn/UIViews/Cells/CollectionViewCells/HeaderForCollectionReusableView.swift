//
//  HeaderForCollectionReusableView.swift
//  VKPolaroidIPCamera
//
//  Created by clines227 on 14/11/2016.
//  Copyright © 2016 Sample. All rights reserved.
//

import UIKit

class HeaderForCollectionReusableView: UICollectionReusableView {

    
    
    @IBOutlet weak var lblCollectionViewSectionHeading: UILabel!
    @IBOutlet weak var lblCollectionViewSectionSubHeading: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(heading: String, subheading: String){
        lblCollectionViewSectionHeading.text = heading;
        // rotate label vertically
        self.rotateLabel(label: self.lblCollectionViewSectionHeading);
        
    }
    
    fileprivate func rotateLabel(label: UILabel){
        
        let orig = label.frame;
        let angle = Double.pi * (3/2);
        label.transform = CGAffineTransform(rotationAngle: CGFloat(angle));
        label.frame = orig;
    
    }
    
}
