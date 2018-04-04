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
    
    // this collectionView is for Bottom Part of Screen where collectionView flow is vertical
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if(section == 0){
            let width = self.collectionView.frame.width
            return CGSize(width: width, height: 0);
        }else{
            return CGSize.zero;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //
        var reusableView: UICollectionReusableView? = nil;
        
        if(kind == UICollectionElementKindSectionHeader){
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader", for: indexPath) as! SidemenuTableHeader;
            //
            reusableView =  header;
        }
        
        return reusableView!;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        
        if(indexPath.section == 0){
            let width = (collectionView.frame.width);
            return CGSize(width: width, height: 60);
        }else{
            let width = (collectionView.frame.width/3);
            return CGSize(width: width, height: width);
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
        
        
        if(indexPath.section == 0){
            
            if(indexPath.row == 0){
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UniHeaderCVC", for: indexPath) as? UniHeaderCVC
                    else { fatalError("unexpected cell in collection view") }
                cell.setData(heading: "STYLE");
                cell.cellDelegate = self;
                return cell;
                
            }else{
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadViewCVC", for: indexPath) as? HeadViewCVC
                    else { fatalError("unexpected cell in collection view") }
                cell.setData(heading: "Set Your Favorite Background");
                return cell;
            }
            
            
            
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryImageCVC", for: indexPath) as? GalleryImageCVC
                else { fatalError("unexpected cell in collection view") }
            
            let c = self.collectionArray[indexPath.row];
            cell.setData(c);
            
            
            return cell;
            
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        if(section == 0){
            return 2;
        }else{
            return collectionArray.count;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        let data = self.collectionArray[indexPath.row];
        print(data);
        CoreDataHelper.insertSettings(data: data) { (success) in
            if(success){
                self.dismiss(animated: true, completion: nil);
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
        
    }
    
}
