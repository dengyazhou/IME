//
//  IdentityBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/6/29.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdentityBean : NSObject

/**
 * 绑定用户id
 */
@property (nonatomic,copy) NSString * bindUserId;

/**
 * 用户id
 */
@property (nonatomic,copy) NSString * userId;

/**
 * 自增用户id
 */
@property (nonatomic,copy) NSString * ucenterId;

/**
 * 用户真实姓名
 */
@property (nonatomic,copy) NSString * realName;

/**
 * 用户名
 */
@property (nonatomic,copy) NSString *accountName;

/**
 * 用户类型(NORMAL, ENTERPRISE)
 */
@property (nonatomic,copy) NSString *userType;

/**
 * 用户状态 (ENABLE为可用)
 */
@property (nonatomic,copy) NSString *userStatus;

/**
 * 企业帐号等级(F: 主账号  C: 子账号)
 */
@property (nonatomic,copy) NSString * epAccLevel;

/**
 * 关联的企业id
 */
@property (nonatomic,copy) NSString *enterpriseId;

/**
 * 企业名
 */
@property (nonatomic,copy) NSString * enterpriseName;

/**
 * 员工姓名
 */
@property (nonatomic,copy) NSString * childAccount;

/**
 * 是否是财务管理员(0  1)
 */
@property (nonatomic,copy) NSString * hasFa;

/**
 * 是否是图纸云管理员(0  1)
 */
@property (nonatomic,copy) NSString * hasDr;

@property (nonatomic,copy) NSString * showName;

@end
