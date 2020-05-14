//
//  PartDetailsViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InquiryOrderItem.h"

@interface PartDetailsViewController : UIViewController

@property (nonatomic,assign) NSUInteger indexNum;
@property (nonatomic,strong) InquiryOrderItem *inquiryOrderItem;

@property (nonatomic,copy) NSString *enterpriseId;

@property (nonatomic,copy) NSString *inquiryType;
@property (nonatomic,copy) NSString *sourceCaiOrGong;//cai gong


@end
