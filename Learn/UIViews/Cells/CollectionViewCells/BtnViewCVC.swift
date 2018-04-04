//
//  BtnViewCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 03/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class BtnViewCVC: UICollectionViewCell {

    
    @IBOutlet weak var btnButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnButton.backgroundColor = StyleHelper.colorWithHexString(globalSettings.fcolor!)
        btnButton.setTitleColor(StyleHelper.colorWithHexString(globalSettings.bcolor!), for: .normal);
    }
    
    func setData(heading: String){
        self.btnButton.setTitle(heading, for: .normal);
    }

}
