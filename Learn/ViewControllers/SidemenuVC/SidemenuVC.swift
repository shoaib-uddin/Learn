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
    func receiveCategoryOfSidemenu(cat: String);
}

class SidemenuVC: UIViewController, UISearchResultsUpdating{
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryArray: [String] = [String]();
    var filteredCategoryArray: [String] = [String]();
    let cellIdentifier = "SidemenuParentTVC";
    let searchController = UISearchController(searchResultsController: nil)
    var refreshControl: UIRefreshControl!
    weak var vcDelegate: SidemenuVCDelegate?;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // init header
        
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 85.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero);
        
        // refresh table view via pull
        refreshControl = UIRefreshControl()
        //refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged);
        refreshControl.tag = 102;
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
        // add a search to tableView
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false;
        searchController.searchBar.barTintColor = UIColor.init(red: 207/255, green: 111/255, blue: 255/255, alpha: 0.0);
        
        tableView.tableHeaderView = searchController.searchBar
        
        initCollectionItems();
        
        
        
    }
    
    func initCollectionItems(){
        
        self.categoryArray.removeAll();
        self.tableView.reloadData();
        
        self.refreshControl.beginRefreshing();
        self.categoryArray = CoreDataHelper.returnCategories();
        
        self.filteredCategoryArray = self.categoryArray;
        self.tableView.reloadData();
        
        if(self.refreshControl != nil){
            self.refreshControl.endRefreshing();
        }
        
        
        self.tableView.reloadData();
        
    }
    
    @IBAction func closeMenu(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
            // send any selection to back OR leave it 
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            
            filteredCategoryArray = categoryArray.filter({ (list) -> Bool in
                
                // filter by actual location || model || stock No
                let flag = list.lowercased().contains(searchText.lowercased());
                return flag
            })
            
        } else {
            filteredCategoryArray = categoryArray;
        }
        tableView.reloadData()
    }
    
    @objc func refresh() {
        // Code to refresh table view
        initCollectionItems();
    }
    
    
    
    
}

extension SidemenuVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredCategoryArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidemenuParentTVC", for: indexPath as IndexPath) as! SidemenuParentTVC;
        cell.setData(lbl: self.filteredCategoryArray[indexPath.row]);
        cell.selectionStyle = .none;
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //PageRedirect.navToChildSubmenu(item: self.collectionArray[indexPath.row], viewController: self);
        self.dismiss(animated: true, completion: {
            self.vcDelegate?.receiveCategoryOfSidemenu(cat: self.filteredCategoryArray[indexPath.row]);
        })
    }
    
    
    
    
}


