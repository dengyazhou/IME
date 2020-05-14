//
//  ReceiveItemBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJExtension.h>
@class ReceiveBean;
#import "DeliverOrderItemBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveItemBean : NSObject

/**
 * 主键
 */
@property(nonatomic,copy) NSString * receiveOrderItemId;

/**
 * 收货单表头
 */
@property (nonatomic,retain) ReceiveBean * receiveOrder;

/**
 * 收货单表头ID
 */
@property(nonatomic,copy) NSString * receiveOrderId;

/**
 * 发货单表体
 */
@property (nonatomic,strong) DeliverOrderItemBean *deliverOrderItem;

/**
 * 发货单表体ID
 */
@property(nonatomic,copy) NSString * deliverOrderItemId;

/**
 * 初始收货数量 冲销数量
 */
@property(nonatomic,strong) NSNumber * DYZinitReceiveNum;

/**
 * 当前收货数量
 */
@property(nonatomic,strong) NSNumber * receiveNum;

/**
 * 是否是被修改的行项
 */
@property(nonatomic,strong) NSNumber * isEditItem;

/**
 * 修改凭证号 CX+年月日+3位随机数
 */
@property(nonatomic,copy) NSString * editCode;

/**
 * 修改时间
 */
@property(nonatomic,copy) NSString * editTime;//Date

/**
 * 修改人ID
 */
@property(nonatomic,copy) NSString * editMemberId;

/**
 * 修改人姓名
 */
@property(nonatomic,copy) NSString * editChildAccount;

/**
 * 修改原因
 */
@property(nonatomic,copy) NSString * editReson;

/**
 * 收货区
 */
@property(nonatomic,copy) NSString * receivingArea;

/**
 * 是否免检
 */
@property(nonatomic,strong) NSNumber * isMianjian;

/**
 * 收货备注
 */
@property(nonatomic,copy) NSString * receiveRemark;

@end

NS_ASSUME_NONNULL_END
