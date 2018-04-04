//
//  SlideVCCV.swift
//  Learn
//
//  Created by Xtreme Hardware on 17/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        let width = (collectionView.frame.width);
        let height = (collectionView.frame.height);
        return CGSize(width: width, height: height);
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        
        
        // Dequeue a GridViewCell.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GalleryImageCVC.self), for: indexPath) as? GalleryImageCVC
            else { fatalError("unexpected cell in collection view") }
        
        
        currentIndex = indexPath;
        let fact = facts[indexPath.row];
        cell.setData(fact);
        cell.lblText.font = UIFont(name: self.localFontName, size: cell.lblText.font.pointSize);
        //cell.imageView.isHidden = true;
        
        
        print(indexPath.row , fact);
        self.isLikeByMe = fact.likebyme!;
        self.factid = fact.ID!;
        
        
        
        
        if(!fact.likebyme!){
            StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite.border");
        }else{
            StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite");
        }
        
        
        return cell;
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return (facts.count != 0) ? facts.count: 0;
        
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
