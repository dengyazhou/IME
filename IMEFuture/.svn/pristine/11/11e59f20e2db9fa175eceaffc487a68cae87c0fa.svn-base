//
//  TgBalanceOrderItem.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/17.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import "TradeOrder.h"

@class TgBalanceOrder;

@interface TgBalanceOrderItem : BaseEntity

@property (nonatomic,copy) NSString * tgBalanceOrderItemId;

/**
 * 管家对账单
 */
@property (nonatomic,strong) TgBalanceOrder * tgBalanceOrder;

/**
 * 管家对账单Id
 */
@property (nonatomic,copy) NSString * tgBalanceOrderId;

/**
 * 订单
 */
@property (nonatomic,strong) TradeOrder * tradeOrder;

/**
 * 订单Id
 */
@property (nonatomic,copy) NSString * tradeOrderId;

/**
 * 订单初始金额
 */
@property (nonatomic,strong) NSNumber * orderAmount;//BigDecimal

/**
 * 订单累计增扣金额
 * 前端不可展示用，需从订单中获取
 */
@property (nonatomic,strong) NSNumber * changeAmount;//BigDecimal

/**
 * 对账金额
 * 前端不可展示用，需从订单中获取
 */
@property (nonatomic,strong) NSNumber * balanceAmount;//BigDecimal

/**
 * 查询多个主键
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_tgBalanceOrderItemId;//String []

@end
