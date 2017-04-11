//
//  SearchBaseViewController.swift
//  SearchBar
//
//  Created by vsccw on 2017/4/11.
//  Copyright © 2017年 Qiun Cheng. All rights reserved.
//

import UIKit

class SearchBaseViewController: UIViewController {
    
    var filterString: String! {
        didSet {
            if filterString == "" || filterString == nil {
                visibleResults = allCountries
            }
            else {
                let predicate = NSPredicate.init(format: "self contains[c] %@", filterString)
                visibleResults = (allCountries as NSArray).filtered(using: predicate) as? [String]
            }
        }
    }
    
    var visibleResults: [String]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var allCountries: [String]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "txt") {
            let url = URL.init(fileURLWithPath: path)
            do {
                let content = try String.init(contentsOf: url, encoding: String.Encoding.utf8)
                 allCountries = content.components(separatedBy: "\n")
                self.visibleResults = allCountries
            }
            catch let error {
                print(error)
            }
        }
    }
}

extension SearchBaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCellIdentifier")
        cell?.textLabel?.text = visibleResults[indexPath.row]
        return cell!
    }
}
