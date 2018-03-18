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


class SettingsVC : UIViewController{
    
    
    
    @IBOutlet weak var imgIcons: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var btnSync: UIButton!;
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!
    @IBOutlet weak var verticalCollectionView: UICollectionView!
    
    var horizontalCollectionArray: [Font] = [Font]();
    var verticalCollectionArray: [Background] = [Background]();
    
    var localFontName: String = "";
    var selectedImageIndex: IndexPath!;
    weak var vcDelegate: SettingsVCDelegate?;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let returnSettings: Settings = CoreDataHelper.returnSettings();
        print(returnSettings.background ?? "Error getting settings background");
        self.localFontName = returnSettings.font!;
        
        horizontalCollectionArray = CoreDataHelper.returnFonts();
        verticalCollectionArray = CoreDataHelper.returnBackgrounds();
        
        
        horizontalCollectionView.register(UINib(nibName: "HeaderForCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderForCollectionReusableView");
        
        horizontalCollectionView.register(UINib(nibName: "FontsCVC", bundle: nil), forCellWithReuseIdentifier: "FontsCVC");
        horizontalCollectionView.delegate = self;
        horizontalCollectionView.dataSource = self;
        horizontalCollectionView.allowsMultipleSelection = false;
        
        verticalCollectionView.register(UINib(nibName: "GalleryImageCVC", bundle: nil), forCellWithReuseIdentifier: "GalleryImageCVC");
        verticalCollectionView.delegate = self
        verticalCollectionView.dataSource = self;
        verticalCollectionView.allowsMultipleSelection = false;
        
        
        let index = verticalCollectionArray.index { (bg) -> Bool in
            return bg.background == returnSettings.background
        }
        
        self.selectedImageIndex = IndexPath(row: index!, section: 0);
        
        
        verticalCollectionView.reloadData();
        horizontalCollectionView.reloadData();
        
        
        
    }
    
    @IBAction func doClose(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func doAddBackground(_ sender: Any) {
        
        
        
    }
    
    @IBAction func doSaveSettings(_ sender: UIBarButtonItem) {
        
        let q = verticalCollectionArray[selectedImageIndex.row];
        CoreDataHelper.insertSettings(background: q.background!, font: self.localFontName) { (success) in
            if(success){
                print("saved");
                self.dismiss(animated: true, completion: {
                    self.vcDelegate?.updateViewBySettings();
                })
            }else{
                print("can't save");
            }
        }
        
    }
    
    
    
    
    
    
    
    
}
