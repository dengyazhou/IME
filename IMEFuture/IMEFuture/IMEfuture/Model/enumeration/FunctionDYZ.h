//
//  FunctionDYZ.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/28.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionDYZ : NSObject

+ (instancetype)dyz;


//获取前一天
- (NSString *)lastDay:(NSString *)time;


/// 获取当前时间之前的时间
/// @param days 天数。如果要获取当前时间days就传0
/// @param dateFormat 时间格式  @"yyyy-MM-dd HH:mm:ss"
- (NSString *)strBeforeTheCurrentTime:(NSInteger)days withDateFormat:(NSString *)dateFormat;

/// 时间字符串 转化成制定格式的 时间字符串
/// @param time 传入的时间字符串
/// @param dateFormat 时间格式  @"yyyy-MM-dd HH:mm:ss"


/// 时间字符串 转化成制定格式的 时间字符串
/// @param time 传入的时间字符串
/// @param enterDateFormat 传入的时间格式  eg：@"yyyy-MM-dd HH:mm:ss"
/// @param goDateFormat 传出的时间格式 eg：@"yy/MM/dd HH:mm"
- (NSString *)strDateFormat:(NSString *)time withEnterDateFormat:(NSString *)enterDateFormat withGoDateFormat:(NSString *)goDateFormat;


/// 时间字符串 转化成 时间
/// @param time 传入的时间字符串
/// @param enterDateFormat 传入的时间格式  eg：@"yyyy-MM-dd HH:mm:ss"。默认为yyyy-MM-dd HH:mm:ss
- (NSDate *)dateWithString:(NSString *)time withEnterDateFormat:(NSString *)enterDateFormat;


/// 时间 转化成 时间字符串
/// @param date 传入的时间
/// @param enterDateFormat 传入的时间格式  eg：@"yyyy-MM-dd HH:mm:ss"。默认为yyyy-MM-dd HH:mm:ss
- (NSString *)stringWithDate:(NSDate *)date withEnterDateFormat:(NSString *)enterDateFormat;

@end
