//
//  TableSearchCVC.swift
//  Learn
//
//  Created by Xtreme Hardware on 04/04/2018.
//  Copyright © 2018 pixel. All rights reserved.
//

import UIKit

class TableSearchCVC: UICollectionViewCell, UISearchBarDelegate {

    let cellIdentifier = "SidemenuParentTVC"
    var collectionArray: [EnDDL] = [EnDDL]();
    
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
        
        // add a search to tableView
        searchBar.barTintColor = StyleHelper.colorWithHexString(globalSettings.bcolor!);
        searchBar.delegate = self;
        
        LearnottoApi.getCategories { (success, data) in
            if(success){
                if let d = data{
                    self.collectionArray = d;
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
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //
        searchBar.resignFirstResponder();
        
    }
    
    

}

extension TableSearchCVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collectionArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SidemenuParentTVC", for: indexPath as IndexPath) as! SidemenuParentTVC;
        cell.setData(lbl: self.collectionArray[indexPath.row]);
        cell.selectionStyle = .none;
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    
    
    
}
