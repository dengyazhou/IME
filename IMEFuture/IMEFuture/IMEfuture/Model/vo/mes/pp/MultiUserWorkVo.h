//
//  MultiUserWorkVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/7/23.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ImeCommonVo.h"

#import "WorkTimeLogVo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MultiUserWorkVo : ImeCommonVo


/**
 * 批量报工单号
 */
@property (nonatomic, copy) NSString * multiUserWorkNum;

/**
 * 项目编号
 */
@property (nonatomic, copy) NSString * projectNum;

/**
 * 项目名称
 */
@property (nonatomic, copy) NSString * projectName;

/**
 * 生产订单编号
 */
@property (nonatomic, copy) NSString * productionOrderNum;

/**
 * 生产管理号
 */
@property (nonatomic, copy) NSString * productionControlNum;

/**
 * 当前工序号
 */
@property (nonatomic, copy) NSString * operationCode;
/**
 * 当前工序号
 */
@property (nonatomic, copy) NSString * operationText;

/**
 * NUMBER(19) 工艺工序ID
 */
@property (nonatomic, copy) NSString * processOperationId;//long

/**
 * 作业单元编号
 */
@property (nonatomic, copy) NSString * workUnitCode;
/**
 * 作业单元编号
 */
@property (nonatomic, copy) NSString * workUnitText;

/**
 * 物料编号
 */
@property (nonatomic, copy) NSString * materialCode;
/**
 * 物料名称
 */
@property (nonatomic, copy) NSString * materialText;
/**
 * 图号
 */
@property (nonatomic, copy) NSString * figureNum;
/**
 * 剩余天数
 */
@property (nonatomic, copy) NSString * remainingDays;
/**
 * 计划数量（pad订单数量）
 */
@property (nonatomic, strong) NSNumber * planQuantity;//Double
/**
 * 已用工时--毫秒
 */
@property (nonatomic, strong) NSNumber * spendWorkTime;//Long
/**
 * 剩余工时--毫秒
 */
@property (nonatomic, strong) NSNumber * surplusTime;//Double
/**
 * 计划工时--小时
 */
@property (nonatomic, strong) NSNumber * plannedHours;//Double
/**
 * 交期
 */
@property (nonatomic, copy) NSString * requirementDate;//Date
/**
 * 未完成数
 */
@property (nonatomic, strong) NSNumber * unfinishedQuantity;//Double

/**
 * 零件id
 */
@property (nonatomic, copy) NSString * partsId;
/**
 * 零件版本id
 */
@property (nonatomic, copy) NSString * partsVersionId;
/**
 * 零件版本号
 */
@property (nonatomic, copy) NSString * partsVersionNo;

/**
 * 停机原因CODE
 */
@property (nonatomic, copy) NSString * shutDownCauseCode;

/**
 * 停机原因描述
 */
@property (nonatomic, copy) NSString * shutDownCauseText;

/**
 * 工作时间
 */
@property (nonatomic, strong) NSNumber * workTime;//Long

/**
 * 实际开始时间
 */
@property (nonatomic, copy) NSString * startDateTime;//Date

/**
 * 实际完成时间
 */
@property (nonatomic, copy) NSString * actualendDateTime;//Date

/**
 * 报工记录状态-0：创建，1：开始，2：暂停，3：继续，4：完成，5：报工
 */
@property (nonatomic, strong) NSNumber * status;//Integer

/**
 * 操作人
 */
@property (nonatomic, copy) NSString * allConfirmUserText;

/**
 * 报废数量
 */
@property (nonatomic, strong) NSNumber * scrappedQuantity;//Double

/**
 * 完成率
 */
@property (nonatomic, copy) NSString * completedRate;

/**
 * 合格率
 */
@property (nonatomic, copy) NSString * qualifiedRate;

/**
 * 合格率
 */
@property (nonatomic, strong) NSNumber * completedQuantity;//Double

/**
 * 计划开始时间
 */
@property (nonatomic, copy) NSString * plannedStartDate;//Date

/**
 * 计划结束时间
 */
@property (nonatomic, copy) NSString * plannedEndDate;//Date

/**
 * 报工记录类型 0 正常生产 1 返工返修
 */
@property (nonatomic, strong) NSNumber * workRecordType;//Integer

/**
 * 审核员
 */
@property (nonatomic, copy) NSString * auditor;

/**
 * 密码
 */
@property (nonatomic, copy) NSString * password;

/**
 * 提交方式   0 正常提交 1审核提交
 */
@property (nonatomic, strong) NSNumber * submitType;//Integer

/**
 * 登录方式
 */
@property (nonatomic, copy) NSString * loginType;

/**
 * 完工模式:1非标+不超产，2非标+超产，3标准模式
 */
@property (nonatomic, strong) NSNumber * completionMode;//Integer

/**
 * 多人报工单子项
 */
@property (nonatomic, strong) NSMutableArray <WorkTimeLogVo *>* multiUserWorkItemList;

@property (nonatomic, strong) NSNumber * confirmSourceType;

/**
* 继续报工标志 、0否1是
*/
@property (nonatomic, strong) NSNumber * continueFlag;//Integer


@end

NS_ASSUME_NONNULL_END
