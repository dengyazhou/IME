//
//  TemporaryTaskTypeVo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "TemporaryTaskTypeVo.h"

@implementation TemporaryTaskTypeVo

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"idDYZ":@"id"
             };
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lockFlag = [NSNumber numberWithInteger:0];
    }
    return self;
}

@end
