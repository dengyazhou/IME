//
//  ShouHuooDetailCell0903.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReceiveItemBean.h"
#import "DeliverOrderItemBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShouHuooDetailCell0903 : UITableViewCell

@property (nonatomic,copy) ReceiveItemBean *model;
@property (nonatomic,strong) DeliverOrderItemBean *model1;

@property (nonatomic,copy) void(^buttonPartDetailCallBack)(void);

@end

NS_ASSUME_NONNULL_END
