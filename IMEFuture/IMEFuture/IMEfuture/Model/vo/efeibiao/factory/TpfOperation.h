//
//  TpfOperation.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/3.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TpfOperation : NSObject

/**
 * 工序编号
 */
@property (nonatomic,copy) NSString * operationCode;

/**
 * 工序描述
 */
@property (nonatomic,copy) NSString * operationText;

/**
 * 工序序号
 */
@property (nonatomic,copy) NSString * operationOrdinal;

/**
 *
 */
@property (nonatomic,copy) NSString * typeText;

@property (nonatomic,copy) NSString * workUnitTypeCode;

/**
 * 是否确认点（0代表不是，1;代表是确认点）
 */
@property (nonatomic,strong) NSNumber * confirmFlag;//int

@end
