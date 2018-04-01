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
    
    var facts: [EnFact] = [EnFact]();
    var signup: EnSignUp!;
    var refresher:UIRefreshControl!;
    var globalImage: UIImage!;
    var localFontName: String = "";
    var isLikeByMe: Bool = false;
    var factid: String = "";
    var likes: Int = 0;
    var currentIndex: IndexPath!;
    
    @IBOutlet weak var collectionView: UICollectionView!;
    @IBOutlet weak var globalImageView: UIImageView!;
    @IBOutlet weak var btnTopHome: UIButton!
    @IBOutlet weak var btnLeftBar: UIBarButtonItem!
    @IBOutlet weak var btnRightBar: UIBarButtonItem!
    @IBOutlet var btnHeart: UIButton!
    @IBOutlet var lblLike: UILabel!
    
    override func viewDidLoad() {
        //
        super.viewDidLoad();
        
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
    
    @IBAction func gotoSettings(_ sender: Any) {
        PageRedirect.redirectToSettingsPage(self);
    }
    @IBAction func gotoSidemenu(_ sender: Any) {
        PageRedirect.redirectToSidemenuPage(self);
    }
    @IBAction func shareSnapshotImage(_ sender: Any) {
        self.shareImage(image: self.collectionView.snapshot()!);
    }
    @IBAction func doLike(_ sender: UIButton) {
        
        LearnottoApi.addLike(userid: signup.Id!, factid: self.factid) { (success) in
            //
            if(success){
                self.btnHeart.titleLabel?.font = UIFont.fontAwesome(ofSize: 30);
                self.btnHeart.setTitle(String.fontAwesomeIcon(name: .heart), for: .normal);
                
                var li: Int = Int(self.likes) + 1;
                self.lblLike.text = "\(li)";
                
                self.facts[self.currentIndex.row].likes = NSNumber(value: li);
                self.facts[self.currentIndex.row].likebyme = true;
                self.collectionView.reloadData();
                
                
            }
        }
        
        
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
