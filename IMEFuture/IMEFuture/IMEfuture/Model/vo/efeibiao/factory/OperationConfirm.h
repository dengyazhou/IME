//
//  OperationConfirm.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/31.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationConfirm : NSObject

/**
 * 工序编号
 */
@property (nonatomic,copy) NSString * operationCode;

/**
 * 工序描述
 */
@property (nonatomic,copy) NSString * operationText;

/**
 * 作业单元编号
 */
@property (nonatomic,copy) NSString * workUnitCode;

/**
 * 完工数量
 */
@property (nonatomic,copy) NSString * completedQuantity;

/**
 * 报工人
 */
@property (nonatomic,copy) NSString * confirmUser;

/**
 * 报工时间
 */
@property (nonatomic,copy) NSString * confirmDateTime;

/**
 * 计划工时
 */
@property (nonatomic,copy) NSString * planProcessHours;

/**
 * 实际工时
 */
@property (nonatomic,copy) NSString * actualProcessHours;

/**
 * 完成时间
 */
@property (nonatomic,copy) NSString * actualendDateTime;

/**
 * 工序状态
 */
@property (nonatomic,copy) NSString * processStatuseCode;

@end
