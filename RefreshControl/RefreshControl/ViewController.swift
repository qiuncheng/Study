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
    var offsetY: CGFloat = 0.0 {
        didSet {
            if offsetY < -60 {
                label.text = "不好"
            } else {
                label.text = "你好"
            }
        }
    }

    var label: UILabel! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.addObserver(self, forKeyPath: "tableView.contentOffset", options: .new, context: nil)
        label = UILabel()
        label.text = "你好"
        label.sizeToFit()
        view.addSubview(label)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "tableView.contentOffset" {
            offsetY = tableView.contentInset.top + tableView.contentOffset.y
        }
    }
    deinit {
        self.removeObserver(self, forKeyPath: "tableView.contentOffset")
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

