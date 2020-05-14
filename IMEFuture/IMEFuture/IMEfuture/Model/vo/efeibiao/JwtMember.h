//
//  JwtMember.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/11/16.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JwtMember : NSObject

@property (nonatomic,copy) NSString * memberId;

/**
 * 用户类型
 */
@property (nonatomic,copy) NSString * memberType;//MemberType

/**
 * 企业ID
 */
@property (nonatomic,copy) NSString *  manufacturerId;

/**
 * 企业id（ucenter企业ID）
 */
@property (nonatomic,copy) NSString * enterpriseId;

/**
 * 企业名
 */
@property (nonatomic,copy) NSString *  enterpriseName;

/**
 * 用户中心注册用户ID
 */
@property (nonatomic,copy) NSString *  userId;

/**
 * ucenter单点登录id
 */
@property (nonatomic,copy) NSString *  ucenterId;

/**
 * 企业子用户名(当memberType为C时)
 */
@property (nonatomic,copy) NSString *  childAccount;

/**
 * 用户类型
 * (NORMAL: 普通用户 , ENTERPRISE: 企业用户)
 */
@property (nonatomic,copy) NSString *  userType;

/**
 * userType为ENTERPRISE时该字段有值
 * 企业账号等级(F: 企业主账号/企业超级管理员 , C: 企业子账号)
 */
@property (nonatomic,copy) NSString *  enterpriseLevel;

/**
 * 真实姓名
 */
@property (nonatomic,copy) NSString *  realName;

/**
 * 用户身份列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * associatedAccounts;//List<String[]> associatedAccounts;

@end
