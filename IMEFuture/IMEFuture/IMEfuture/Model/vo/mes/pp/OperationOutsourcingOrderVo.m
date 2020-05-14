//
//  OperationOutsourcingOrderVo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/28.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "OperationOutsourcingOrderVo.h"

@implementation OperationOutsourcingOrderVo

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"operationOutsourcingOrderItemList" : @"OperationOutsourcingOrderItemVo"
             };
}

@end
