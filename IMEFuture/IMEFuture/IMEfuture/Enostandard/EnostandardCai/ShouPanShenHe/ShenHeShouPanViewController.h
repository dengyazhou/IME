//
//  ShenHeShouPanViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuotationOrder;

@interface ShenHeShouPanViewController : UIViewController

@property (nonatomic,copy) NSString *orderId;

//此字段用户 调用 询盘详情，获取inquiryOrder.inquiryOrderEnterprises[0].quotationOrderId，然后调用报价单
@property (nonatomic,copy) NSString *inquiryOrderId;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;

@property (nonatomic,copy) NSString *quotationOrderId;

@end
