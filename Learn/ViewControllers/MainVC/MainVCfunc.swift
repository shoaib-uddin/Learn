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

extension MainVC: SettingsVCDelegate, SidemenuVCDelegate{
    func receiveCategoryOfSidemenu(parent: EnDDL, cat: EnDDL) {
        
        print(parent.ID!, cat.ID!);
        UtilityHelper.setKey(api.savedCatId, KeyValue: parent.ID!);
        UtilityHelper.setKey(api.savedSubCatId, KeyValue: cat.ID!);
        
        
        
        getFacts(page: 0, subCat: Int(cat.ID!));
    }
    
    
    // don't delete, its a delegate function
    func updateViewBySettings() {
        setBg();
        setFont();
        self.collectionView.reloadData();
    }
    
    @objc func loadData() {
        //code to execute during refresher
        setBg();
        setFont();
        getFacts(page: 0, subCat: nil);
        stopRefresher()         //Call this to stop refresher
    }
    
    func setFont(){
        let data = CoreDataHelper.returnSettings();
        self.localFontName = data.font!;
    }
    
    func setBg(){
        let data = CoreDataHelper.returnSettings();
        FileApi.retrieveImageFromDocFolder(name: data.background!) { (image) in
            self.globalImageView.image = image
        }
    }
    
    func getFacts(page: Int, subCat: Int!){
        
        facts.removeAll();
        LearnottoApi.getFacts(signup.Id!, page, subCat: subCat) { (success, facts) in
            //
            if(success){
                self.facts = facts!;
                self.collectionView.reloadData();
            }
            
        }
//        CoreDataHelper.returnFacts(ofCategory: "") { (arr) in
//            self.facts = arr;
//            self.collectionView.reloadData();
//        }
        
        
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    
}
