//
//  SettingsVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 11/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsVCDelegate: class {
    func updateViewBySettings();
}


class SettingsVC : BaseVC, UniHeaderCVCDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionArray: [Background] = [Background]();
    weak var vcDelegate: SettingsVCDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);

//        let returnSettings: Settings = CoreDataHelper.returnSettings();
//        print(returnSettings.background ?? "Error getting settings background");
        collectionArray = CoreDataHelper.settingPlist();
        collectionView.register(UINib(nibName: "SidemenuTableHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader");
        collectionView.register(UINib(nibName: "UniHeaderCVC", bundle: nil), forCellWithReuseIdentifier: "UniHeaderCVC");
        collectionView.register(UINib(nibName: "HeadViewCVC", bundle: nil), forCellWithReuseIdentifier: "HeadViewCVC");
        collectionView.register(UINib(nibName: "BtnViewCVC", bundle: nil), forCellWithReuseIdentifier: "BtnViewCVC");
        collectionView.register(UINib(nibName: "GalleryImageCVC", bundle: nil), forCellWithReuseIdentifier: "GalleryImageCVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        collectionView.reloadData();
        
    }
    
    func UniHeaderCVCClose(cell: UniHeaderCVC, doCLose: Bool) {
        //
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    
    
    
    
    
}
