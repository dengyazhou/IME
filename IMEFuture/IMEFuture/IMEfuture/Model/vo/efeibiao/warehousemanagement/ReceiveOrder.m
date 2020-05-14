//
//  ReceiveOrder.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ReceiveOrder.h"

@implementation ReceiveOrder

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"receiveOrderItems" : @"ReceiveItemBean",
             
             };
}

@end
