//
//  Person.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

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
 * userType为ENTERPRISE时该字段有值 企业账号等级(F: 企业主账号/企业超级管理员 , C: 企业子账号)
 */
@property (nonatomic,copy) NSString * enterpriseLevel;

/**
 * enterpriseLevel为C时该字段有值 企业子用户名(同企业下该值唯一,不同企业下该值可能出现重复)
 */
@property (nonatomic,copy) NSString * childAccount;

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
@property (nonatomic,strong) NSNumber * birthdayY;

/**
 * 生日-月
 */
@property (nonatomic,strong) NSNumber * birthdayM;

/**
 * 生日-日
 */
@property (nonatomic,strong) NSNumber * birthdayD;

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

@end
