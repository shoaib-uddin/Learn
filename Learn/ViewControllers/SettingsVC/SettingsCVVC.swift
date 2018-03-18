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
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //
        var reusableView: UICollectionReusableView? = nil;
        
        if(kind == UICollectionElementKindSectionHeader && collectionView == self.horizontalCollectionView){
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderForCollectionReusableView", for: indexPath) as! HeaderForCollectionReusableView;
            header.setData(heading: "Style", subheading: "");
            reusableView =  header;
        }
        
        return reusableView!;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        
        if(collectionView == self.verticalCollectionView){
            let width = (collectionView.frame.width/3);
            return CGSize(width: width, height: width * 2);
        }else{
            let width = (collectionView.frame.width/3);
            return CGSize(width: width, height: width);
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
        
        
        if(collectionView == self.verticalCollectionView){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryImageCVC", for: indexPath) as? GalleryImageCVC
                else { fatalError("unexpected cell in collection view") }
            
            
            
            let c = self.verticalCollectionArray[indexPath.row];
            cell.setData(c);
            cell.setFont(name: self.localFontName);
            
            
            cell.removeTickMark();
            if(self.selectedImageIndex == indexPath){
                cell.addTickMark();
            }
            
            
            return cell;
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FontsCVC", for: indexPath) as? FontsCVC
                else { fatalError("unexpected cell in collection view") }
            
            cell.setData(self.horizontalCollectionArray[indexPath.row]);
            
            return cell;
            
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        
        if(collectionView == self.verticalCollectionView){
            return verticalCollectionArray.count;
        }else{
            return horizontalCollectionArray.count;
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        // celldelegate?.redirectToContacts(self);
        //cell?.setBorder(color: "#9c9c9c", radius: 10, width: 2);
        
        
        if(collectionView == self.verticalCollectionView){
            
            if let previousCell = self.verticalCollectionView.cellForItem(at: self.selectedImageIndex) as? GalleryImageCVC{
                
                previousCell.removeTickMark();
                
            }
            
            
            if let cell = self.verticalCollectionView.cellForItem(at: indexPath) as? GalleryImageCVC{
                
                cell.addTickMark();
                self.selectedImageIndex = indexPath;
                
            }
            
            
            
        }
        
        
        if(collectionView == self.horizontalCollectionView){
            
            let data = horizontalCollectionArray[indexPath.row];
            self.localFontName = data.type!;
            self.verticalCollectionView.reloadData();
            
            
            
        }
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
        
        if(collectionView == self.verticalCollectionView){
            
            
            if let cell = self.verticalCollectionView.cellForItem(at: indexPath) as? GalleryImageCVC{
                
                cell.removeTickMark();
                
            }
            
            
            
        }
        
        
        
        
        
        
    }
    
}
