//
//  RefreshManager.m
//  DemoOC
//
//  Created by 邓亚洲 on 2019/6/27.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "RefreshManager.h"

@implementation RefreshManager

+ (instancetype)shareRefreshManager {
    static RefreshManager *rManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        rManager = [[self alloc] init];
    });
    return rManager;
}

@end
