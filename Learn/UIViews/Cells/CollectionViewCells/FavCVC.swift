//
//  FavCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 11/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class FavCVC: UICollectionViewCell {

    
    var favCount: Int = 0;
    var facts: [EnFact] = [EnFact]();
    @IBOutlet weak var collectionView: UICollectionView!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UINib(nibName: "GalleryImageCVC", bundle: nil), forCellWithReuseIdentifier: "GalleryImageCVC");
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        facts.removeAll();
        
        if let _user = CoreDataHelper.returnUser(),      let _id = _user.id{
            
            LearnottoApi.getFavFacts(_id, 0, size: 5000) { (success, facts) in
                //
                if(success){
                    self.facts = facts!;
                    self.collectionView.reloadData();
                }
            }
            
        }
        
            
            
        
        
    }

}

extension FavCVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
        
        
        
        let fact = facts[indexPath.row];
        cell.setData(fact);
        cell.lblText.font = UIFont(name: globalSettings.font!, size: cell.lblText.font.pointSize);
        //cell.imageView.isHidden = true;
        //cell.lblText.text = fact.ID!;
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

