//
//  XuanZeXunPanGongYiVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XuanZeXunPanGongYiVC : UIViewController

@property (nonatomic,copy) void(^buttonBackBlock)(NSMutableArray *arrayBaseTag);

@property (nonatomic,strong) NSMutableArray *arrayTempBaseTag;

@end
