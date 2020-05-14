//
//  Member.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class EnterpriseInfo;
@class Invitation;
#import "MemberCompetence.h"

@interface Member : BaseEntity

@property (nonatomic,copy) NSString *memberId;

/**
 * 拥有的角色
 */
@property (nonatomic,strong) NSMutableArray *roles; //放的是MemberRole对象

/**
 * 用户类型
 */
@property (nonatomic,copy) NSString *memberType; //F("工厂") C("员工")

/**
 * 启用状态
 */
@property (nonatomic,copy) NSString *disabledType;//E("启用") D("禁用")

/**
 * 企业信息
 */
@property (nonatomic,strong) EnterpriseInfo *enterpriseInfo;

/**
 * 企业ID
 */
@property (nonatomic,copy) NSString *manufacturerId;

/**
 * 用户中心注册用户ID
 */
@property (nonatomic,copy) NSString *userId;

/**
 * ucenter单点登录id
 */
@property (nonatomic,copy) NSString *ucenterId;

/**
 * 用户中心登录帐号
 */
@property (nonatomic,copy) NSString *accountName;

/**
 * 企业子用户名(当memberType为C时)
 */
@property (nonatomic,copy) NSString *childAccount;

/**
 * 用户类型
 * (NORMAL: 普通用户 , ENTERPRISE: 企业用户)
 */
@property (nonatomic,copy) NSString *userType;

/**
 * 用户状态(ENABLE: 启用 , DISABLE: 停用)
 */
@property (nonatomic,copy) NSString *userStatus;

/**
 * userType为ENTERPRISE时该字段有值
 * 企业账号等级(F: 企业主账号/企业超级管理员 , C: 企业子账号)
 */
@property (nonatomic,copy) NSString *enterpriseLevel;

/**
 * 头像文件url
 */
@property (nonatomic,copy) NSString *headImg;

/**
 * 头像源文件url
 */
@property (nonatomic,copy) NSString *headSourceImg;

/**
 * 真实姓名
 */
@property (nonatomic,copy) NSString *realName;

/**
 * 性别
 */
@property (nonatomic,copy) NSString *sex;

/**
 * 生日-年
 */
@property (nonatomic,strong) NSNumber *birthdayY;//Integer

/**
 * 生日-月
 */
@property (nonatomic,strong) NSNumber *birthdayM;//Integer

/**
 * 生日-日
 */
@property (nonatomic,strong) NSNumber *birthdayD;//Integer

/**
 * 省
 */
@property (nonatomic,copy) NSString *province;

/**
 * 市
 */
@property (nonatomic,copy) NSString *city;

/**
 * 备注,介绍
 */
@property (nonatomic,copy) NSString *remark;

/**
 * 公司
 */
@property (nonatomic,copy) NSString *company;

/**
 * 用户擅长领域
 */
@property (nonatomic,copy) NSString *expertField;

/**
 * 项目经历
 */
@property (nonatomic,copy) NSString *experience;

/**
 * 手机号
 */
@property (nonatomic,copy) NSString *phoneNumber;

/**
 * 邮箱
 */
@property (nonatomic,copy) NSString *emailAddress;

/**
 * 拥有的权限
 */
@property (nonatomic,strong) NSMutableArray < __kindof MemberCompetence * > *cpList;//MemberCompetence

/**
 * 用户中心登录帐号
 */
@property (nonatomic,copy) NSString * se_accountName;

/**
 * 查询企业名称
 */
@property (nonatomic,copy) NSString * sec_enterpriseName;

/**
 * 指定UC企业ID查询
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> *sei_e__enterpriseId;

/**
 * 指定UC用户ID
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_userId;

/**
 * 查询企业推荐等级
 */
@property (nonatomic,strong) NSNumber * e__level;//Integer

/**
 * 查询是否是供应商（1-是；0-否）
 */
@property (nonatomic,strong) NSNumber * e__isSupplier;//Integer

/**
 * 查询是否是采购商（1-是；0-否）
 */
@property (nonatomic,strong) NSNumber * e__isBuyer;//Integer

/**
 * 查询企业是否推荐（用于前端供应商展示）
 */
@property (nonatomic,strong) NSNumber * e__isRecommend;//Integer

/**
 * 查询供应商税率(默认0.16)
 * 0.16,0.03
 */
@property (nonatomic,strong) NSNumber * e__supplierTaxRate;//Double

/**
 * 查询供应商佣金(默认0.0026)
 * 0.0001-0.0099
 */
@property (nonatomic,strong) NSNumber * seb_e__supplierCommision;//Double

/**
 * 查询供应商佣金(默认0.0026)
 * 0.0001-0.0099
 */
@property (nonatomic,strong) NSNumber * see_e__supplierCommision;//Double

/**
 * 查询是否开启非标管家
 */
@property (nonatomic,strong) NSNumber *e__isAtg;//Integer

/**
 * 查询是否开启图纸云
 */
@property (nonatomic,strong) NSNumber * e__isDrawingCloud;//Integer

/**
 * 查询是否最新入驻
 */
@property (nonatomic,strong) NSNumber * e__isNewest;//Integer

/**
 * 上次登录时间
 */
@property (nonatomic,copy) NSString *lastLoginTime;//Date

/**
 * 此次登录时间
 */
@property (nonatomic,copy) NSString *nowLoginTime;//Date

/**
 * 临时字段，兼容APP，后期需删除
 */
@property (nonatomic,strong) NSNumber *e__isHtg;//Integer

//----------------20170411登录IP-BG----------
/**
 * 上次登录IP
 */
@property (nonatomic,copy) NSString * lastLoginIp;

/**
 * 当前登录IP
 */
@property (nonatomic,copy) NSString * nowLoginIp;
//------------------------end------------------

//----------------20170418UC用户绑定ID----------
/**
 * 绑定的用户ID
 */
@property (nonatomic,copy) NSString * bindUserId;
//----------------20170418UC用户绑定ID----------

/**
 * 用户身份列表
 */
@property (nonatomic,strong) NSMutableArray * associatedAccounts;//private List<String[]> associatedAccounts;

//---------------20170523无注册流程------------------

/**
 * 用户中心返还URL
 */
@property (nonatomic,copy) NSString * callBackUrl;

/**
 * 是否临时用户，默认为0
 */
@property (nonatomic,strong) NSNumber * isTemporary;//Integer

/**
 * 临时用户的手机号
 */
@property (nonatomic,copy) NSString * temporaryPhoneNumber;

/**
 * 临时用户的邮箱
 */
@property (nonatomic,copy) NSString * temporaryEmailAddress;

//---------------20170524无注册流程------------------

/**
 * 查询企业名（全匹配）
 */
@property (nonatomic,copy) NSString * e__enterpriseName;

/**
 * 用户登录状态：用于前端提示用
 * 1-成功；0-失败；-1-异常；-2-其他企业的用户登录
 */
@property (nonatomic,strong) NSNumber * loginStatus;//Integer

/**
 * 邀请事件
 */
@property (nonatomic,strong) Invitation * invitation;//Invitation

/**
 * 2017.7.13
 * 非标使用人：1-是；0-否
 */
@property (nonatomic,strong) NSNumber *hasEfeibiao;//Integer

/**
 * 是否需要查询模板
 */
@property (nonatomic,strong) NSNumber * isNeedTemplate;//Integer

@end
