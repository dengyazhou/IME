//
//  ShanChuTuPianVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/3/8.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InquiryOrderItem.h"

@interface ShanChuTuPianVC : UIViewController

@property (nonatomic,copy) void(^buttonBackBlock)(InquiryOrderItem *inquiryOrderItem);//保存
@property (nonatomic,strong) InquiryOrderItem *inquiryOrderItem;
@property (nonatomic,assign) NSInteger index;

@end
