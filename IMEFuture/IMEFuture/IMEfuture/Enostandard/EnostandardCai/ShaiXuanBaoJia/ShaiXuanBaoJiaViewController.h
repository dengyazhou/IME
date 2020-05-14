//
//  ShaiXuanBaoJiaViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InquiryOrder;

@interface ShaiXuanBaoJiaViewController : UIViewController

@property (nonatomic,strong) InquiryOrder *inquiryOrder;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
