//
//  ScanEmployeeVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/9/2.
//  Copyright © 2018年 Netease. All rights reserved.
//


/**
 审核报工，扫描二维码 专用
 */
#import <UIKit/UIKit.h>

@interface ScanEmployeeVC : UIViewController

@property (nonatomic,copy) void(^passwordAuthentificationBlockTemp)(NSString *,NSInteger);



- (void)passwordAuthentificationCallBack:(void(^)(NSString * str,NSInteger needPassword))passwordAuthentificationBlock;




@end
