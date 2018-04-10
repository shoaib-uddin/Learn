//
//  SidemenuParentTVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 18/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class SidemenuParentTVC: UITableViewCell {

    
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var tickImage: UIImageView!
    
    
    override func prepareForReuse() {
        //
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        self.menuLabel.textColor = clr
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        self.menuLabel.textColor = clr
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(lbl: EnDDL){
        
        menuLabel.text = lbl.Name!;
        
    }
    
}
