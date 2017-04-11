//
//  ShowSearchBarViewController.swift
//  SearchBar
//
//  Created by vsccw on 2017/4/12.
//  Copyright © 2017年 Qiun Cheng. All rights reserved.
//

import UIKit

class ShowSearchBarViewController: SearchResultViewController {
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = UIColor.init(white: 0.95, alpha: 1.0)
        searchController.searchBar.tintColor = UIColor.green
        searchController.definesPresentationContext = true
        
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    
}
