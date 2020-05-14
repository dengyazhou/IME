//
//  Comment.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

//#import <Foundation/Foundation.h>

#import "BaseEntity.h"

@interface Comment : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * commentId;

/**
 * 被评价企业id（ucenter企业ID）
 */
@property (nonatomic,copy) NSString * targetEnterpriseId;

/**
 * 被评价企业名
 */
@property (nonatomic,copy) NSString * targetEnterpriseName;

/**
 * 订单ID
 */
@property (nonatomic,copy) NSString * orderId;

/**
 * 订单标题
 */
@property (nonatomic,copy) NSString * orderTitle;

/**
 * 订单编号
 */
@property (nonatomic,copy) NSString * orderCode;

/**
 * 评价类型
 */
@property (nonatomic,copy) NSString * commentType;//SUPPLIER("供应商评价"),PURCHASE("采购商评价");

/**
 * 评价内容
 */
@property (nonatomic,copy) NSString * content;

/**
 * 供应商类型综合评分
 */
@property (nonatomic,strong) NSNumber * supplierSyntheticScore;//Double

/**
 * 质量管控
 */
@property (nonatomic,strong) NSNumber * suStart1;//Double

/**
 * 准时交货
 */
@property (nonatomic,strong) NSNumber * suStart2;//Double

/**
 * 服务水平
 */
@property (nonatomic,strong) NSNumber * suStart3;//Double

/**
 * 采购商类型综合评分
 */
@property (nonatomic,strong) NSNumber * purchaseSyntheticScore;//Double

/**
 * 技术支持
 */
@property (nonatomic,strong) NSNumber * buStart1;//Double

/**
 * 响应速度
 */
@property (nonatomic,strong) NSNumber * buStart2;//Double

/**
 * 价格敏感
 */
@property (nonatomic,strong) NSNumber * buStart3;//Double

/**
 * 评价企业id（ucenter企业ID）
 */
@property (nonatomic,copy) NSString * sourceEnterpriseId;

/**
 * 评价企业名
 */
@property (nonatomic,copy) NSString * sourceEnterpriseName;

/**
 * 评价用户Id
 */
@property (nonatomic,copy) NSString * sourceMemberId;

@end
