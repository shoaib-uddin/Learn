//
//  UniHeaderCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 03/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit
//import FontAwesome_swift
import SwiftIconFont

protocol UniHeaderCVCDelegate: class {
    func UniHeaderCVCClose(cell: UniHeaderCVC, doCLose: Bool);
}


class UniHeaderCVC: UICollectionViewCell {

    @IBOutlet weak var imgCross: UIImageView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    weak var cellDelegate: UniHeaderCVCDelegate?;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        self.lblHeading.textColor = clr
        StyleHelper.setFontImageVisualsMaterial(imgCross, name: "clear");
        
        


    }
    
    func setData(heading: String){
        self.lblHeading.text = heading;
    }
    
    @IBAction func doClose(_ sender: UIButton) {
        cellDelegate?.UniHeaderCVCClose(cell: self, doCLose: true);
    }
    
    

}
