//
//  TradeOrder.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/3.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "TradeOrder.h"

#import "MJExtension.h"
#import "TradeOrderItem.h"

@implementation TradeOrder

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"tradeOrderItems":@"TradeOrderItem",@"orderItems":@"TradeOrderItem"};
}

@end
