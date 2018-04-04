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
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var imgCateg: UIImageView!
    @IBOutlet weak var imgAa: UIImageView!
    @IBOutlet weak var imgShare: UIImageView!
    @IBOutlet weak var imgLove: UIImageView!
    @IBOutlet weak var imgReport: UIImageView!
    
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
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // runs every time
        self.loadVisuals();
        loadData();
        
    }
    
    @IBAction func gotoSettings(_ sender: Any) {
        PageRedirect.redirectToSettingsPage(self);
    }
    @IBAction func gotoSidemenu(_ sender: Any) {
        PageRedirect.redirectToPreSidemenuPage(self);
    }
    @IBAction func gotoCategoryList(_ sender: Any) {
        PageRedirect.redirectToCatSidemenuPage(self);
    }
    
    
    @IBAction func shareSnapshotImage(_ sender: Any) {
        self.shareImage(image: self.collectionView.snapshot()!);
    }
    @IBAction func doLike(_ sender: UIButton) {
        
        LearnottoApi.addLike(userid: signup.Id!, factid: self.factid) { (success) in
            //
            if(success){
                
                StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite");
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
    
    func loadVisuals(){
        
        //
        
        StyleHelper.setFontImageVisualsMaterial(self.imgMenu, name: "menu");
        StyleHelper.setFontImageVisualsMaterial(self.imgCateg, name: "dashboard");
        StyleHelper.setFontImageVisualsMaterial(self.imgAa, name: "style");
        
        StyleHelper.setFontImageVisualsMaterial(self.imgShare, name: "screen.share");
        StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite.border");
//        StyleHelper.setFontImageVisualsMaterial(self.imgReport, name: "style");
        
        
        if(globalSettings.ttype == "A"){
            self.globalImageView.image = nil;
        }else{
            self.globalImageView.image = nil;
            FileApi.retrieveImageFromDocFolder(name: globalSettings.background!) { (image) in
                self.globalImageView.image = image
            }
        }
        self.view.backgroundColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        
    }
    
    
}
