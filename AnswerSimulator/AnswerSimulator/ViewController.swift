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
    fileprivate static let cellID = "msgCellID"
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

            self.tableView.reloadData()
        }

        client.receiveMessages = messages
        /**
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
         }
         */
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
        let msgCell = cell as! MsgCell
        if let type = result["type"] {
            msgCell.typeMsgLabel.text = type
        }
        if let timestamp = result["timestamp"] {
            msgCell.timeMsgLabel.text = timestamp
        }
        if let content = result["content"] {
            msgCell.contentMsgLabel.text = content
        }
        if let url = result["url"] {
            msgCell.contentMsgLabel.text = url
        }
    }

    func serverSleepForever() {


        print("~The end~")
        let alertVC = UIAlertController(title: "数据接受完成", message: "", preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "确定", style: .default) { (action) in

        }
        alertVC.addAction(sureAction)

        self.present(alertVC, animated: true, completion: nil)

        (self.results as NSArray).sortedArray(comparator: { (value1, value2) -> ComparisonResult in
            let time1 = (value1 as! NSDictionary)["timestamp"]
            let time2 = (value2 as! NSDictionary)["timestamp"]

            if String(describing: time1) > String(describing: time2) {
                return ComparisonResult.orderedAscending
            } else {
                return ComparisonResult.orderedDescending
            }
        })

        self.tableView.reloadData()
    }
}

