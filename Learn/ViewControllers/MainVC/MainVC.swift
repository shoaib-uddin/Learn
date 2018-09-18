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
// import FontAwesome_swift
import IBAnimatable


class MainVC: BaseVC{
    
    var facts: [EnFact] = [EnFact]();
    var signup: User!;
    var refresher:UIRefreshControl!;
    var globalImage: UIImage!;
    var localFontName: String = "";
    var isLikeByMe: Bool = false;
    
    var viewFromNotif: Bool = false;
    var factFromNotif: EnFact!;
    
    var factid: String = "";
    var likes: Int = 0;
    var currentIndex: IndexPath!;
    var PhotoAlbum: CustomPhotoAlbum = CustomPhotoAlbum();
    
    
    @IBOutlet weak var imgMenu: UIImageView!
    @IBOutlet weak var imgCateg: UIImageView!
    @IBOutlet weak var imgAa: UIImageView!
    @IBOutlet weak var imgShare: UIImageView!
    @IBOutlet weak var imgLove: UIImageView!
    @IBOutlet weak var imgReport: UIImageView!
    
    @IBOutlet weak var topBtnView: UIView!
    @IBOutlet weak var bottomBtnView: UIView!
    
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
        self.collectionView!.addSubview(refresher);
        self.signup = CoreDataHelper.returnUser();
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture));
        swipeUp.direction = .up;
        self.view.addGestureRecognizer(swipeUp);
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture));
        swipeDown.direction = .down;
        self.view.addGestureRecognizer(swipeDown);
        
        loadData();
        
    }
    
    @objc fileprivate func respondToSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("Swiped right");
        case UISwipeGestureRecognizerDirection.down:
            print("Swiped down");
            
            self.topBtnView.isHidden = true;
            self.bottomBtnView.isHidden = true;
            
            let image = self.view.snapshot();
            let imageView = UIImageView(image: image!);
            
            let swipeView = AnimatableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            imageView.frame = CGRect(x: 0, y: 0, width: swipeView.frame.width, height: swipeView.frame.height);
            swipeView.addSubview(imageView);
            swipeView.tag = 9807;
            self.view.addSubview(swipeView);
            swipeView.animate(.slideFade(way: .out, direction: .down), duration: 1, damping: 1, velocity: 2, force: 1);
            
            doLike(UIButton());
            self.topBtnView.isHidden = false;
            self.bottomBtnView.isHidden = false;
            
        case UISwipeGestureRecognizerDirection.left:
            print("Swiped left")
        case UISwipeGestureRecognizerDirection.up:
            print("Swiped up");
            
            
            self.topBtnView.isHidden = true;
            self.bottomBtnView.isHidden = true;
            
            let image = self.view.snapshot();
            let imageView = UIImageView(image: image!);
            
            let swipeView = AnimatableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            imageView.frame = CGRect(x: 0, y: 0, width: swipeView.frame.width, height: swipeView.frame.height);
            swipeView.addSubview(imageView);
            swipeView.tag = 9807;
            self.view.addSubview(swipeView);
            swipeView.animate(.slideFade(way: .out, direction: .up), duration: 1, damping: 1, velocity: 2, force: 1);
            doLike(UIButton());
            self.topBtnView.isHidden = false;
            self.bottomBtnView.isHidden = false;
            
            
            
            
            
            
            //self.view.animate(.pop(repeatCount: 1));
        default:
            break
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // runs every time
        
        
        
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
    @IBAction func openShareView(_ sender: Any) {
        self.addBlurSharePanelView();
    }
    @IBAction func doLike(_ sender: UIButton) {
        
        var visibleRect: CGRect = CGRect()
        visibleRect.origin = (collectionView?.contentOffset)!
        visibleRect.size = (collectionView?.bounds.size)!
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath? = collectionView?.indexPathForItem(at: visiblePoint)
        
        let idd = facts[(visibleIndexPath?.row)!].ID;
        
        // UtilityHelper.AlertMessage("\(idd!)");
        
        self.facts[self.currentIndex.row].likebyme = !self.facts[self.currentIndex.row].likebyme;
        
        if(self.facts[self.currentIndex.row].likebyme){
            StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite");
        }else{
            StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite.border");
        }
        
        LearnottoApi.addLike(userid: signup.id!, factid: idd!) { (success) in
            //
            if(success){

                
                
                // self.collectionView.reloadData();


            }
        }
        
        
    }
    
    
    func loadVisuals(){
        //
        StyleHelper.setFontImageVisualsMaterial(self.imgMenu, name: "home");
        StyleHelper.setFontImageVisualsMaterial(self.imgCateg, name: "dashboard");
        StyleHelper.setFontImageVisualsMaterial(self.imgAa, name: "style");
        StyleHelper.setFontImageVisualsMaterial(self.imgShare, name: "screen.share");
        StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite.border");
        let clr = StyleHelper.colorWithHexString(globalSettings.fcolor!);
        UITextView.appearance().linkTextAttributes = [ NSAttributedStringKey.foregroundColor.rawValue: clr ];
        
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
