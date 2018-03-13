//
//  SettingsVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 11/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SettingsVC: UIViewController{
    
    var fonts = [String]();
    var backgrounds = [String]();
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init header
        
        self.backgrounds = CoreDataHelper().backgrounds;
        self.fonts = CoreDataHelper().returnFonts();
        
        collectionView.register(UINib(nibName: "GalleryImageCVC", bundle: nil), forCellWithReuseIdentifier: "GalleryImageCVC");
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        collectionView.reloadData();
        
        
        
        
        
    }
    
    
    
    
}
