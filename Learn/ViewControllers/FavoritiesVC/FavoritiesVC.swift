//
//  FavoritiesVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 11/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

class FavoritiesVC: BaseVC, UniHeaderCVCDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var FavCount: Int = 0;
    var collectionArray: [[String: Any]] = [[String: Any]]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        collectionView.register(UINib(nibName: "HeadViewCVC", bundle: nil), forCellWithReuseIdentifier: "HeadViewCVC");
        collectionView.register(UINib(nibName: "UniHeaderCVC", bundle: nil), forCellWithReuseIdentifier: "UniHeaderCVC");
        collectionView.register(UINib(nibName: "FavCVC", bundle: nil), forCellWithReuseIdentifier: "FavCVC");
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
        
    }
    
    func UniHeaderCVCClose(cell: UniHeaderCVC, doCLose: Bool) {
        //
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
}

extension FavoritiesVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        
        
        if(indexPath.row == 0 || indexPath.row == 1){
            let width = (collectionView.frame.width);
            return CGSize(width: width, height: 60);
        }else{
            let width = (collectionView.frame.width);
            return CGSize(width: width, height: UIScreen.main.bounds.height - 140);
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
            
        if(indexPath.row == 0){
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UniHeaderCVC", for: indexPath) as? UniHeaderCVC
                else { fatalError("unexpected cell in collection view") }
            cell.setData(heading: "FAVORITES");
            cell.cellDelegate = self;
            return cell;
            
        }else
        if(indexPath.row == 1){
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadViewCVC", for: indexPath) as? HeadViewCVC
                else { fatalError("unexpected cell in collection view") }
            cell.setData(heading: "Your Most Favorite ... Facts");
            
            return cell;
            
            
        }
        else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavCVC", for: indexPath) as? FavCVC
                else { fatalError("unexpected cell in collection view") }
        
            cell.favCount = FavCount;
            return cell;
            
        }
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return 3;
        
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


