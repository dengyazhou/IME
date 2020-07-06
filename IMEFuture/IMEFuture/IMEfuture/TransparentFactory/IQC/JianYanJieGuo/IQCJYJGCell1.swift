//
//  IQCJYJGCell1.swift
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/19.
//  Copyright © 2018年 Netease. All rights reserved.
//

import UIKit

class IQCJYJGCell1: UITableViewCell {
    
    
    
    @IBOutlet weak var viewDaoHuoShu: UIView!//到货数
    @IBOutlet weak var viewZhiJianShu: UIView!//质检数
    @IBOutlet weak var viewRuKuShu: UIView!//入库数
    @IBOutlet weak var viewHeGeShu: UIView!//合格数
    @IBOutlet weak var viewBuHeGeShu: UIView!//不合格数
    @IBOutlet weak var viewQueXianReson: UIView!//缺陷原因
    @IBOutlet weak var viewRangBuJieShou: UIView!//让步接收
    @IBOutlet weak var viewRangBuReson: UIView!//让步原因
    @IBOutlet weak var viewBaoFeiShu: UIView!//报废数量
    @IBOutlet weak var viewBaoFeiReson: UIView!//报废原因
    @IBOutlet weak var viewXuLieZhuiZong: UIView!//序列追踪
    @IBOutlet weak var viewGengGaiXuLieHao: UIView!//更改序列号
    
    

    @IBOutlet weak var textFieldDaoHuoShu: UITextField!//到货数
    @IBOutlet weak var labelZhiJianShu: UILabel!//质检数
    @IBOutlet weak var textFieldRuKuShu: UITextField!//入库数
    @IBOutlet weak var labelHeGeShu: UILabel!//合格数
    @IBOutlet weak var textFieldBuHeGeShu: UITextField!//不合格数

    @IBOutlet weak var buttonQueXianYuanYing: UIButton!//缺陷原因
    @IBOutlet weak var buttonQueXianYuanYingXuanZe: UIButton!
    
    @IBOutlet weak var textFieldRangBuJieShou: UITextField!//让步接收
    @IBOutlet weak var textFieldRangBuReson: UITextField!//让步原因
    @IBOutlet weak var textFieldBaoFeiShu: UITextField!//报废数量
    @IBOutlet weak var textFieldBaoFeiReson: UITextField!//报废原因
    
    @IBOutlet weak var buttonCheck: UIButton!//序列追踪勾选
    
    @IBOutlet weak var buttonGengGaiXuLieHao: UIButton!//更改序列号
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
