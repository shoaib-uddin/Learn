//
//  MainVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 15/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import Photos
import PhotosUI

class MainVC: BaseVC{
    
    var Facts: [[String: Any]] = [[:]];
    var refresher:UIRefreshControl!;
    @IBOutlet weak var collectionView: UICollectionView!;
    
    
    override func viewDidLoad() {
        //
        super.viewDidLoad();
        
        print("Hello");
        collectionView.register(UINib(nibName: "GalleryImageCVC", bundle: nil), forCellWithReuseIdentifier: "GalleryImageCVC");
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        self.refresher = UIRefreshControl();
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
        loadData();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
        
    }
    
}
