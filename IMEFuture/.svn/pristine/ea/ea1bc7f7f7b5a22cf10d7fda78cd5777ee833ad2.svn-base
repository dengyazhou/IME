//
//  ChangeRecordItem.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/17.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import "ChangeRecord.h"
#import "TradeOrderItem.h"

@interface ChangeRecordItem : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * changeRecordItemId;

/**
 * 订单项ID
 */
@property (nonatomic,copy) NSString *  tradeOrderItemId;

/**
 * 变动记录
 */
@property (nonatomic,strong) ChangeRecord * changeRecord;

/**
 * 记录ID
 */
@property (nonatomic,copy) NSString *  changeRecordId;

/**
 * 相关订单项
 */
@property (nonatomic,strong) TradeOrderItem * tradeOrderItem;

/**
 * 增扣金额
 */
@property (nonatomic,strong) NSNumber * changeAmount;//BigDecimal

/**
 * 变更类型
 */
@property (nonatomic,copy) NSString * changeType;//ChangeType

/**
 * 备注
 */
@property (nonatomic,copy) NSString *  remark;

@end
