//
//  ViewController.swift
//  RefreshControl
//
//  Created by 程庆春 on 2016/10/24.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let colors = [UIColor.red, UIColor.blue, UIColor.orange, UIColor.cyan, UIColor.magenta,UIColor.brown]
    weak var refresh: JKRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let refresh = JKRefreshControl()
        tableView.addSubview(refresh)
        self.refresh = refresh

        refresh.addTarget(self, action: #selector(endRefresh), for: .valueChanged)
    }
    func endRefresh() {
        DispatchQueue.global().async { 
            Thread.sleep(forTimeInterval: 0.8)
            DispatchQueue.main.async(execute: { 
                self.refresh.endRefreshing()
            })
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {

    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return colors.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.backgroundColor = colors[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row)"
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.layer.add(shakeAnimation(), forKey: "shake")
    }

    /// achive shaking cell
    ///
    /// - returns: The shaking cell animation
    func shakeAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -5.0
        animation.toValue = 5.0
        animation.duration = 0.05
//        animation.autoreverses = true
        animation.repeatCount = 2
        return animation
    }

}

