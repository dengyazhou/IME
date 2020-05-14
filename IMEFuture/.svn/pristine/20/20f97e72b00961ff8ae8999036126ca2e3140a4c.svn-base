//
//  WorkingOrderVO.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/7.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkingOrderVO : NSObject

/**
 * em_workTimeLog的ID
 */
@property (nonatomic,strong) NSNumber *logId;//Long

/**
 * 生产管理号
 */
@property (nonatomic,copy) NSString * productionControlNum;
/**
 * 生产订单编号
 */
@property (nonatomic,copy) NSString * productionOrderNum;

/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialCode;

/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialText;


/**
 * 作业单元描述 NVARCHAR(60)
 */
@property (nonatomic,copy) NSString * workUnitCode;

/**
 * 作业单元描述 NVARCHAR(60)
 */
@property (nonatomic,copy) NSString * workUnitText;

/**
 * 报工记录状态
 * -1：开始，2：暂停，3：继续，4：完工，5：报工完成
 */
@property (nonatomic,strong) NSNumber * status;//Integer
/**
 * 客户交期
 */
@property (nonatomic,copy) NSString * requirementDate;
/**
 * 工艺编号
 */
@property (nonatomic,copy) NSString * processCode;
/**
 * 工艺版本
 */
@property (nonatomic,copy) NSString * processrev;
/**
 * 工序编号
 */
@property (nonatomic,copy) NSString * operationCode;
/**
 * 工序名称
 */
@property (nonatomic,copy) NSString * operationText;
/**
 * 工艺工序ID
 */
@property (nonatomic,copy) NSString * processOperationId;
/**
 * 操作人名称
 */
@property (nonatomic,copy) NSString * personnelName;
/**
 * 操作人编号
 */
@property (nonatomic,copy) NSString * personnelCode;
/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber * planTime;//Double
/**
 * 剩余工时
 */
@property (nonatomic,strong) NSNumber * surplusTime;//Double
/**
 * 实际开始时间
 */
@property (nonatomic,copy) NSString * startDateTime;//Date

/**
 * 最后操作时间
 */
@property (nonatomic,copy) NSString * actualendDateTime;//Date
/**
 * 下一道工序
 */
@property (nonatomic,copy) NSString * operationTextNext;
/**
 * 工序序号
 */
@property (nonatomic,copy) NSString * operationordinal;
/**
 * 是否确认点标志
 */
@property (nonatomic,copy) NSString * confirmFlag;
/**
 * 工作单元类型
 */
@property (nonatomic,copy) NSString * workunittypecode;
/**
 * 时间工时-时间戳
 */
@property (nonatomic,copy) NSString * workTime;

@property (nonatomic,copy) NSString * isNO;//NO 或者 YES YES时加入数组 默认为NO

@end
