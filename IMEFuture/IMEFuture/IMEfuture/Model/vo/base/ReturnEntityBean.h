//
//  ReturnEntityBean.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/22.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ReturnMsgBean.h"

@interface ReturnEntityBean : ReturnMsgBean

/**
 * 数据Bean
 */
@property (nonatomic,strong) NSDictionary *entity;//T

/**
 * 额外的json字符串
 */
@property (nonatomic,copy) NSString *jsonStr;

@end
