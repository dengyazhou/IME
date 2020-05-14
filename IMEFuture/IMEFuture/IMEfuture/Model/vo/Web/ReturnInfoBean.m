//
//  ReturnInfoBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ReturnInfoBean.h"
#import <MJExtension.h>
#import "NewsBean.h"
#import "ExhibitionBean.h"


@implementation ReturnInfoBean

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"newsList":@"NewsBean",@"onlineList":@"ExhibitionBean",@"offlineList":@"ExhibitionBean",@"activityList":@"NewsBean"};
}
@end
