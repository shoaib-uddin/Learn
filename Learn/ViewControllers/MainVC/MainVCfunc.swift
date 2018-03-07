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

extension MainVC{
    
    @objc func loadData() {
        //code to execute during refresher
        getFacts();
        stopRefresher()         //Call this to stop refresher
    }
    
    func getFacts(){
        
        Facts.removeAll();
        Facts = CoreDataHelper().returnFacts(ofCategory: "");
        self.collectionView.reloadData();
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
}
