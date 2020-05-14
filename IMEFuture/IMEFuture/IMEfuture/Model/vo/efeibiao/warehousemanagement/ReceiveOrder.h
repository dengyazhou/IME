//
//  ReceiveOrder.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import <MJExtension.h>

#import "ReceiveItemBean.h"
#import "DeliverOrderDetailBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveOrder : BaseEntity

/**
 * 主键
 */
@property(nonatomic,copy) NSString * receiveOrderId;

/**
 * 收货单明细
 */
@property(nonatomic,strong) NSMutableArray <__kindof ReceiveItemBean *> * receiveOrderItems;

/**
 * 关联的发货单
 */
@property(nonatomic,strong) DeliverOrderDetailBean * deliverOrder;

/**
 * 质检单ID
 */
@property(nonatomic,copy) NSString * inspectOrderId;

/**
 * 关联的发货单ID
 */
@property(nonatomic,copy) NSString * deliverOrderId;

/**
 * 制单人姓名
 */
@property(nonatomic,copy) NSString * childAccount;

/**
 * 单据类型
 */
@property(nonatomic,copy) NSString * receiveOrderStatus;//ReceiveOrderStatus

/**
 * 单据类型描述
 */
@property(nonatomic,copy) NSString * receiveOrderStatusDesc;

/**
 * 是否需要重新推送通知 0-否(默认)；1-是（需要重新推送）
 */
@property(nonatomic,strong) NSNumber * isNeedReNotify;

/**
 * 该询盘创建时采购商企业是否开启了ERP对接
 */
@property(nonatomic,strong) NSNumber * isOpenErp;

/**
 * 收货单号
 */
@property(nonatomic,copy) NSString * receiveCode;

/**
 * 收货时间
 */
@property(nonatomic,copy) NSString *  receiveTime;//Date

/**
 * 已收货零件项
 */
@property(nonatomic,strong) NSNumber * receiveItems;

/**
 * 已收货零件总数
 */
@property(nonatomic,strong) NSNumber * receiveItemNums;

/**
 * erp收货单号 凭证号等外部系统的单据对应号
 */
@property(nonatomic,copy) NSString * erpReceiveCode;

/**
 * 订单项修改过的次数 多行一起修改算一次，同行再次修改再加一次
 */
@property(nonatomic,strong) NSNumber * editNum;

@end

NS_ASSUME_NONNULL_END
