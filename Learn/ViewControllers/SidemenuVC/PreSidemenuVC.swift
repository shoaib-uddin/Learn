//
//  PreSidemenuVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 11/03/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

@objc protocol PreSidemenuVCDelegate {
    func selectedMenuItem(vc: PreSidemenuVC, menu: String);
}


class PreSidemenuVC: BaseVC, UniHeaderCVCDelegate, CatSidemenuVCDelegate, SettingsVCDelegate{
    func updateViewBySettings() {
        //
        DispatchQueue.main.async {
            self.vcDelegate?.selectedMenuItem(vc: self, menu: "STY");
            self.dismiss(animated: true, completion: nil)
        }
                
    }
    
    func changeCategoryCollection(vc: CatSidemenuVC, catId: String) {
        //
        DispatchQueue.main.async {
            self.dismiss(animated: true) {
                self.vcDelegate?.selectedMenuItem(vc: self, menu: "CAT");
            }
        }
        
        
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var ffavCount: Int = 0;
    var collectionArray: [[String: Any]] = [[String: Any]]();
    weak var vcDelegate: PreSidemenuVCDelegate?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        collectionView.register(UINib(nibName: "SidemenuTableHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader");
        
        collectionView.register(UINib(nibName: "UniHeaderCVC", bundle: nil), forCellWithReuseIdentifier: "UniHeaderCVC");
        collectionView.register(UINib(nibName: "ImageTitleDesTVC", bundle: nil), forCellWithReuseIdentifier: "ImageTitleDesTVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        self.collectionArray = UtilityHelper.getPlistContent(name: "sidemenu");
        self.collectionView.reloadData();
        
        
        
        
    }
    
    func UniHeaderCVCClose(cell: UniHeaderCVC, doCLose: Bool) {
        //
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func DisplayReviewController() {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        }
    }
    
    
    
    
    
}

extension PreSidemenuVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // this collectionView is for Bottom Part of Screen where collectionView flow is vertical
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if(section == 0){
            let width = self.collectionView.frame.width
            return CGSize(width: width, height: 0);
        }else{
            let width = self.collectionView.frame.width
            return CGSize(width: width, height: 40);
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //
        var reusableView: UICollectionReusableView? = nil;
        
        if(kind == UICollectionElementKindSectionHeader){
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SidemenuTableHeader", for: indexPath) as! SidemenuTableHeader;
            //
            header.setData(heading: "", subheading: "About US");
            
            reusableView =  header;
        }
        
        return reusableView!;
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        
        let width = (collectionView.frame.width);
        return CGSize(width: width, height: 70);
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
        
        
        if(indexPath.section == 0){
            
            if(indexPath.row == 0){
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UniHeaderCVC", for: indexPath) as? UniHeaderCVC
                    else { fatalError("unexpected cell in collection view") }
                cell.setData(heading: "");
                cell.cellDelegate = self;
                return cell;
                
            }else{
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageTitleDesTVC", for: indexPath) as? ImageTitleDesTVC
                    else { fatalError("unexpected cell in collection view") }
                
                let data = collectionArray[indexPath.row - 1];
                cell.setData(icon: (data["icon"] as! String), heading: ( data["Name"] as! String), subHeading: "");
                
                if(( data["Name"] as! String).contains("Favor")){
                    
                    if let _user = CoreDataHelper.returnUser(), let _id = _user.id{
                        
                        LearnottoApi.getFavFactCount(_id, completion: { (success, fav) in
                            //
                            if let c = (fav?.count! as? Int){
                                cell.lblHeading.text = cell.lblHeading.text! + "  (\(c))"
                                self.ffavCount = c;
                            }
                            
                        })
                        
                    }
                    
                    
                    
                }
                
                
                
                
                return cell;
            }
            
            
            
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageTitleDesTVC", for: indexPath) as? ImageTitleDesTVC
                else { fatalError("unexpected cell in collection view") }
            
            let data = collectionArray[indexPath.row + 5];
            cell.setData(icon: (data["icon"] as! String), heading: ( data["Name"] as! String), subHeading: "");
            
            
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
            return collectionArray.count - 1;
        }else if(section == 1){
            return 2;
        }else{
            return 0;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        
        if(indexPath.section == 1){
            
            let c = self.collectionArray[indexPath.row + 5];
            
            switch c["key"] as! String {
            case "REV":
                DisplayReviewController()
                break;
            case "MAL":
                
                break;
                
            default:
                break;
            }
            
        }else{
            
            var indec = (indexPath.row <= 0) ? 0 : indexPath.row - 1;
            let c = self.collectionArray[indec];
            
            switch c["key"] as! String {
            case "REM":
                PageRedirect.redirectToReminderPage(self);
                break;
            case "CAT":
                PageRedirect.redirectToCatSidemenuPage(self, true);
                break;
            case "STY":
                PageRedirect.redirectToSettingsPage(self);
                break;
            case "SRC":
                PageRedirect.redirectToSearchCatPage(self);
                break;
            case "FAV":
                if(self.ffavCount > 0){
                    PageRedirect.redirectToFavFactsPage(count: self.ffavCount, self);
                }
                
                break;
                
            default:
                break;
            }
            
            
        }
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
        
    }
    
}


