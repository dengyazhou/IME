//
//  AccInter.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/1/6.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccVersionInter.h"

@interface AccInter : NSObject

/**
 * 状态(是否搜到零件)
 */
@property (nonatomic,assign) Boolean status;//Boolean

@property (nonatomic,copy) NSString * errorMess;

/**
 * 零件id
 */
@property (nonatomic,copy) NSString * accId;

/**
 * 所有版本列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof AccVersionInter *> *versions;

/**
 * 最新版本
 */
@property (nonatomic,strong) AccVersionInter * latestVersion;

/**
 * 匹配的版本
 */
@property (nonatomic,strong) AccVersionInter *foundVersion;

/**
 * 零件号
 */
@property (nonatomic,copy) NSString *  accessoryCodeDis;

@end
