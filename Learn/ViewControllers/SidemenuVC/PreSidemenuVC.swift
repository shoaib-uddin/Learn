//
//  PreSidemenuVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 02/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import SwiftIconFont

class PreSidemenuVC: UIViewController {
    
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        //
        collectionView.register(UINib(nibName: "SidemenuTableHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader");
        
        collectionView.register(UINib(nibName: "ImageTitleDesTVC", bundle: nil), forCellWithReuseIdentifier: "ImageTitleDesTVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        // CSS Needs
        btnClose.parseIcon();
        
        
        
    }
    
}

extension PreSidemenuVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = self.collectionView.frame.width
        return CGSize(width: width, height: 30);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //
        var reusableView: UICollectionReusableView? = nil;
        
        if(kind == UICollectionElementKindSectionHeader){
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader", for: indexPath) as! SidemenuTableHeader;
            reusableView =  header;
        }
        
        return reusableView!;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        let width = (collectionView.frame.width);
        return CGSize(width: width, height: 60);
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageTitleDesTVC", for: indexPath) as? ImageTitleDesTVC
                else { fatalError("unexpected cell in collection view") }
            
            
            
        
            
            
            return cell;
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return 5;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
        
    }
    
}

