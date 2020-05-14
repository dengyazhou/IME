//
//  ProjectDrawingResBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/4/2.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ProjectDrawingResBean.h"

@implementation ProjectDrawingResBean

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"idd" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"drawInfo" : @"DrawInfoBean"
             };
}

@end
