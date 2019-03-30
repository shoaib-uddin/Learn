//
//  SlideVCfunc.swift
//  Learn
//
//  Created by Xtreme Hardware on 17/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit
import Photos
import MessageUI
import PhotosUI

extension MainVC: SettingsVCDelegate, BlurSharePanelViewDelegate, CatSidemenuVCDelegate, PreSidemenuVCDelegate, MFMessageComposeViewControllerDelegate{
    
    func selectedMenuItem(vc: PreSidemenuVC, menu: String) {
        //
        print(menu);
        switch menu as! String {
        case "REM":
            
            break;
        case "CAT":
            loadData();
            break;
        case "STY":
            loadVisuals();
            self.collectionView.reloadData();
            break;
        case "SRC":
            
            break;
        case "FAV":
            
            break;
            
        default:
            break;
        }
    }
    
    func changeCategoryCollection(vc: CatSidemenuVC, catId: String) {
        //
        print(catId);
        loadData();
    }
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    func addBlurSharePanelView(){
        
        var blurSharePanelView: BlurSharePanelView!;
        let screenSize : CGRect = UIScreen.main.bounds;
        let window: UIWindow! = UIApplication.shared.delegate!.window!
        if(blurSharePanelView == nil){
            blurSharePanelView =  Bundle.main.loadNibNamed("BlurSharePanelView", owner: self, options: nil)?[0] as! BlurSharePanelView;
            let h = screenSize.size.height;
            let w = screenSize.size.width;
            blurSharePanelView.frame = CGRect(x: 0, y: 0, width: w, height: h);
            blurSharePanelView.tag = 90;
            blurSharePanelView.viewDelegate = self;
            window.addSubview(blurSharePanelView);
            
        }else{
            //unloadMultiPrintView();
        }
        
        
    }
    func BlurSharePanelViewClose(view: BlurSharePanelView, doCLose: Bool) {
        //
        view.removeFromSuperview();
    }
    
    func BlurSharePanelViewSelection(view: BlurSharePanelView, selection: [String : Any]) {
        //
        print(selection);
        view.removeFromSuperview();
        
        var visibleRect: CGRect = CGRect()
        visibleRect.origin = (collectionView?.contentOffset)!
        visibleRect.size = (collectionView?.bounds.size)!
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath? = collectionView?.indexPathForItem(at: visiblePoint)
        
        let cell = self.collectionView.cellForItem(at: visibleIndexPath!) as! GalleryImageCVC;
        
        
        
        
        switch selection["key"] as! String {
        case "MSG":
            let fact = facts[(visibleIndexPath?.row)!];
            let copiedText = "\(fact.Content!)";
            
            
            
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                controller.body = copiedText
                controller.recipients = nil
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
            }
            
            
            view.removeFromSuperview();
            

            break;
        case "CPY":
            
            let fact = facts[(visibleIndexPath?.row)!];
            let copiedText = "\(fact.Content!)";
            // copy fact content
            UIPasteboard.general.string = copiedText
            view.removeFromSuperview();
            
            break;
        case "SAV":
            
            view.removeFromSuperview();
            DispatchQueue.main.async {
                //
                
                self.topBtnView.isHidden = true;
                self.bottomBtnView.isHidden = true;
                
//                let image = UIImage(named: "\(globalSettings.fcolor!).png");
//                let imageView = UIImageView(image: image!);
//
//                imageView.frame = CGRect(x: self.view.frame.maxX - 90, y: self.view.frame.maxY - 90, width: 80, height: 80);
//                imageView.tag = 9887;
//                self.view.addSubview(imageView);
//
                let snapshot = self.view.snapshot();
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // save snapshot to PhAssets
                    self.PhotoAlbum.save(image: snapshot!, completion: { (asset) in
                        print("saved");
                        
                        
                    });
                    
//                    imageView.removeFromSuperview();
                    self.topBtnView.isHidden = false;
                    self.bottomBtnView.isHidden = false;
                }
                
            }
            
            
            
            break;
        case "SHR":
            
            view.removeFromSuperview();
            DispatchQueue.main.async {
                //
                self.topBtnView.isHidden = true;
                self.bottomBtnView.isHidden = true;
                
//                let image = UIImage(named: "\(globalSettings.fcolor!).png");
//                let imageView = UIImageView(image: image!);
//
//                imageView.frame = CGRect(x: self.view.frame.maxX - 90, y: self.view.frame.maxY - 90, width: 80, height: 80);
//                imageView.tag = 9887;
//                self.view.addSubview(imageView);
//
                let snapshot = self.view.snapshot();
                // save snapshot to PhAssets
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
//                    imageView.removeFromSuperview();
                    self.topBtnView.isHidden = false;
                    self.bottomBtnView.isHidden = false;
                    self.shareImage(image: snapshot!);
                }
                
                
            }
            
            break;
            
        default:
            break
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
    
    // don't delete, its a delegate function
    func updateViewBySettings() {
        loadVisuals();
        self.collectionView.reloadData();
    }
    
    @objc func loadData() {
        //code to execute during refresher
        getFacts(page: 0, subCat: globalCatId);
        stopRefresher()         //Call this to stop refresher
    }
    
    
    
    func getFacts(page: Int, subCat: String!){
        
        facts.removeAll();
        guard let _id = signup.id else{ return }
        LearnottoApi.getFacts(_id, page, subCat: subCat) { (success, facts) in
            //
            if(success){
                
                
                self.facts = facts!;
                if(self.viewFromNotif){
                    self.viewFromNotif = false;
                    self.facts.insert(self.factFromNotif!, at: 0);
                }
                self.loadVisuals();
                self.collectionView.reloadData();
                DispatchQueue.main.async {
                    let g: Bool = Bool(self.facts[0].likebyme);
                    if(!g){
                        StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite.border");
                    }else{
                        StyleHelper.setFontImageVisualsMaterial(self.imgLove, name: "favorite");
                    }
                }
                
            }
            
        }
        
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    
}
