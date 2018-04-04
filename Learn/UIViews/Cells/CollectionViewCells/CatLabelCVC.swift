//
//  CatLabelCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 03/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class CatLabelCVC: UICollectionViewCell {

    
    @IBOutlet weak var imgFontIcon: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        self.lblname.textColor = clr
        
    }
    
    func setData(lblString: String, icon: String){
        
        lblname.text = lblString;
        //StyleHelper.setFontImageVisualsMaterial(imgFontIcon, name: icon)
        StyleHelper.setFontImageVisualsFontAwesome(imgFontIcon, name: icon);
    }
    
    

}
