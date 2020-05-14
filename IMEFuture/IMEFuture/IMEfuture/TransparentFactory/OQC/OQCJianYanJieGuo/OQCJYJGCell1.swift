//
//  OQCJYJGCell1.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class OQCJYJGCell1: UITableViewCell {
    
    @IBOutlet weak var textField00: UITextField!
    
    @IBOutlet weak var label01: UILabel!
    
    @IBOutlet weak var textField02: UITextField!
    
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var buttonQueXianYuanYing: UIButton!//缺陷原因
    @IBOutlet weak var buttonQueXianYuanYingXuanZe: UIButton!
    
    @IBOutlet weak var textField04: UITextField!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
