//
//  BlurSharePanelView.swift
//  Learn
//
//  Created by Xtreme Hardware on 04/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

protocol BlurSharePanelViewDelegate: class {
    func BlurSharePanelViewClose(view: BlurSharePanelView, doCLose: Bool);
    func BlurSharePanelViewSelection(view: BlurSharePanelView, selection: [String: Any]);
}

class BlurSharePanelView: UIView{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var collectionArray: [[String: Any]] = [[String: Any]]();
    weak var viewDelegate: BlurSharePanelViewDelegate?;
    
    override func awakeFromNib() {
        //
        
        collectionView.register(UINib(nibName: "CatLabelCVC", bundle: nil), forCellWithReuseIdentifier: "CatLabelCVC");
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        collectionView.backgroundColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        self.collectionArray = UtilityHelper.getPlistContent(name: "sharepanel");
        self.collectionView.reloadData();
    }
    
    @IBAction func doCLose(_ sender: Any) {
        viewDelegate?.BlurSharePanelViewClose(view: self, doCLose: true);
    }
    
}

extension BlurSharePanelView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //
        collectionView.layoutIfNeeded();
        
        let height = self.collectionView.frame.height;
        let width = self.collectionView.frame.width;
        return CGSize(width: width / 4, height: height);
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a GridViewCell.
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CatLabelCVC", for: indexPath) as? CatLabelCVC
            else { fatalError("unexpected cell in collection view") }
        
        let c = self.collectionArray[indexPath.row];
        
        
        cell.setData(lblString: (c["Name"] as! String), icon: ( c["icon"] as! String ) );
        
        
        return cell;
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return collectionArray.count;
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //
        return UIEdgeInsetsMake(0, 0, 0, 0); // top, left, bottom, right
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        self.viewDelegate?.BlurSharePanelViewSelection(view: self, selection: collectionArray[indexPath.row]);
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //
        
        
    }
}
