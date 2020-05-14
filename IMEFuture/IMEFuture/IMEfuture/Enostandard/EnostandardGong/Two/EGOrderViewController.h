//
//  EGOrderViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGOrderViewController : UIViewController

//询盘号
@property (nonatomic,copy) NSString *se_enterpriseOrderCode;







@property (nonatomic,assign) NSInteger indexInquiryType;

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
