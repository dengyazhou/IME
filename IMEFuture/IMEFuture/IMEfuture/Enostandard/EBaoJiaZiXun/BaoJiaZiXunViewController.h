//
//  BaoJiaZiXunViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InquiryOrder;

@interface BaoJiaZiXunViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (nonatomic,strong) InquiryOrder *inquiryOrder;

@property (nonatomic,copy) NSString *inquiryOrderId;

@property (weak, nonatomic) IBOutlet UIButton *buttonTiWen;

@end
