//
//  ProfileUpdatesObject.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/2/28.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ProfileUpdatesObject.h"

#import <objc/runtime.h>

@implementation ProfileUpdatesObject


- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    unsigned int count = 0;
    Ivar* ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar var = ivars[i];
        const char* name = ivar_getName(var);
        NSString* key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [coder encodeObject:value forKey:key];
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
            id value = [coder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}


+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
