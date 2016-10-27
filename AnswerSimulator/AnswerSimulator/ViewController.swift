//
//  ViewController.swift
//  AnswerSimulator
//
//  Created by 程庆春 on 2016/10/26.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit
import YLServerSimulator

struct ViewControllerCommon {
    static let cellID = "cellID"
}

class ViewController: UITableViewController, YLServerClientDelegate {

    var client:YLServerClient!
    typealias ReceiveMessages = (([[String: String]]) -> Void)?
    var results = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client = YLServerClient.sharedClient
        client.delegate = self
        let messages: ReceiveMessages = { (msg: [[String: String]]) -> Void in
            DispatchQueue.global().async(execute: {
                for m in msg {
                    self.results.append(m)
                }
            })
            /*
            (self.results as NSArray).sortedArray(comparator: { (value1, value2) -> ComparisonResult in
                let t1 = (value1 as! NSDictionary)["timestamp"]
                let t2 = (value2 as! NSDictionary)["timestamp"]

                if String(describing: t1) > String(describing: t2) {
                    return ComparisonResult.orderedAscending
                } else {
                    return ComparisonResult.orderedDescending
                }
            })
            */

            self.tableView.reloadData()
        }

        client.receiveMessages = messages
        /*
         print("++++++++++")
         var count: UInt32 = 0
         let methods = class_copyMethodList(YLServerClient.self, &count)
         for i in 0 ..< numericCast(count) {
         let method = methods?[i]
         let methodType = method_getTypeEncoding(method)
         let methodReturnType = method_copyReturnType(method)
         let methodName = method_getName(method)
         print("method type : " + String(utf8String: methodType!)!)
         print("SEL : " + NSStringFromSelector(methodName!))
         print("return type :" + String(utf8String: methodReturnType!)!)
         print("--")
         }
         */
//        tableView.register(MsgCell.self, forCellReuseIdentifier: ViewControllerCommon.cellID)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "YLServerClient"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: ViewControllerCommon.cellID, for: indexPath) as! MsgCell
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let result = results[indexPath.row]
        if let type = result["type"] {
            (cell as! MsgCell).typeMsgLabel.text = type
        }
        if let timestamp = result["timestamp"] {
            (cell as! MsgCell).timeMsgLabel.text = timestamp
        }
        if let content = result["content"] {
            (cell as! MsgCell).contentMsgLabel.text = content
        }
        if let url = result["url"] {
            (cell as! MsgCell).contentMsgLabel.text = url
        }
    }

    func serverSleepForever() {

//        for item in results {
//            if let url = item["url"] {
//                print("url : " + url)
//            }
//            if let content = item["content"] {
//                print("content : " + content)
//            }
//        }

        print("~The end~")
        let alertVC = UIAlertController(title: "数据完成加载", message: "", preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in

        }
        alertVC.addAction(sureAction)

        self.present(alertVC, animated: true, completion: nil)

        (self.results as NSArray).sortedArray(comparator: { (value1, value2) -> ComparisonResult in
            let t1 = (value1 as! NSDictionary)["timestamp"]
            let t2 = (value2 as! NSDictionary)["timestamp"]

            if String(describing: t1) > String(describing: t2) {
                return ComparisonResult.orderedAscending
            } else {
                return ComparisonResult.orderedDescending
            }


        })

        self.tableView.reloadData()
    }
}

