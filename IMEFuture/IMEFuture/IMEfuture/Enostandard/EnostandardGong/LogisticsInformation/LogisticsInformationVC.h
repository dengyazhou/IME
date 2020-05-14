//
//  LogisticsInformationVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/3/13.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogisticsInformationVC : UIViewController

@property (copy,nonatomic) NSString *orderCode;




@property (copy,nonatomic) NSString *orderId;//专为确认发货后订单详情界面刷新

@end
