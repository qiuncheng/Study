//
//  ViewController.swift
//  AwesomeToolBar
//
//  Created by 程庆春 on 2016/12/12.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    weak var selectedCell: UICollectionViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
        self.collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
    }
}

extension ViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        cell.transform = CGAffineTransform(translationX: 0, y: 40)
        cell.contentView.backgroundColor = UIColor.randomColor()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select item with row: \(indexPath.item)")
        if selectedCell != nil {
            selectedCell.transform = CGAffineTransform(translationX: 0, y: 40)
        }
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            let cell = collectionView.cellForItem(at: selectedIndexPath)
            cell?.transform = CGAffineTransform(translationX: 0, y: -10)
            selectedCell = cell
        }

    }
}

extension UIColor {
    static func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor(red: r / 256.00, green: g / 256.00, blue: b / 256.00, alpha: 1.0)
    }
}
