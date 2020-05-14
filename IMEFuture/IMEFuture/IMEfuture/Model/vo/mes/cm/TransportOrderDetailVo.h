//
//  TransportOrderDetailVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/9.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransportOrderDetailVo : NSObject

/**
 * ID
 */
@property (nonatomic,strong) NSNumber * idDYZ;//long

/**
 * 运输单ID
 */
@property (nonatomic,strong) NSNumber * transportOrderId;//long

/**
 * 物料发货明细ID
 */
@property (nonatomic,strong) NSNumber * materialOutgoingOrderDetailId;//long

/**
 * 物料编号
 */
@property (nonatomic,copy) NSString * materialCode;

/**
 * 物料名称
 */
@property (nonatomic,copy) NSString * materialText;

/**
 * 实际发货数
 */
@property (nonatomic,strong) NSNumber * actualQuantity;//BigDecimal

/**
 * 收货数量
 */
@property (nonatomic,strong) NSNumber * deliveryQuantity;//BigDecimal

/**
 * 项目编号
 */
@property (nonatomic,copy) NSString * projectNum;

/**
 * 生产订单号
 */
@property (nonatomic,copy) NSString * productionOrderNum;

/**
 * 作业工单号
 */
@property (nonatomic,copy) NSString * productionControlNum;

@property (nonatomic,copy) NSString * siteCode;

@end

NS_ASSUME_NONNULL_END
