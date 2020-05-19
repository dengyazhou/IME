//
//  MemberResBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/5/18.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "MemberResBean.h"

@implementation MemberResBean

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"idd" : @"id"
             };
}

@end
