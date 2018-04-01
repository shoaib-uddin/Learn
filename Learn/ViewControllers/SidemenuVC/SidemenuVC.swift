//
//  SidemenuVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 15/02/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit

protocol SidemenuVCDelegate: class {
    func receiveCategoryOfSidemenu(parent: EnDDL , cat: EnDDL);
}

class SidemenuVC: UIViewController /* UISearchResultsUpdating */, SidemenuVCDelegate {
    
    
    
    func receiveCategoryOfSidemenu(parent: EnDDL , cat: EnDDL) {
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                self.vcDelegate?.receiveCategoryOfSidemenu(parent: parent, cat: cat);
            })
        }
        
    }
    
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    
    
    @IBOutlet weak var dotImage: UIImageView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var isSubCategory: Bool = false;
    var parentCat: EnDDL!;
    var categoryArray: [EnDDL] = [EnDDL]();
    var filteredCategoryArray: [EnDDL] = [EnDDL]();
    let cellIdentifier = "SidemenuParentTVC";
    let searchController = UISearchController(searchResultsController: nil)
    var refreshControl: UIRefreshControl!;
    var saveCatId: String!;
    var saveSubCatId: String!;
    weak var vcDelegate: SidemenuVCDelegate?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init header
        
        dotImage.image = UIImage.fontAwesomeIcon(name: .circle, textColor: UIColor.white, size: CGSize(width: 10, height: 10))
        
        if(isSubCategory){
            leftImage.image = UIImage.fontAwesomeIcon(name: .angleLeft, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        }else{
            leftImage.image = UIImage.fontAwesomeIcon(name: .times, textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        }
        
        saveCatId = UtilityHelper.getKey(api.savedCatId);
        saveSubCatId = UtilityHelper.getKey(api.savedSubCatId);
        
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 85.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero);
        
        // refresh table view via pull
//        refreshControl = UIRefreshControl()
//        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged);
//        refreshControl.tag = 102;
//        tableView.addSubview(refreshControl) // not required when using UITableViewController
//
        // add a search to tableView
//        searchController.searchResultsUpdater = self
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.dimsBackgroundDuringPresentation = false;
//        searchController.searchBar.barTintColor = UIColor.init(red: 207/255, green: 111/255, blue: 255/255, alpha: 0.0);
//
//        tableView.tableHeaderView = searchController.searchBar
        
        initCollectionItems();
        
        
        
    }
    
    func initCollectionItems(){
        
        self.categoryArray.removeAll();
        self.tableView.reloadData();
        
//        self.refreshControl.beginRefreshing();
        
        if(isSubCategory){
            
            LearnottoApi.getSubCategories(item: parentCat, completion: { (success, data) in
                //
                if(success){
                    
                    self.lblHeading.text = self.parentCat.Name;
                    
                    if let d = data {
                        self.categoryArray = d;
                        self.filteredCategoryArray = self.categoryArray;
                        self.tableView.reloadData();
                    }
                    
                }
            })
            
        }else{
            
            LearnottoApi.getCategories { (success, data) in
                //
                if(success){
                    if let d = data {
                        self.categoryArray = d;
                        self.filteredCategoryArray = self.categoryArray;
                        self.tableView.reloadData();
                    }
                    
                    
                }
            }
            
        }
        
        
        
        
//        self.categoryArray = CoreDataHelper.returnCategories();
        
        
        
//        if(self.refreshControl != nil){
//            self.refreshControl.endRefreshing();
//        }
        
        
//        self.tableView.reloadData();
        
    }
    
    @IBAction func closeMenu(_ sender: UIBarButtonItem) {
        
        
            self.dismiss(animated: true) {
                // send any selection to back OR leave it
            }
        
        
        
        
        
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//
//        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
//
//            filteredCategoryArray = categoryArray.filter({ (list) -> Bool in
//
//                // filter by actual location || model || stock No
//                let flag = list.lowercased().contains(searchText.lowercased());
//                return flag
//            })
//
//        } else {
//            filteredCategoryArray = categoryArray;
//        }
//        tableView.reloadData()
//    }
    
//    @objc func refresh() {
//        // Code to refresh table view
//        initCollectionItems();
//    }
    
    
    
    
}

extension SidemenuVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredCategoryArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let stub = self.filteredCategoryArray[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidemenuParentTVC", for: indexPath as IndexPath) as! SidemenuParentTVC;
        cell.setData(lbl: stub);
        cell.selectionStyle = .none;
        
        
        if(isSubCategory){
            
            if(saveSubCatId == stub.ID){
                cell.tickImage.image = UIImage.fontAwesomeIcon(name: .check, textColor: UIColor.white, size: CGSize(width: 20, height: 20))
            }
            
            
        }else{
            
            if(saveCatId == stub.ID){
                cell.tickImage.image = UIImage.fontAwesomeIcon(name: .check, textColor: UIColor.white, size: CGSize(width: 20, height: 20))
            }
            
        }
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(isSubCategory){
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: {
                    self.vcDelegate?.receiveCategoryOfSidemenu(parent: self.parentCat , cat: self.filteredCategoryArray[indexPath.row]);
                })
            }
            
        }else{
            PageRedirect.navToChildSubmenu(item: self.filteredCategoryArray[indexPath.row], viewController: self);
        }
        
        
        
    }
    
    
    
    
}


