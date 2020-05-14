//
//  EnterpriseBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/8/1.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnterpriseRefuseInfoBean.h"
#import "TechnologyBean.h"
#import "EnterpriseFileBean.h"
#import "EnterpriseAddressBean.h"
#import "EnterpriseSpecialAppInfoBean.h"

@interface EnterpriseBean : NSObject

/**
 * 企业id
 */
@property (nonatomic,copy) NSString * enterpriseId;

/**
 * 是否允许使用信用支付(1:允许. 0:不允许)
 */
@property (nonatomic,strong) NSNumber * canUseCredit;//Integer

/**
 * 企业状态(CONFIRM: 审核通过 , REFUSE: 审核拒绝, DISABLE: 停用)
 */
@property (nonatomic,copy) NSString * enterpriseStatus;

/**
 * 企业编号
 */
@property (nonatomic,copy) NSString * serialNo;

/**
 * 企业名
 */
@property (nonatomic,copy) NSString * enterpriseName;

/**
 * 企业英文名
 */
@property (nonatomic,copy) NSString * enterpriseEngName;


/**
 * 企业logo
 */
@property (nonatomic,copy) NSString * logoImg;

/**
 * 最大子用户数量
 */
@property (nonatomic,strong) NSNumber * licenseNum;//Integer

/**
 * 联系邮箱
 */
@property (nonatomic,copy) NSString * emailAddress;

/**
 * 传真
 */
@property (nonatomic,copy) NSString * fax;

/**
 * 企业性质
 */
@property (nonatomic,copy) NSString * enterpriseNature;

/**
 * 雇员数量(单位: 人)
 */
@property (nonatomic,copy) NSString * employeeNum;

/**
 * 工厂面积(单位: 平方米)
 */
@property (nonatomic,copy) NSString * factorySize;

/**
 * 年产值(单位万元)
 */
@property (nonatomic,copy) NSString * annualProductionValue;

/**
 * 年采购额(单位万元)
 */
@property (nonatomic,copy) NSString * annualProcurement;

/**
 * 企业成立年份
 */
@property (nonatomic,strong) NSNumber * foundTimeY;//Integer

/**
 * 行业类型
 */
@property (nonatomic,copy) NSString * industryType;

/**
 * 是否拥有进出口权(0: 没有, 1: 拥有)
 */
@property (nonatomic,strong) NSNumber * hasIEPower;//Integer

/**
 * 企业简介
 */
@property (nonatomic,copy) NSString * introduction;

/**
 * 制造能力
 */
@property (nonatomic,copy) NSString * manufacturingCapacity;

/**
 * 联系手机号
 */
@property (nonatomic,copy) NSString * phoneNumber;

/**
 * 联系座机号
 */
@property (nonatomic,copy) NSString * tel;

/**
 * 审核不通过原因
 */
@property (nonatomic,strong) NSMutableArray <__kindof EnterpriseRefuseInfoBean *> *refuseInfo;//EnterpriseRefuseInfoBean

/**
 * 认证信息
 */
@property (nonatomic,copy) NSString * renzheng;

/**
 * 省
 */
@property (nonatomic,copy) NSString * province;

/**
 * 市
 */
@property (nonatomic,copy) NSString * city;

/**
 * 区
 */
@property (nonatomic,copy) NSString * district;

/**
 * 产品关键字
 */
@property (nonatomic,copy) NSString * productKey;

/**
 * 设备关键字
 */
@property (nonatomic,copy) NSString * deviceKey;

//-------------------需要审核的相关信息-----------------------//

/**
 * 组织机构代码
 */
@property (nonatomic,copy) NSString * organizationCode;

/**
 * 法定代理人名
 */
@property (nonatomic,copy) NSString * legalRepresentative;

/**
 * 申请审核时提交的手机号
 */
@property (nonatomic,copy) NSString * applyPhoneNumber;

/**
 * 申请审核时提交的座机号
 */
@property (nonatomic,copy) NSString * applyTelNum;

/**
 * 申请审核的次数
 */
@property (nonatomic,strong) NSNumber * applyNum;//Integer

/**
 * 工艺类型
 */
@property (nonatomic,strong) NSMutableArray <__kindof TechnologyBean *> *technology;//TechnologyBean


/**
 * 企业文件列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof EnterpriseFileBean *> *enterpriseFiles;//EnterpriseFileBean

/**
 * 企业地址信息
 */
@property (nonatomic,strong) NSMutableArray <__kindof EnterpriseAddressBean *> *enterpriseAddress;//EnterpriseAddressBean

/**
 * 企业文件列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof EnterpriseSpecialAppInfoBean *> *enterpriseSpecialAppInfo;//EnterpriseSpecialAppInfoBean

@end
