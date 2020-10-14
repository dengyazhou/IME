//
//  PersonnelVo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/21.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "PersonnelVo.h"

#import <objc/runtime.h>

@implementation PersonnelVo

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char* name = ivar_getName(var);
        NSString* key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        if ([key isEqualToString:@"_isSelect"]) {
//            [coder encodeBool:value forKey:key];
        } else {
            [coder encodeObject:value forKey:key];
        }
        
    }
    free(ivars);
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if (self == [super init]) {
        unsigned int count = 0;
        Ivar* ivars = class_copyIvarList([self class], &count);
        
        for (int i = 0; i < count; i++) {
            Ivar var = ivars[i];
            const char* name = ivar_getName(var);
            NSString* key = [NSString stringWithUTF8String:name];
            id value;
            if ([key isEqualToString:@"_isSelect"]) {
//                value = [coder decodeBoolForKey:key];
            } else {
                value = [coder decodeObjectForKey:key];
                [self setValue:value forKey:key];
            }
            
        }
        free(ivars);
    }
    return self;
}


+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
