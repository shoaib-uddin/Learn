//
//  SlideVCfunc.swift
//  Learn
//
//  Created by Xtreme Hardware on 17/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import Photos
import PhotosUI

extension MainVC: SettingsVCDelegate{
    
    // don't delete, its a delegate function
    func updateViewBySettings() {
        self.collectionView.reloadData();
    }
    
    @objc func loadData() {
        //code to execute during refresher
        getFacts(page: 0, subCat: globalCatId);
        stopRefresher()         //Call this to stop refresher
    }
    
    
    
    func getFacts(page: Int, subCat: String!){
        
        facts.removeAll();
        LearnottoApi.getFacts(signup.Id!, page, subCat: subCat) { (success, facts) in
            //
            if(success){
                self.facts = facts!;
                self.collectionView.reloadData();
            }
            
        }
        
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    
}
