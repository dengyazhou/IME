//
//  CiPingChuLiFangShiCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/26.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CiPingChuLiFangShiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UIButton *buttonShanChu;//删除
@property (weak, nonatomic) IBOutlet UIButton *buttonChuLiFangShi;//处理方式
@property (weak, nonatomic) IBOutlet UIButton *buttonChuLiFangShiQingXuanZe;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UIButton *buttonTpye;//请选择次品类型

@property (weak, nonatomic) IBOutlet UIButton *buttonGongYingShangShiFouBuFaHuo;//供应商是否补发
@property (weak, nonatomic) IBOutlet UIButton *buttonGongYingShangShiFouBuFaHuoQingXuanZe;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *labelBeiZhu;


@end
