//
//  SettingsCVVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 13/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

extension SettingsVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        let width = (collectionView.frame.width/3);
        return CGSize(width: width, height: width);
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        
        
        // Dequeue a GridViewCell.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GalleryImageCVC.self), for: indexPath) as? GalleryImageCVC
            else { fatalError("unexpected cell in collection view") }
        
        return cell;
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return fonts.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderCRV", for: indexPath) as! HeaderCRV;
        
        header.lblHeading.text = fonts[indexPath.row];
        
        return header
    }
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        
        
        return backgrounds.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        // celldelegate?.redirectToContacts(self);
        let cell = collectionView.cellForItem(at: indexPath) as! GalleryImageCVC;
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        let cell = collectionView.cellForItem(at: indexPath) as! GalleryImageCVC;
        
        
    }
    
}
