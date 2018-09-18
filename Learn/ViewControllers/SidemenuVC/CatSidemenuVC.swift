//
//  CatSidemenuVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 11/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

@objc protocol CatSidemenuVCDelegate {
    func changeCategoryCollection(vc: CatSidemenuVC, catId: String);
}


class CatSidemenuVC : BaseVC, UniHeaderCVCDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionArray: [EnDDL] = [EnDDL]();
    weak var vcDelegate: CatSidemenuVCDelegate?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);

//        let returnSettings: Settings = CoreDataHelper.returnSettings();
//        print(returnSettings.background ?? "Error getting settings background");
        
        
        
        
        
        collectionView.register(UINib(nibName: "SidemenuTableHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader");
        
        collectionView.register(UINib(nibName: "HeadViewCVC", bundle: nil), forCellWithReuseIdentifier: "HeadViewCVC");
        collectionView.register(UINib(nibName: "UniHeaderCVC", bundle: nil), forCellWithReuseIdentifier: "UniHeaderCVC");
        collectionView.register(UINib(nibName: "CatLabelCVC", bundle: nil), forCellWithReuseIdentifier: "CatLabelCVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        LearnottoApi.getDefaultCategories(page: 0, size: 12) { (success, data) in
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
    
    
    
    
    
    
}

extension CatSidemenuVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
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
                cell.setData(heading: "CATEGORIES");
                cell.cellDelegate = self;
                return cell;
                
            }else{
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadViewCVC", for: indexPath) as? HeadViewCVC
                    else { fatalError("unexpected cell in collection view") }
                cell.setData(heading: "Facts we've captured by topics");
                return cell;
            }
            
            
            
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatLabelCVC", for: indexPath) as? CatLabelCVC
                else { fatalError("unexpected cell in collection view") }
            
            let c = self.collectionArray[indexPath.row];
            
            switch c.Name! {
            case "General Knowledge":
                cell.setData(lblString: c.Name!, icon: "lightbulbo");
                break;
            case "Trivia":
                cell.setData(lblString: c.Name!, icon: "questioncircleo");
                break;
            case "Animals":
                cell.setData(lblString: c.Name!, icon: "paw");
                break;
            case "History":
                cell.setData(lblString: c.Name!, icon: "history");
                break;
            case "Geography":
                cell.setData(lblString: c.Name!, icon: "mapmarker");
                break;
            case "Human Body":
                cell.setData(lblString: c.Name!, icon: "500px");
                break;
            case "Science":
                cell.setData(lblString: c.Name!, icon: "flask");
                break;
            case "Popular culture":
                cell.setData(lblString: c.Name!, icon: "puzzlepiece");
                break;
            case "Quotes":
                cell.setData(lblString: c.Name!, icon: "language");
                break;
            
            default:
                break;
            }
            
            
            
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
        let c = self.collectionArray[indexPath.row];
        globalCatId = c.ID!;
        vcDelegate?.changeCategoryCollection(vc: self, catId: c.ID!);
        self.dismiss(animated: true, completion: nil);
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
        
    }
    
}

