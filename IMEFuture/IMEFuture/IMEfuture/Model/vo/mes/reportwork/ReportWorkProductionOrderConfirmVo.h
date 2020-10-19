//
//  ProductionOrderConfirmVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CauseDetailVo.h"

@interface ReportWorkProductionOrderConfirmVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;

/**
 * 工序编号
 */
@property (nonatomic,copy) NSString * operationCode;

/**
 * 生产作业号
 */
@property (nonatomic,copy) NSString * productionControlNum;

/**
 * 作业单元编号
 */
@property (nonatomic,copy) NSString * workUnitCode;

/**
 * 报工人员编号
 */
@property (nonatomic,copy) NSString * confirmUser;

/**
 * 完成数量
 */
@property (nonatomic,strong) NSNumber * completedQuantity;//Double

/**
 * 报废数量
 */
@property (nonatomic,strong) NSNumber * scrappedQuantity;//Double

/**
 * 返修数量
 */
@property (nonatomic,strong) NSNumber * repairQuantity;//Double

/**
 * 毛重
 */
@property (nonatomic,strong) NSNumber *  roughWeight;//Double

/**
 * 净重
 */
@property (nonatomic,strong) NSNumber *  netweight;//Double

/**
 * 模具编号
 */
@property (nonatomic,copy) NSString *  moldmaterial;

/**
 * 生产状态
 */
@property (nonatomic,strong) NSNumber * status;//Integer

/**
 * 是否返修
 */
@property (nonatomic,strong) NSNumber * reworkStatus;//Integer

/**
 * 报工确认点
 */
@property (nonatomic,strong) NSNumber * confirmFlag;//Integer

/**
 * 实际完工时间
 */
@property (nonatomic,copy) NSString * actualEndDateTime;//Date

/**
 * 报工记录id
 */
@property (nonatomic,strong) NSNumber * logId;//Long

/**
 * 工艺工序id
 */
@property (nonatomic,copy) NSString * processOperationId;//Long

/**
 * 报工时长
 */
@property (nonatomic,copy) NSString * workTime;


/**
 * 报废原因
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * scrappedCauseList;//String[]
/**
 * 返修原因
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * repairCauseList ;

/**
 * 报工记录类型 0 正常生产 1 返工返修
 */
@property (nonatomic,strong) NSNumber * workRecordType;//Integer

/**
 * 报工记录类型是否选择标志
 */
@property (nonatomic,strong) NSNumber * chooseWorkRecordTypeFlag;//Integer

//审核员（用户编号）
@property (nonatomic,copy) NSString * auditor;
//密码
@property (nonatomic,copy) NSString * password;
//提交方式（0正常提交1审核提交）
@property (nonatomic,strong) NSNumber * submitType;
//登录类型 (PDA/WEB)
@property (nonatomic,copy) NSString * loginType;

@property (nonatomic,copy) NSString * sequenceNum;



@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *>*repairCauseDetailVos;// 不良 //CauseDetailVo
@property (nonatomic, strong) NSMutableArray <__kindof CauseDetailVo *>*scrappedCauseDetailVos;//报废 //CauseDetailVo

@end
