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
    
    // don't delete, its a delegate function
    func receiveCategoryOfSidemenu(cat: String) {
        print(cat);
        
        
        
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
        getFacts();
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
    
    func getFacts(){
        
        facts.removeAll();
        CoreDataHelper.returnFacts(ofCategory: "") { (arr) in
            self.facts = arr;
            self.collectionView.reloadData();
        }
        
        
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    
}
