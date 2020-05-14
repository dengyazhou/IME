//
//  ReceiveItemBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ReceiveItemBean.h"

@implementation ReceiveItemBean

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"DYZinitReceiveNum" : @"initReceiveNum"
             };
}

@end
