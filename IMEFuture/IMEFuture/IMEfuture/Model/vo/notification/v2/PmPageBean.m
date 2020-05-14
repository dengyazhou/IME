//
//  PmPageBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/9/15.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "PmPageBean.h"

#import "MJExtension.h"
#import "ParamsBean.h"

@implementation PmPageBean
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"extra":@"ParamsBean"};
}
@end
