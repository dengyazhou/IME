//
//  DeliverOrderReqBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliverOrderReqBean : NSObject

/**
 * 发货单主键
 */
@property(nonatomic,copy) NSString * deliverOrderId;

/**
 * 发货单号
 */
@property(nonatomic,copy) NSString * deliverCode;

/**
 * 询盘号
 */
@property(nonatomic,copy) NSString * inquiryCode;

/**
 * 收货人名
 */
@property(nonatomic,copy) NSString * receiveMemberName;

/**
 * 质检人名
 */
@property(nonatomic,copy) NSString * inspectMemberName;

/**
 * 订单号
 */
@property(nonatomic,copy) NSString * orderCode;

/**
 * 采购商
 */
@property(nonatomic,copy) NSString * purchaseEpName;

/**
 * 供应商
 */
@property(nonatomic,copy) NSString * supplierEpName;

/**
 * 状态（枚举类型）
 * WAITRECEIVE("待收货"),WAITINSPECT("待质检"),COMPLETED("已完成"),DIF("交付异常")，DEF("质检异常");
 */
@property(nonatomic,copy) NSString * warehouseOrderStatus;

/**
 * 送货方式（枚举类型） SUPPLIER("供应商送货"),LOGISTICS("快递物流"),SELF("自提")
 */
@property(nonatomic,copy) NSString * deliveryMethods;

/**
 * 发货日期开始时间
 */
@property(nonatomic,copy) NSString * seb_deliveryTime;

/**
 * 发货日期结束时间
 */
@property(nonatomic,copy) NSString * see_deliveryTime;

/**
 * 发货日期开始时间
 */
@property(nonatomic,copy) NSString * seb_deliveryTm;//Date

/**
 * 发货日期结束时间
 */
@property(nonatomic,copy) NSString * see_deliveryTm;//Date

/**
 * 发货操作人 （如果是作为质检单条件 此条件为质检操作人）
 */
@property(nonatomic,copy) NSString * memberName;

/**
 * 是否补发货 0-否，1-是
 */
@property(nonatomic,strong) NSNumber * isRe;

/**
 * 是否筛选查询 0-否；1-是
 */
@property(nonatomic,strong) NSNumber * isScreen;

/**
 * 收货单号
 */
@property(nonatomic,copy) NSString * receiveCode;
/**
 * 收货时间
 */
@property(nonatomic,copy) NSString * seb_receiveTime;//Date
@property(nonatomic,copy) NSString * see_receiveTime;//Date
/**
 * 是否是补发货
 */
@property(nonatomic,copy) NSString * orderOperateType;//OrderOperateType
/**
 * 质检单号单号
 */
@property(nonatomic,copy) NSString * inspectCode;
/**
 * 质检时间
 */
@property(nonatomic,copy) NSString * seb_inspectTime;//Date
@property(nonatomic,copy) NSString * see_inspectTime;//Date

/**
 * 是否显示冲销记录
 */
@property(nonatomic,copy) NSString * isEditItem;
/**
 * 对接状态 0成功 1失败
 */
@property(nonatomic,strong) NSNumber * dockingState;
/**
 * 已收货 未收货
 */
@property(nonatomic,copy) NSString * receiveOrderStatus;//ReceiveOrderStatus

/**
 * 是否收货完成 1-完成；0-未完成
 */
@property(nonatomic,strong) NSNumber * isReceive;

/**
 * 是否可以继续冲销 1-可以；0-不可以
 */
@property(nonatomic,strong) NSNumber * canEdit;

/**
 * 创建人类型 0-供应商；1-采购商
 */
@property(nonatomic,strong) NSNumber * createMemberType;


@property (nonatomic,copy) NSString * deliverOrderCode;

@property (nonatomic, copy) NSString *upId;//暂时放在DeliverOrderReqBean这个类里面，自己添加的。为inspect/qReasonList这个接口使用

@end

NS_ASSUME_NONNULL_END
