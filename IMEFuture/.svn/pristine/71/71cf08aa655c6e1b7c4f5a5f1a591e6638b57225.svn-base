//
//  TpfOrderInfoBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/11.
//  Copyright © 2019 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TpfConfirmInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface TpfOrderInfoBean : NSObject

/**
 * 主键
 */
@property (nonatomic,copy) NSString * tradeOrderItemId;
/**
 * 订单项行号
 */
@property (nonatomic,strong) NSNumber * itemNo;//Integer
/**
 * 询盘序号
 */
@property (nonatomic,strong) NSNumber * inuiryOrderItemNo;//Integer
/**
 * 零件号
 */
@property (nonatomic,copy) NSString * partNumber;
/**
 * 零件名称
 */
@property (nonatomic,copy) NSString * partName;
/**
 * 物料号
 */
@property (nonatomic,copy) NSString * materialNumber;
/**
 * 品牌
 */
@property (nonatomic,copy) NSString * brand;
/**
 * 一级材质名
 */
@property (nonatomic,copy) NSString * materialName1;
/**
 * 二级材质名
 */
@property (nonatomic,copy) NSString * materialName2;
/**
 * 工艺/工序
 */
@property (nonatomic,copy) NSString * tags;
/**
 * 物料描述
 */
@property (nonatomic,copy) NSString * materialDescription;
//-----------------------------------tpf info-----------------------
/**
 * 计划数量
 */
@property (nonatomic,copy) NSString * plannedQuantity;
/**
 * 完工数量
 */
@property (nonatomic,copy) NSString * completedQuantity;
/**
 * 排产量
 */
@property (nonatomic,strong) NSNumber * releasedQuantity;//Integer
/**
 * 生产批次信息
 */
@property (nonatomic,strong) NSMutableArray * confirmInfos;//TpfConfirmInfo

@end

NS_ASSUME_NONNULL_END
