//
//  ReqOutboundVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/2.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReqOutboundVo : NSObject

/**
 *  工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;
/**
 * 出库单号
 */
@property (nonatomic,copy) NSString * outboundCode;
/**
 * 领料申请单号
 */
@property (nonatomic,copy) NSString * requisitionCode;
/**
 * 项目编号
 */
@property (nonatomic,copy) NSString * projectCode;
/**
 * 生产作业单号
 */
@property (nonatomic,copy) NSString * productionControlNum;
/**
 * 物料单号
 */
@property (nonatomic,copy) NSString * materialCode;
/**
 * 领料申请数
 */
@property (nonatomic,strong) NSNumber * reqNum;//Double
/**
 * 领料出库数
 */
@property (nonatomic,strong) NSNumber * outNum;//Double
/**
 * 单位
 */
@property (nonatomic,copy) NSString * unit;
/**
 * 仓库编号
 */
@property (nonatomic,copy) NSString * warehouseCode;
/**
 * 备注
 */
@property (nonatomic,copy) NSString * memo;
/**
 * 操作人编号
 */
@property (nonatomic,copy) NSString * operator;
/**
 * 出库日期
 */
@property (nonatomic,copy) NSString * outboundDate;//Date
/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialText;
/**
 * 仓库描述
 */
@property (nonatomic,copy) NSString * warehouseText;
/**
 * 物料规格
 */
@property (nonatomic,copy) NSString * materialSpec;
/**
 * 物料类型描述
 */
@property (nonatomic,copy) NSString * materialTypeText;
/**
 * 操作人名字
 */
@property (nonatomic,copy) NSString * operatorText;
/**
 * 目的地
 */
@property (nonatomic,copy) NSString * destination;
/**
 * 状态
 */
@property (nonatomic,strong) NSNumber * state;//Integer
/**
 *
 */
@property (nonatomic,strong) NSNumber * quantity;//Double

/**
 * 领料接收人(入库操作人)
 */
@property (nonatomic,copy) NSString * toWarehouseOperator;



@property (nonatomic,copy) NSString * testdyz;

@end
