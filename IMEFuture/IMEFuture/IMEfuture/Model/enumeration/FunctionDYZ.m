//
//  FunctionDYZ.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/28.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FunctionDYZ.h"

@implementation FunctionDYZ



- (NSString *)lastDay:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateTime = [formatter dateFromString:time];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:dateTime];
    NSString *lastDayTime = [formatter stringFromDate:lastDay];
    return lastDayTime;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
