//
//  MaterialOutgoingOrderDetailVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/8/1.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaterialOutgoingOrderDetailVo : NSObject

/**
 * id
 */
@property (nonatomic, strong) NSNumber * idDYZ;//Long

/**
 * 工厂代码
 */
@property (nonatomic, copy) NSString * siteCode;

/**
 * 到货单
 */
@property (nonatomic, copy) NSString * outgoingOrderNum;

/**
 * 项目编号
 */
@property (nonatomic, copy) NSString * projectNum;

/**
 * 客户编号
 */
@property (nonatomic, copy) NSString * customerCode;

/**
 * 客户名称
 */
@property (nonatomic, copy) NSString * customerText;

/**
 * 物料编号
 */
@property (nonatomic, copy) NSString * materialCode;

/**
 * 物料名称
 */
@property (nonatomic, copy) NSString * materialText;

/**
 * 业务类型
 */
@property (nonatomic, copy) NSString * businessTypeCode;

/**
 * 检验状态
 */
@property (nonatomic, strong) NSNumber * status;//Integer

/**
 * 操作人
 */
@property (nonatomic, copy) NSString * operatorUser;

/**
 * 发货数
 */
@property (nonatomic, strong) NSNumber * planQuantity;//Double
/**
 * 实发数
 */
@property (nonatomic, strong) NSNumber * actualQuantity;//Double

/**
 * 合格数量
 */
@property (nonatomic, strong) NSNumber * qualifiedQuantity;//Double

/**
 * 检验数
 */
@property (nonatomic, strong) NSNumber * checkQuantity;//Double

/**
 * 不合格数量
 */
@property (nonatomic, strong) NSNumber * unQualifiedQuantity;//Double

/**
 * 已退货数
 */
@property (nonatomic, strong) NSNumber * rejectedQuantity;//Double

/**
 * 已退货数 （页面输入）
 */
@property (nonatomic, strong) NSNumber * rejectedQuantityDyz;//Double


/**
 * 图片flag
 */
@property (nonatomic, strong) NSNumber * imgFlag;//Integer

/**
 * 合格品仓库
 */
@property (nonatomic, copy) NSString * qnWarehouseCode;

/**
 * 不合格品仓库
 */
@property (nonatomic, copy) NSString * noWarehouseCode;

/**
 * 订单数
 */
@property (nonatomic, strong) NSNumber * orderQuantity;//Double

/**
 * 生产订单号
 */
@property (nonatomic, copy) NSString * productionOrderNum;

/**
 * 生产子零件号
 */
@property (nonatomic, copy) NSString * productionLotNum;

/**
 * 备注
 */
@property (nonatomic, copy) NSString * remark;

/**
 * 仓库编号
 */
@property (nonatomic, copy) NSString * warehouseCode;

/**
 * 缺陷原因
 */
@property (nonatomic, strong) NSMutableArray <__kindof NSString *> * causeCodes;

@property (nonatomic, copy) NSString *productionControlNum;

@property (nonatomic, copy) NSString *modifyUser;


@end
