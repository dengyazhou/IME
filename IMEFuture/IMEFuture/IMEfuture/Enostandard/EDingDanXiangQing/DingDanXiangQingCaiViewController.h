//
//  DingDanXiangQingViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/15.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TradeOrder;

@interface DingDanXiangQingCaiViewController : UIViewController

@property (nonatomic,copy) NSString *orderId;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (weak, nonatomic) IBOutlet UIView *view1;


@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;


@property (nonatomic,strong) TradeOrder *tradeOrder;

@property (nonatomic,copy) NSString *stringResource;


@end
