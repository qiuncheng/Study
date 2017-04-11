//
//  SearchResultViewController.swift
//  SearchBar
//
//  Created by vsccw on 2017/4/12.
//  Copyright © 2017年 Qiun Cheng. All rights reserved.
//

import UIKit

class SearchResultViewController: SearchBaseViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive == false {
            return
        }
        self.filterString = searchController.searchBar.text
    }
}
