//
//  FaHuoCell0906.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DeliverOrderDetailBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaHuoCell0906 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelBeiZhu;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (strong, nonatomic) DeliverOrderDetailBean *model;

@property (copy, nonatomic) void(^textFieldBeginDYZCallBack)(void);

@end

NS_ASSUME_NONNULL_END
