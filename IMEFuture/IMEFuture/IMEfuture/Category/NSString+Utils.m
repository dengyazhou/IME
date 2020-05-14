//
//  NSString+Utils.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/8/31.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^((1[3,5,8][0-9])|(14[5,7])|(17[0,6,7,8]))[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

+ (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

+ (NSString *)convertToJsonDataTouMingGongChang:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

+ (NSString *)removeSuffixIsZone:(double)num {
    //float、double -- NSLog(@"%f",a) 六位小数
    NSString *numStr = [NSString stringWithFormat:@"%.6f",num];
    NSString *last = [numStr componentsSeparatedByString:@"."].lastObject;
    if ([[last substringFromIndex:last.length-1] isEqualToString:@"0"]) {
        numStr = [numStr substringToIndex:numStr.length-1];
        NSString *last = [numStr componentsSeparatedByString:@"."].lastObject;
        if ([[last substringFromIndex:last.length-1] isEqualToString:@"0"]) {
            numStr = [numStr substringToIndex:numStr.length-1];
            NSString *last = [numStr componentsSeparatedByString:@"."].lastObject;
            if ([[last substringFromIndex:last.length-1] isEqualToString:@"0"]) {
                numStr = [numStr substringToIndex:numStr.length-1];
                NSString *last = [numStr componentsSeparatedByString:@"."].lastObject;
                if ([[last substringFromIndex:last.length-1] isEqualToString:@"0"]) {
                    numStr = [numStr substringToIndex:numStr.length-1];
                    NSString *last = [numStr componentsSeparatedByString:@"."].lastObject;
                    if ([[last substringFromIndex:last.length-1] isEqualToString:@"0"]) {
                        numStr = [numStr substringToIndex:numStr.length-1];
                        NSString *last = [numStr componentsSeparatedByString:@"."].lastObject;
                        if ([[last substringFromIndex:last.length-1] isEqualToString:@"0"]) {
                            numStr = [numStr substringToIndex:numStr.length-2];
                        }
                    }
                }
            }
        }
    }
    return numStr;
}
@end
