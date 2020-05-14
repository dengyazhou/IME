//
//  XiuGaiBaoJiaViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InquiryOrder;
@class QuotationOrder;

@interface XiuGaiBaoJiaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;


@property (nonatomic,copy) NSString *quotationOrderId;


@property (nonatomic,copy) NSString *stringSource;
@property (weak, nonatomic) IBOutlet UIButton *buttonBaoJia;

/**
 * 询盘订单编号
 */
/**
 * 询盘标题
 */
@property (weak, nonatomic) IBOutlet UILabel *inquiryOrderCodeAndTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom1;
@end
