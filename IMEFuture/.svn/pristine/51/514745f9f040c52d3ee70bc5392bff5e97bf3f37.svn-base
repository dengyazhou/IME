//
//  TgBalancePayOrder.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/17.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseEntity.h"

#import "EnterpriseInfo.h"
@class TgBalanceOrder;
#import "TgBalancePayOrderItem.h"



@interface TgBalancePayOrder : BaseEntity

@property (nonatomic,copy) NSString * tgBalancePayOrderId;

/**
 * 付款单明细
 */
@property (nonatomic,strong) NSMutableArray <__kindof TgBalancePayOrderItem *> * tgBalancePayOrderItems;//TgBalancePayOrderItem

/**
 * 管家对账单
 */
@property (nonatomic,strong) TgBalanceOrder * tgBalanceOrder;

/**
 * 管家对账单Id
 */
@property (nonatomic,copy) NSString *  tgBalanceOrderId;

/**
 * 对账单号
 */
@property (nonatomic,copy) NSString *  tgBalanceOrderCode;

/**
 * 发起对账的供应商企业
 */
@property (nonatomic,strong) EnterpriseInfo * supplierEp;

/**
 * 发起对账的供应商企业ID
 */
@property (nonatomic,copy) NSString * supplierManufacturerId;

/**
 * 被对账的采购商企业
 */
@property (nonatomic,strong) EnterpriseInfo * purchaseEp;

/**
 * 被对账的采购商企业ID
 */
@property (nonatomic,copy) NSString *  purchaseManufacturerId;

/**
 * 开票税率(订单上的供应商税率)
 */
@property (nonatomic,strong) NSNumber * supplierTaxRate;//Double

/**
 * 支付了多少期
 * 初始是0，每付一期加1
 */
@property (nonatomic,strong) NSNumber * periodAmount;//Integer

/**
 * 最大允许的期数
 */
@property (nonatomic,strong) NSNumber * maxPeriod;//Integer

/**
 * 付款方式
 */
@property (nonatomic,copy) NSString * payType;//TgBalancePayType

/**
 * 付款金额总计
 */
@property (nonatomic,strong) NSNumber * payAmount;//BigDecimal

/**
 * 是否需要财务审核
 */
@property (nonatomic,strong) NSNumber * needFinancialAudit;//Integer

/**
 * 付款方式的处理
 * 1-保存为默认；0-无需处理；-1-删除之前的默认设置
 */
@property (nonatomic,strong) NSNumber * sec_isDefault;//Integer

@end
