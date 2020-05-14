//
//  EnterpriseRelationTag.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/6/29.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import "EnterpriseRelation.h"
#import "TGSupplierTag.h"

@interface EnterpriseRelationTag : BaseEntity

@property (nonatomic,copy) NSString * enterpriseRelationTagId;

/**
 * 管家供应商
 */
@property (nonatomic,strong) EnterpriseRelation *enterpriseRelation;

/**
 * 管家供应商Id
 */
@property (nonatomic,copy) NSString * enterpriseRelationId;

/**
 * 管家供应商所属的采购商ID
 */
@property (nonatomic,copy) NSString * enterpriseInfoId;

/**
 * 标签
 */
@property (nonatomic,strong) TGSupplierTag *tag;

/**
 * 标签Id
 */
@property (nonatomic,copy) NSString * tagId;

/**
 * 搜索被动方企业名称（模糊查询）
 */
@property (nonatomic,copy) NSString * se_er__temporaryEnterpriseName;

/**
 * 搜索被动方企业所属地区（模糊查询）
 */
@property (nonatomic,copy) NSString * se_er__temporaryZoneStr;

@end
