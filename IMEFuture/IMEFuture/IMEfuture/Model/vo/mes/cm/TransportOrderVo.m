//
//  TransportOrderVo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/9.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "TransportOrderVo.h"

@implementation TransportOrderVo

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"idDYZ" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"transportOrderVoList" : @"TransportOrderVo",
             @"transportOrderDetailVoList" : @"TransportOrderDetailVo"
             };
}

@end
