//
//  MaterialOutgoingOrderDetailVo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/1.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "MaterialOutgoingOrderDetailVo.h"
#import <MJExtension.h>

@implementation MaterialOutgoingOrderDetailVo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idDYZ":@"id"};
}

@end
