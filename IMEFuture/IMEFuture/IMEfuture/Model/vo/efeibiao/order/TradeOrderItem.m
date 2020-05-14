//
//  TradeOrderItem.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/3.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "TradeOrderItem.h"

#import "MJExtension.h"
#import "TradeOrderItemFile.h"
#import "QuotationOrder.h"

@implementation TradeOrderItem

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"tradeOrderItemFiles":@"TradeOrderItemFile",@"sec_batchDeliverItems":@"BatchDeliverItem"};
}

@end
