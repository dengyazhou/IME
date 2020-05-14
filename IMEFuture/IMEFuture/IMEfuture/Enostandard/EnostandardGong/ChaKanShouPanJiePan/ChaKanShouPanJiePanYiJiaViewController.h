//
//  ChaKanShouPanViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InquiryOrder;

@interface ChaKanShouPanJiePanYiJiaViewController : UIViewController


@property (nonatomic,copy) NSString *orderId;

//此字段用户 调用 询盘详情，获取inquiryOrder.inquiryOrderEnterprises[0].quotationOrderId，然后调用报价单
@property (nonatomic,copy) NSString *inquiryOrderId;




@property (weak, nonatomic) IBOutlet UILabel *titleHeader;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;




@property (weak, nonatomic) IBOutlet UIButton *buttonJuJueShouPan;//拒绝授盘
@property (weak, nonatomic) IBOutlet UIButton *buttonJieShouShouPan;//接受授盘
@property (weak, nonatomic) IBOutlet UIButton *buttonJieShouShouPan2;


@property (nonatomic,strong) NSString *quotationOrderId;

@property (weak, nonatomic) IBOutlet UIView *viewJuJueShouPan;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *buttonWanCheng;



@end
