//
//  FactoryProductInfo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FactoryProductInfo.h"

#import "MJExtension.h"

#import "ProductionOrderInfoForShow.h"

@implementation FactoryProductInfo

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"productionOrderInfoForShowList":@"ProductionOrderInfoForShow"};
}

@end
