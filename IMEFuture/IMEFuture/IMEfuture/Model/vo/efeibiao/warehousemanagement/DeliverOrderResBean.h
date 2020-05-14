//
//  DeliverOrderResBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliverOrderResBean : NSObject

/**
 * 单据类型 S("发货单"),SR("补发货单"),SC("发货撤销单")
 */
@property(nonatomic,copy) NSString * orderOperateType;

/**
 * 状态 WAITRECEIVE("待收货"),WAITINSPECT("待质检"),COMPLETED("已完成")
 */
@property(nonatomic,copy) NSString * warehouseOrderStatus;

/**
 * 状态说明
 */
@property(nonatomic,copy) NSString * warehouseOrderStatusDesc;

/**
 * 发货单号
 */
@property(nonatomic,copy) NSString * deliverCode;

/**
 * 送货单号
 */
@property(nonatomic,copy) NSString * deliverNumber;

/**
 * 询盘号,20个，以","分割
 */
@property(nonatomic,copy) NSString * inquiryCodes;

/**
 * 订单号,20个，以","分割
 */
@property(nonatomic,copy) NSString * orderCodes;

/**
 * 采购商
 */
@property(nonatomic,copy) NSString * purchaseEpName;

/**
 * 零件项数
 */
@property(nonatomic,strong) NSNumber * itemNum;

/**
 * 零件总数
 */
@property(nonatomic,strong) NSNumber * itemQuantity;

/**
 * 送货方式说明
 */
@property(nonatomic,copy) NSString * deliveryMethodsDesc;

/**
 * 发货日期
 */
@property(nonatomic,copy) NSString * deliveryTime;

/**
 * 发货操作人
 */
@property(nonatomic,copy) NSString * memberName;

/**
 * 创建人类型 0-供应商；1-采购商
 */
@property(nonatomic,strong) NSNumber * createMemberType;

/**
 * 是否有交付差异
 */
@property(nonatomic,strong) NSNumber * isDifference;

/**
 * 是否已查看交付差异
 */
@property(nonatomic,strong) NSNumber * isCheckDifference;

/**
 * 是否有质检异常
 */
@property(nonatomic,strong) NSNumber * isDefective;

/**
 * 是否已查看质检异常
 */
@property(nonatomic,strong) NSNumber * isCheckDefective;

/**
 * 发货单主键
 */
@property(nonatomic,copy) NSString * deliverOrderId;

/**
 * 是否收货完成 1-是；0-否
 */
@property(nonatomic,strong) NSNumber * isReceive;

/**
 * 供应商公司名
 */
@property(nonatomic,copy) NSString * supplierEpName;

/**
 * 收货单ID
 */
@property(nonatomic,copy) NSString * receiveOrderId;

@end

NS_ASSUME_NONNULL_END
