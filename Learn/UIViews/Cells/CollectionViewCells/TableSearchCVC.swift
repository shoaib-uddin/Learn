//
//  TableSearchCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 04/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import Foundation
import UIKit


protocol TableSearchCVCDelegate: class {
    func setAndCloseSearch(cell: TableSearchCVC, doCLose: Bool);
}


class TableSearchCVC: UICollectionViewCell, UISearchBarDelegate {

    let cellIdentifier = "SidemenuParentTVC"
    var collectionArray: [EnDDL] = [EnDDL]();
    var filteredcollectionArray: [EnDDL] = [EnDDL]();
    weak var cellDelegate: TableSearchCVCDelegate?;
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier);
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 85.0;
        tableView.tableFooterView = UIView(frame: CGRect.zero);
//        
        // add a search to tableView
        searchBar.barTintColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        searchBar.delegate = self;
        
        LearnottoApi.getCategories(page: 0, size: 10000) { (success, data) in
            if(success){
                if let d = data{
                    self.collectionArray = d;
                    self.filteredcollectionArray = self.collectionArray;
                    self.tableView.reloadData();
                }
            }
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //
        searchBar.showsCancelButton = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //
        searchBar.resignFirstResponder();
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //
        searchBar.showsCancelButton = false;
        searchBar.resignFirstResponder();
        self.filteredcollectionArray = self.collectionArray
        self.tableView.reloadData();
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //
        searchBar.resignFirstResponder();
        if let searchText = searchBar.text, !(searchBar.text?.isEmpty)! {
            
            filteredcollectionArray = collectionArray.filter({ (list) -> Bool in
                
                // filter by actual location || model || stock No
                let flag = ( (list.Name?.lowercased().contains(searchText.lowercased()))!
                )
                
                return flag
            })
            
            if filteredcollectionArray.count == 0{
                UtilityHelper.AlertMessagewithCallBack("No Results ...", success: {
                    self.filteredcollectionArray = self.collectionArray
                    self.tableView.reloadData();
                })
            }
            
            
        } else {
            filteredcollectionArray = collectionArray
        }
        tableView.reloadData()
        
    }
    
    

}

extension TableSearchCVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredcollectionArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidemenuParentTVC", for: indexPath as IndexPath) as! SidemenuParentTVC;
        cell.setData(lbl: self.filteredcollectionArray[indexPath.row]);
        cell.selectionStyle = .none;
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = self.filteredcollectionArray[indexPath.row];
        globalCatId = data.ID;
        cellDelegate?.setAndCloseSearch(cell: self, doCLose: true);
        
    }
    
    
    
    
}
