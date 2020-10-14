//
//  WorkTimeLogVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/22.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkTimeLogVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * 停机原因代码
 */
@property (nonatomic,copy) NSString * shutDownCauseCode;

/**
 * 停机原因描述
 */
@property (nonatomic,copy) NSString * shutDownCauseText;

/**
 * 项目编号
 */
@property (nonatomic,copy) NSString * projectNum;
/**
 * 项目名称
 */
@property (nonatomic,copy) NSString * projectName;

/**
 * 生产管理号
 */
@property (nonatomic,copy) NSString * productionControlNum;

/**
 * 物料编号
 */
@property (nonatomic,copy) NSString * materialCode;
/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialText;
/**
 * 图号
 */
@property (nonatomic,copy) NSString * figureNum;
/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * requirementDate;

/**
 * 作业单元编号
 */
@property (nonatomic,copy) NSString * workUnitCode;

/**
 * 作业单元名称
 */
@property (nonatomic,copy) NSString * workUnitText;

/**
 * 当前工序号
 */
@property (nonatomic,copy) NSString * operationCode;

@property (nonatomic,copy) NSString * operationText;

/**
 * 工艺工序ID
 */
@property (nonatomic,copy) NSString * processOperationId;

/**
 * 报工人
 */
@property (nonatomic,copy) NSString * confirmUser;

/**
 * 报工人
 */
@property (nonatomic,copy) NSString *confirmUserText;

/**
 * 工作时间
 */
@property (nonatomic,strong) NSNumber * workTime;//Long

/**
 * 实际开始时间
 */
@property (nonatomic,copy) NSString * startDateTime;//Date

/**
 * 最后操作时间
 */
@property (nonatomic,strong) NSString * actualendDateTime;//Date

/**
 * 备注
 */
@property (nonatomic,copy) NSString * memo;

/**
 * 剩余天数
 */
@property (nonatomic,strong) NSNumber * remainingDays;//int
/**
 * 订单数量
 */
@property (nonatomic,strong) NSNumber * planQuantity;//int

/**
 * 未完成数量
 */
@property (nonatomic,strong) NSNumber * unfinishedQuantity;//Double
/**
 * 工序任务单编号
 */
@property (nonatomic,copy) NSString * operationTaskNum;

/**
 * 报工记录状态-1：开始，2：暂停，3：继续，4：完成，5：报工
 */
@property (nonatomic,strong) NSNumber * status;//int

@property (nonatomic,strong) NSNumber * logId;//Long

/**
 * 计划工时
 */
@property (nonatomic,copy) NSNumber * planWorkTime;//Double

/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber *spendTime;//Double

/**
 * 计划工时
 */
@property (nonatomic,strong) NSNumber *surplusTime;//Double

/**
 * 差异工时
 */
@property (nonatomic,copy) NSString * difWorkTime;

/**
 * 排名，行号
 */
@property (nonatomic,strong) NSNumber * rowno;//Long

/**
 * 报工关联ID
 */
@property (nonatomic,copy) NSString * confirmId;
/**
 * IMEI码
 */
@property (nonatomic,copy) NSString * imeiCode;

/**
 * 用户中心企业ID
 */
@property (nonatomic,copy) NSString * purchaseEnterpriseId;
/**
 * 零件id
 */
@property (nonatomic,copy) NSString * partsId;
/**
 * 零件版本id
 */
@property (nonatomic,copy) NSString * partsVersionId;
/**
 * 零件版本号
 */
@property (nonatomic,copy) NSString * partsVersionNo;

/**
 * 报工记录类型 0 正常生产 1 返工返修
 */
@property (nonatomic,strong) NSNumber * workRecordType;//Integer

/**
 * 物料规格
 */
@property (nonatomic,copy) NSString * materialspec;

/**
 * NUMBER(19,3) 计划数量
 */
@property (nonatomic,strong) NSNumber * plannedQuantity;//double

/**
 * NUMBER(19,3) 完工 数量
 */
@property (nonatomic,strong) NSNumber * completedQuantity;//double
/**
 * 报工类型  1生产2质检
 */
@property (nonatomic,strong) NSNumber * workTimeLogType;//Integer

/**
 质检ID
 */
@property (nonatomic,strong) NSNumber * checkId;//Long

/**
 * 完工模式:1非标+不超产，2非标+超产，3标准模式
 */
@property (nonatomic,strong) NSNumber * completionMode;//Integer

@end
