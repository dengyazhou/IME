//
//  ShouHuoCell0903.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DeliverOrderItemBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShouHuoCell0903 : UITableViewCell


@property (weak, nonatomic) IBOutlet UITextField *textField1;

@property (weak, nonatomic) IBOutlet UITextField *textFieldReceiveQuantity;
@property (weak, nonatomic) IBOutlet UITextField *textFieldReceiveRemark;

@property (copy, nonatomic) void(^buttonOrderOtemCallBack)(void);
@property (copy, nonatomic) void(^buttonReceiveArea)(void);
@property (copy, nonatomic) void(^textFieldCallBack)(void);

@property (strong, nonatomic) DeliverOrderItemBean *model;


@end

NS_ASSUME_NONNULL_END
