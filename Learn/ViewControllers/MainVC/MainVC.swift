//
//  MainVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 15/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import Photos
import PhotosUI
import FontAwesome_swift

class MainVC: BaseVC{
    
    var facts: [Facts] = [Facts]();
    var refresher:UIRefreshControl!;
    var globalImage: UIImage!;
    var localFontName: String = "";
    
    @IBOutlet weak var collectionView: UICollectionView!;
    @IBOutlet weak var globalImageView: UIImageView!;
    @IBOutlet weak var btnTopHome: UIButton!
    @IBOutlet weak var btnLeftBar: UIBarButtonItem!
    @IBOutlet weak var btnRightBar: UIBarButtonItem!
    
    override func viewDidLoad() {
        //
        super.viewDidLoad();
        
        // CSS
        btnTopHome.titleLabel?.font = UIFont.fontAwesome(ofSize: 30)
        btnTopHome.setTitle(String.fontAwesomeIcon(name: .home), for: .normal)
        btnTopHome.setTitleColor(UIColor.white, for: .normal);
        
        let attributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): UIFont.fontAwesome(ofSize: 20)] as [NSAttributedStringKey : Any];
        btnLeftBar.setTitleTextAttributes(attributes, for: .normal)
        btnLeftBar.title = String.fontAwesomeIcon(name: .bars)
        
        btnRightBar.setTitleTextAttributes(attributes, for: .normal)
        btnRightBar.title = String.fontAwesomeIcon(name: .font)
        
        
        
        
        collectionView.register(UINib(nibName: "GalleryImageCVC", bundle: nil), forCellWithReuseIdentifier: "GalleryImageCVC");
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.allowsMultipleSelection = false;
        
        self.refresher = UIRefreshControl();
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
        loadData();
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
        
    }
    @IBAction func gotoSettings(_ sender: Any) {
        PageRedirect.redirectToSettingsPage(self);
    }
    @IBAction func gotoSidemenu(_ sender: Any) {
        PageRedirect.redirectToSidemenuPage(self);
    }
    @IBAction func shareSnapshotImage(_ sender: Any) {
        self.shareImage(image: self.collectionView.snapshot()!);
    }
    
    func shareImage(image: UIImage){
        
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
