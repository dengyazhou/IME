//
//  ProductionOrderInfo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/31.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ProductionOrderInfo.h"

#import "ProductionConfirmInfo.h"
#import "MJExtension.h"

@implementation ProductionOrderInfo

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"productionConfirmInfo":@"ProductionConfirmInfo"};
}

@end
