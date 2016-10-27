//
//  MsgCell.swift
//  AnswerSimulator
//
//  Created by 程庆春 on 2016/10/27.
//  Copyright © 2016年 qiuncheng.com. All rights reserved.
//

import UIKit

class MsgCell: UITableViewCell {
    @IBOutlet weak var typeMsgLabel: UILabel!

    @IBOutlet weak var contentMsgLabel: UILabel!
    @IBOutlet weak var timeMsgLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
