//
//  ProductionConfirmInfo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/31.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ProductionConfirmInfo.h"
#import "OperationConfirm.h"
#import "MJExtension.h"

@implementation ProductionConfirmInfo

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"operationConfirms":@"OperationConfirm"};
}

@end
