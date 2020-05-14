//
//  FaHuoCell090501.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/14.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DeliverOrderDetailBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaHuoCell090501 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelWuLiuGongSi;

@property (weak, nonatomic) IBOutlet UITextField *textFieldWuLiuDanHao;

@property (copy, nonatomic) void(^buttonClickCallBack)(void);

@property (strong, nonatomic) DeliverOrderDetailBean *model;

@end

NS_ASSUME_NONNULL_END
