//
//  FactoryDeliverInfoBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/4/14.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "FactoryDeliverInfoBean.h"

#import "MJExtension.h"
#import "FactoryDeliverBean.h"

@implementation FactoryDeliverInfoBean

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"list":@"FactoryDeliverBean"};
}

@end
