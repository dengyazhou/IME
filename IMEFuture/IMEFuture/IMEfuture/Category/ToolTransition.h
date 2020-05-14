//
//  ToolTransition.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/3/5.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolTransition : NSObject

#pragma mark NSDate->NSString
+ (NSString *)stringFromDate:(NSDate *)date;

#pragma mark NSString->NSDate
+ (NSDate *)dateFromString:(NSString *)string;

#pragma mark 时间比较大小
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

#pragma mark NSArray->NSString
+ (NSString *)stringFromArray:(NSArray *)array;

#pragma mark NSString->NSArray
+ (NSArray *)arrayFromString:(NSString *)jsonStr;

@end
