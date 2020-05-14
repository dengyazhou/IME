//
//  ScanMultiCompleteCell.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/4.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class ScanMultiCompleteCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var textField: UITextField!//合格
    @IBOutlet weak var textField1: UITextField!//报废
    @IBOutlet weak var textField2: UITextField!//不良
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField?.layer.borderWidth = 0.5
        textField?.layer.cornerRadius = 2
        textField?.layer.borderColor = colorLine.cgColor
        textField.placeholder = "0"
    
        textField1?.layer.borderWidth = 0.5
        textField1?.layer.cornerRadius = 2
        textField1?.layer.borderColor = colorLine.cgColor
        textField1.placeholder = "0"
        
        textField2?.layer.borderWidth = 0.5
        textField2?.layer.cornerRadius = 2
        textField2?.layer.borderColor = colorLine.cgColor
        textField2.placeholder = "0"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
