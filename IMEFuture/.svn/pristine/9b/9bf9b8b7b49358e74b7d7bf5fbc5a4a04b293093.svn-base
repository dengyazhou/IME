//
//  EnterpriseComment.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2016/10/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class TradeOrder;

@interface EnterpriseComment : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * epCommentId;

/**
 * 评价月
 */
@property (nonatomic,strong) NSNumber * coMonth;//Integer

/**
 * 评价年
 */
@property (nonatomic,strong) NSNumber * coYear;//Integer

/**
 * 评价企业Id（主键）
 */
@property (nonatomic,copy) NSString * srManufacturerId;

/**
 * 评价企业名
 */
@property (nonatomic,copy) NSString * srEnterpriseName;

/**
 * 评价用户Id
 */
@property (nonatomic,copy) NSString * srMemberId;

/**
 * 被评价企业Id（主键）
 */
@property (nonatomic,copy) NSString * trManufacturerId;

/**
 * 被评价企业名
 */
@property (nonatomic,copy) NSString * trEnterpriseName;

/**
 * 评价方类型
 * 暂时默认为PURCHASE：采购商评价
 */
//SUPPLIER("供应商评价"),
//PURCHASE("采购商评价");
@property (nonatomic,copy) NSString * commentType;//CommentType

/**
 * 评价类型（0-月度评价；1-订单评价）
 */
@property (nonatomic,strong) NSNumber * commentStatus;//Integer

/**
 * 订单评价内容/采购类评价
 */
@property (nonatomic,copy) NSString * content;

/**
 * 技术类评价
 */
@property (nonatomic,copy) NSString * content1;

/**
 *  质量类评价
 */
@property (nonatomic,copy) NSString * content2;

/**
 * 评价分值1
 * 报价及时性和配合度（采购类）
 */
@property (nonatomic,strong) NSNumber * puScore;//Double

/**
 * 评价分值2
 * 报价专业性(采购类)
 */
@property (nonatomic,strong) NSNumber * puScore1;//Double

/**
 * 评价分值3
 * 加急事项的处理能力 (采购类)
 */
@property (nonatomic,strong) NSNumber * puScore2;//Double

/**
 * 评价分值4
 * 交货及时率 (采购类)
 */
@property (nonatomic,strong) NSNumber * puScore3;//Double

/**
 * 评价分值5
 * 产品质量(质量类)
 */
@property (nonatomic,strong) NSNumber * quScore1;//Double

/**
 * 平均分值
 */
@property (nonatomic,strong) NSNumber * averageScore;//Double

/**
 * 订单ID
 */
@property (nonatomic,copy) NSString * orderId;

/**
 * 订单编号
 */
@property (nonatomic,copy) NSString * orderCode;

/**
 * 订单标题
 */
@property (nonatomic,copy) NSString * orderTitle;

/**
 * 订单创建时间
 */
@property (nonatomic,copy) NSString * orderTime;//Date

/**
 * 订单实体
 */
@property (nonatomic,strong) TradeOrder * order;

@end
