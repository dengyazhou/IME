//
//  ProductionOperationVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WorkUnitVo.h"

@interface ProductionOperationVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;
/**
 * 生产作业单号
 */
@property (nonatomic,copy) NSString * productionControlNum;
/**
 * 工艺工序ID
 */
@property (nonatomic,copy) NSString * processOperationId;
/**
 * 工艺工序排序号
 */
@property (nonatomic,copy) NSString * operationOrdinal;
/**
 * 工序编号
 */
@property (nonatomic,copy) NSString * operationCode;
/**
 * 工序名称
 */
@property (nonatomic,copy) NSString * operationText;

/**
 * 最后报工人员code
 */
@property (nonatomic,copy) NSString * operatorCode;
/**
 * 最后报工人员名称
 */
@property (nonatomic,copy) NSString * operatorText;
/**
 * 最后操作设备编号
 */
@property (nonatomic,copy) NSString * lastWorkUnitCode;
/**
 * 最后操作设备描述
 */
@property (nonatomic,copy) NSString * lastWorkUnitText;

/**
 * 作业单元类型
 */
@property (nonatomic,copy) NSString * workUnitTypeCode;

/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber * plannedHours;//Double

/**
 * 实际工时
 */
@property (nonatomic,strong) NSNumber * actualHours;//Long

/**
 * 生产作业单计划数
 */
@property (nonatomic,strong) NSNumber * plannedQuantity;//Double

/**
 * 当前工序已报工数
 */
@property (nonatomic,strong) NSNumber * completedQuantity;//Double
/**
 * 当前工序未报工数
 */
@property (nonatomic,strong) NSNumber * unCompletedQuantity;//Double
/**
 * 当前工序报废数
 */
@property (nonatomic,strong) NSNumber * scrappedQuantity;//Double
/**
 * 当前工序报废数
 */
@property (nonatomic,strong) NSNumber * qualifiedQuantity;//Double
/**
 * 当前返修数
 */
@property (nonatomic,strong) NSNumber * repairQuantity;//Double

/**
 * 作业单元列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof WorkUnitVo *> * workUnitVoList;

@end
