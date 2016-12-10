//
//  ViewController.swift
//  MessageToast
//
//  Created by 程庆春 on 2016/12/8.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit
import NoticeBar

class ViewController: UIViewController {

    var clicked: Bool = false

    @IBOutlet weak var tView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.shared.statusBarStyle = .lightContent

        // Do any additional setup after loading the view, typically from a nib.
        tView.layer.shadowOpacity = 0.44
        tView.layer.shadowOffset = CGSize(width: 0, height: -5)
        tView.layer.shadowColor = UIColor.gray.cgColor
        tView.layer.shadowRadius = 10

        let button = UIButton(type: .system)
        button.setTitle("点我点我", for: .normal)
        button.addTarget(self, action: #selector(switchStatusBarStyle), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 100, width: 100, height: 20)
        self.view.addSubview(button)
        button.sizeToFit()

//        view.translatesAutoresizingMaskIntoConstraints = false
//        button.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addConstraint(NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 100))
//        view.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 100))
    }

    @objc func switchStatusBarStyle() {
//        let toast = MessageToast(title: "网络连接错误。", type: .attention)
//
//        toast.show(duration: 5) { (finished) in
//            if (finished) {
//
//            }
//        }

//        let notice = NoticeBar(title: "haha", type: .error)
        UIApplication.shared.statusBarStyle = .lightContent
        let config = NoticeBarConfig(title: "网络无加载", image: nil, textColor: UIColor.white, backgroundColor: UIColor.red, style: .onStatusBar, animationType: .top)
        let notice = NoticeBar(config: config)
        notice.show(duration: 2.0) {
            (finished) in
            print(finished)
            UIApplication.shared.statusBarStyle = .default
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

