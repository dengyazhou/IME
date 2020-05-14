//
//  BaseBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseBean.h"
#import "TagReBean.h"
#import "MJExtension.h"

@implementation BaseBean

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"tagRes":@"TagReBean"};
}
@end
