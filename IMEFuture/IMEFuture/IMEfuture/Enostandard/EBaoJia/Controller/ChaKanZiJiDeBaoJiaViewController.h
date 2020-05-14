//
//  ChaKanZiJiDeBaoJiaViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InquiryOrder;

@interface ChaKanZiJiDeBaoJiaViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;

@property (nonatomic,strong)InquiryOrder *inquiryOrder;


/**
 * 询盘订单编号
 */
/**
 * 询盘标题
 */
@property (weak, nonatomic) IBOutlet UILabel *inquiryOrderCodeAndTitle;

@end
