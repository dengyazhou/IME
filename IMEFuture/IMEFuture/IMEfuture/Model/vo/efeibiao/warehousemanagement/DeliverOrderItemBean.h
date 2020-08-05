//
//  DeliverOrderItemBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliverOrderItemBean : NSObject

/**
 * 订单项ID
 */
@property(nonatomic,copy) NSString * tradeOrderItemId;

/**
 * 发货数量
 */
@property(nonatomic,strong) NSNumber * deliverNum;

/**
 * 已收货数量
 */
@property(nonatomic,strong) NSNumber * receiveQuantity;

/**
 * 质检次品数量
 */
@property(nonatomic,strong) NSNumber * defectiveQuantity;

/**
 * 订单编号
 */
@property(nonatomic,copy) NSString * orderCode;

/**
 * 询盘号
 */
@property(nonatomic,copy) NSString * inquiryCode;

/**
 * 零件号
 */
@property(nonatomic,copy) NSString * partNumber;

/**
 * 规格
 */
@property(nonatomic,copy) NSString * specifications;

/**
 * 物料号
 */
@property(nonatomic,copy) NSString * materialNumber;

/**
 * 零件名称
 */
@property(nonatomic,copy) NSString * partName;

/**
 * 品牌
 */
@property(nonatomic,copy) NSString * brand;

/**
 * 物料描述
 */
@property(nonatomic,copy) NSString * materialDescription;

/**
 * 所属项目名(erp或图纸云)
 */
@property(nonatomic,copy) NSString * ownProjectName;

/**
 * 最小单位
 */
@property(nonatomic,copy) NSString * quantityUnit;//QuantityUnit

/**
 * 最小单位说明
 */
@property(nonatomic,copy) NSString * quantityUnitDesc;

/**
 * 交货日期
 */
@property(nonatomic,copy) NSString * deliveryTime;

/**
 * 采购组
 */
@property(nonatomic,copy) NSString * purchaseGroup;

/**
 * 是否有交付差异
 */
@property(nonatomic,strong) NSNumber * isDifference;

/**
 * 是否有质检异常
 */
@property(nonatomic,strong) NSNumber * isDefective;

/**
 * 有次品时质检单明细对应ID
 */
@property(nonatomic,copy) NSString * inspectItemId;

/**
 * 正常可发货数量
 */
@property(nonatomic,strong) NSNumber * canDeliverNum;

/**
 * 可补发货数量
 */
@property(nonatomic,strong) NSNumber * canReDeliverNum;

/**
 * 透明工厂物流备注
 */
@property(nonatomic,copy) NSString * remark;

/**
 * 发货明细ID
 */
@property(nonatomic,copy) NSString * deliverOrderItemId;


@property (nonatomic, copy) NSString * itemNo;


@property (nonatomic,copy) NSString *receivingArea ;//DYZ
@property (nonatomic,copy) NSString *receiveRemark;//DYZ
@property (nonatomic,strong) NSNumber *isMianJianDYZ;//DYZ



@end

NS_ASSUME_NONNULL_END
