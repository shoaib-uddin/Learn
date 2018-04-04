//
//  HeadViewCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 03/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class HeadViewCVC: UICollectionViewCell {

    @IBOutlet weak var lblHeading: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        let bclr = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        
        self.lblHeading.textColor = bclr;
        self.backgroundColor = clr;
    }
    
    func setData(heading: String){
        self.lblHeading.text = heading;
    }

}
