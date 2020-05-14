//
//  UserBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/8/1.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EnterpriseBean.h"

@interface UserBean : NSObject

/**
 * 是否是测试用户(0,1)
 */
@property (nonatomic,strong) NSNumber * isTest;//Integer

/**
 * 创建时间(yyyy-MM-dd HH:mm)
 */
@property (nonatomic,copy) NSString * createTime;


/**
 * 是否允许企业支付
 */
@property (nonatomic,strong) NSNumber * canEpPay;//Integer

/**
 * 是否是导入
 */
@property (nonatomic,strong) NSNumber * isImport;//Integer

/**
 * 用户中心id
 */
@property (nonatomic,copy) NSString * userId;

/**
 * ucenter单点登录id
 */
@property (nonatomic,strong) NSNumber * ucenterId;//Integer

/**
 * 用户状态(ENABLE: 启用 , DISABLE: 停用)
 */
@property (nonatomic,copy) NSString * userStatus;

/**
 * 用户类型(NORMAL: 普通用户 , ENTERPRISE: 企业用户)
 */
@property (nonatomic,copy) NSString * userType;

/**
 * userType为ENTERPRISE时该字段有值
 * 企业账号等级(F: 企业主账号/企业超级管理员 , C: 企业子账号)
 */
@property (nonatomic,copy) NSString * enterpriseLevel;

/**
 * enterpriseLevel为C时该字段有值
 * 企业子用户名(同企业下该值唯一,不同企业下该值可能出现重复)
 */
@property (nonatomic,copy) NSString * childAccount;

/**
 * userType为ENTERPRISE时该字段有值
 * 所属企业信息(json字符串)
 */
@property (nonatomic,strong) EnterpriseBean *enterpriseInfo;

/**
 * 账号
 */
@property (nonatomic,copy) NSString * accountName;

/**
 * 头像文件url
 */
@property (nonatomic,copy) NSString * headImg;

/**
 * 头像源文件url
 */
@property (nonatomic,copy) NSString * headSourceImg;

/**
 * 真实姓名
 */
@property (nonatomic,copy) NSString * realName;

/**
 * 性别
 */
@property (nonatomic,copy) NSString * sex;

/**
 * 生日-年
 */
@property (nonatomic,strong) NSNumber * birthdayY;//Integer

/**
 * 生日-月
 */
@property (nonatomic,strong) NSNumber * birthdayM;//Integer

/**
 * 生日-日
 */
@property (nonatomic,strong) NSNumber * birthdayD;//Integer

/**
 * 省
 */
@property (nonatomic,copy) NSString * province;

/**
 * 市
 */
@property (nonatomic,copy) NSString * city;

/**
 * 备注,介绍
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 公司
 */
@property (nonatomic,copy) NSString * company;

/**
 * 用户擅长领域
 */
@property (nonatomic,copy) NSString * expertField;

/**
 * 项目经历
 */
@property (nonatomic,copy) NSString * experience;

/**
 * 手机号
 */
@property (nonatomic,copy) NSString * phoneNumber;

/**
 * 邮箱
 */
@property (nonatomic,copy) NSString * emailAddress;

/**
 * 是否是审批人(一个企业只能有一个员工是审批人)
 */
@property (nonatomic,strong) NSNumber * isApprove;//Integer

/**
 * 是否是财务管理员(0:无, 1:有, 2:待审核)
 */
@property (nonatomic,strong) NSNumber * hasFa;//Integer

/**
 * 是否是图纸云使用人(0:无, 1:有, 2:待审核)
 */
@property (nonatomic,strong) NSNumber * hasDr;//Integer

/**
 * 是否是非标使用人(0:无, 1:有, 2:待审核)
 */
@property (nonatomic,strong) NSNumber * hasEfeibiao;//Integer

/**
 * 是否是透明工厂使用人(0:无, 1:有, 2:待审核)
 */
@property (nonatomic,strong) NSNumber * hasTmgc;//Integer

/**
 * 是否是设备备件云使用人(0:无, 1:有, 2:待审核)
 */
@property (nonatomic,strong) NSNumber * hasSbbjy;//Integer

@property (nonatomic,strong) NSData *file;

@end
