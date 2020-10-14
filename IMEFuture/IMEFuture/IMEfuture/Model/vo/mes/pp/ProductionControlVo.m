//
//  ProductionControlVo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/21.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ProductionControlVo.h"

#import <MJExtension.h>

@implementation ProductionControlVo


+ (NSDictionary *)mj_objectClassInArray {
    return @{@"drawingPreviewVoList" : @"DrawingPreviewVo"
             };
}

// 自定义类实现 mutableCopy
- (id)copyWithZone:(struct _NSZone *)zone {
    ProductionControlVo *model = [[ProductionControlVo allocWithZone:zone] init];
    [[[self class] getPropertyNameList:[model class]] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [model setValue:[self valueForKey:obj] forKey:obj];
    }];
    return model;
}

+ (NSArray *)getPropertyNameList:(Class)cls {
    NSMutableArray *propertyNameListArray = [NSMutableArray array];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    for (NSInteger i = 0 ; i < count; i ++) {
        const char *propertyCharName = property_getName(properties[i]);//c的字符串
        NSString *propertyOCName = [NSString stringWithFormat:@"%s",propertyCharName];//转化成oc 字符串
        [propertyNameListArray addObject:propertyOCName];
    }
    NSArray *dataArray = [NSArray arrayWithArray:propertyNameListArray];
    return dataArray;
}

@end
