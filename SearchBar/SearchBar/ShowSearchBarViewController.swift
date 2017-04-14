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
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
//        searchController.definesPresentationContext = true
        searchController.searchBar.searchBarStyle = .minimal
        
        searchController.searchBar.tintColor = UIColor.red
        UITextField.vs_appearanceWhenContained(in: UISearchBar.self).tintColor = UIColor.black
        
        self.definesPresentationContext = true
        
        self.tableView.tableHeaderView = searchController.searchBar
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.searchBar.resignFirstResponder()
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
