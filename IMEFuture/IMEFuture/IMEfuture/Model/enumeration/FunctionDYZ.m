//
//  FunctionDYZ.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/28.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FunctionDYZ.h"

@implementation FunctionDYZ



+ (instancetype)dyz {
    FunctionDYZ *func = [[FunctionDYZ alloc] init];
    return func;
}

- (NSString *)lastDay:(NSString *)time {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateTime = [formatter dateFromString:time];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:dateTime];
    NSString *lastDayTime = [formatter stringFromDate:lastDay];
    return lastDayTime;
}

- (NSString *)strBeforeTheCurrentTime:(NSInteger)days withDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-24*60*60*days];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSString *)strDateFormat:(NSString *)time withEnterDateFormat:(NSString *)enterDateFormat withGoDateFormat:(NSString *)goDateFormat {
    NSDateFormatter *enter = [[NSDateFormatter alloc] init];
    [enter setDateFormat:enterDateFormat];
    NSDate *dateTime = [enter dateFromString:time];//string转date
    
    NSDateFormatter *go = [[NSDateFormatter alloc] init];
    [go setDateFormat:goDateFormat];
    
    NSString *reString = [go stringFromDate:dateTime];//date转string
    return reString;
}

- (NSDate *)dateWithString:(NSString *)time withEnterDateFormat:(NSString *)enterDateFormat {
    if (enterDateFormat == nil) {
        enterDateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *enter = [[NSDateFormatter alloc] init];
    [enter setDateFormat:enterDateFormat];
    NSDate *dateTime = [enter dateFromString:time];//string转date
    return dateTime;
}

- (NSString *)stringWithDate:(NSDate *)date withEnterDateFormat:(NSString *)enterDateFormat {
    if (enterDateFormat == nil) {
        enterDateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *enter = [[NSDateFormatter alloc] init];
    [enter setDateFormat:enterDateFormat];
    NSString *reString = [enter stringFromDate:date];//date转string
    return reString;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
