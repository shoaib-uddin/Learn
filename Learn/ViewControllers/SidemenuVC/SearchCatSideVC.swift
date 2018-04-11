//
//  SearchCatSideVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 11/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

class SearchCatSideVC : BaseVC, UniHeaderCVCDelegate, TableSearchCVCDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionArray: [EnDDL] = [EnDDL]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        
        //        let returnSettings: Settings = CoreDataHelper.returnSettings();
        //        print(returnSettings.background ?? "Error getting settings background");
        
        
        
        
        
        
        collectionView.register(UINib(nibName: "UniHeaderCVC", bundle: nil), forCellWithReuseIdentifier: "UniHeaderCVC");
        collectionView.register(UINib(nibName: "TableSearchCVC", bundle: nil), forCellWithReuseIdentifier: "TableSearchCVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        LearnottoApi.getCategories { (success, data) in
            if(success){
                
                if let d = data{
                    self.collectionArray = d;
                    self.collectionView.reloadData();
                }
                
                
            }
        }
        
    }
    
    func UniHeaderCVCClose(cell: UniHeaderCVC, doCLose: Bool) {
        //
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func setAndCloseSearch(cell: TableSearchCVC, doCLose: Bool) {
        //
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
}

extension SearchCatSideVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // this collectionView is for Bottom Part of Screen where collectionView flow is vertical
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        
        if(indexPath.row == 0){
            let width = (collectionView.frame.width);
            return CGSize(width: width, height: 60);
        }else{
            let width = (collectionView.frame.width);
            return CGSize(width: width, height: self.view.frame.height - 30);
        }
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
            
            if(indexPath.row == 0){
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UniHeaderCVC", for: indexPath) as? UniHeaderCVC
                    else { fatalError("unexpected cell in collection view") }
                cell.setData(heading: "SEARCH");
                cell.cellDelegate = self;
                return cell;
                
            }else{
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableSearchCVC", for: indexPath) as? TableSearchCVC
                    else { fatalError("unexpected cell in collection view") }
                cell.cellDelegate = self;
                return cell;
            }
            
        
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return 2;
        
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


