//
//  EGYiJiaViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/3/27.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGYiJiaViewController : UIViewController

@property (nonatomic,strong) NSString *inquiryOrderId;
//@property (nonatomic,strong) NSString *quotationOrderId;

@property (weak, nonatomic) IBOutlet UILabel *titleHeader;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *tableView1;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom1;

@end
