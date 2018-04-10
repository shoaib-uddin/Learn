//
//  SidemenuTableHeader.swift
//  Learn
//
//  Created by Xtreme Hardware on 02/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class SidemenuTableHeader: UICollectionReusableView {

    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblSubHeading: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        self.lblHeading.textColor = clr;
        self.lblSubHeading.textColor = clr;
    }
    
    func setData(heading: String, subheading: String){
        self.lblHeading.text = heading;
        self.lblSubHeading.text = subheading;
    }
    
}
