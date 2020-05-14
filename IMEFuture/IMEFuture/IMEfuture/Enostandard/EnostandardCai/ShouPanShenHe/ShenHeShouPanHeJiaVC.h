//
//  ShenHeShouPanHeJiaVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/3/27.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShenHeShouPanHeJiaVC : UIViewController

@property (nonatomic,copy) NSString *orderId;

//此字段用户 调用 询盘详情，获取inquiryOrder.inquiryOrderEnterprises[0].quotationOrderId，然后调用报价单
@property (nonatomic,strong) NSString *inquiryOrderId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;


@end
