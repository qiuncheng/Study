//
//  ViewController.swift
//  SwifterSwiftDemo
//
//  Created by 程庆春 on 2016/12/13.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit
import SwifterSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let str = "hello world"
        print(str.camelCased)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
