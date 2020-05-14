//
//  MemberReqBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/16.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "BaseEntity.h"

#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface MemberReqBean : BaseEntity


/**
 * 用户主键
 */
@property(nonatomic,copy) NSString * idDYZ;

/**
 * 企业ID
 */
@property(nonatomic,copy) NSString * enterpriseInfoId;

/**
 * 用户中心注册用户ID
 */
@property(nonatomic,copy) NSString * userId;

/**
 * ucenter单点登录id
 */
@property(nonatomic,copy) NSString * ucId;

/**
 * 是否临时用户，默认为0
 */
@property(nonatomic,strong) NSNumber * isTemporary;

/**
 * 2017.7.13
 * 非标使用人：1-是；0-否
 */
@property(nonatomic,strong) NSNumber * hasEfeibiao;

/**
 * 是否需要查询模板
 */
@property(nonatomic,strong) NSNumber * isNeedTemplate;

/**
 * token超时时间
 */
@property(nonatomic,strong) NSNumber * jwtMillis;//Long

@end

NS_ASSUME_NONNULL_END
