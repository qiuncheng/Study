//
//  SearchBaseViewController.swift
//  SearchBar
//
//  Created by vsccw on 2017/4/11.
//  Copyright © 2017年 Qiun Cheng. All rights reserved.
//

import UIKit

class SearchBaseViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    var countries: [String]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "txt") {
            let url = URL.init(fileURLWithPath: path)
            do {
                let content = try String.init(contentsOf: url, encoding: String.Encoding.utf8)
                 let contents = content.components(separatedBy: "\n")
                self.countries = contents
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
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCellIdentifier")
        cell?.textLabel?.text = countries[indexPath.row]
        return cell!
    }
}
