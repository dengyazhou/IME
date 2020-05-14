//
//  IMEProcessPool.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "IMEProcessPool.h"

static IMEProcessPool* _instance = nil;

@implementation IMEProcessPool

+(instancetype) shareInstance {
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    return _instance ;
}

+ (void)shareClear {
    _instance = nil;
}
@end
