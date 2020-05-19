//
//  EnterpriseInfoResBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/5/18.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnterpriseInfoResBean : NSObject

/**
 * 主键
 */
@property (nonatomic,copy) NSString * idd;

/**
 * 等级（默认99）
 * 用于非标首页推荐显示
 */
@property (nonatomic,strong) NSNumber * level;//Integer

/**
 * 是否是供应商（1-是；0-否）
 * 默认为0
 */
@property (nonatomic,strong) NSNumber * isSupplier;//Integer

/**
 * 是否是采购商（1-是；0-否）
 * 默认为1
 */
@property (nonatomic,strong) NSNumber * isPurchase;//Integer

/**
 * 企业id（ucenter企业ID）
 */
@property (nonatomic,copy) NSString * ucEpId;

/**
 * 企业名
 */
@property (nonatomic,copy) NSString * epName;

/**
 * 工艺类型(以‘|’分割)
 */
@property (nonatomic,copy) NSString * technologys;

/**
 * 企业英文名
 */
@property (nonatomic,copy) NSString * epEngName;

/**
 * 企业logo
 */
@property (nonatomic,copy) NSString * logoImg;

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
 * 联系邮箱
 */
@property (nonatomic,copy) NSString * emailAddress;

/**
 * 传真
 */
@property (nonatomic,copy) NSString * fax;

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
 * 三级地区名称组合
 */
@property (nonatomic,copy) NSString * zoneStr;

/**
 * 供应商账期
 */
@property (nonatomic,strong) NSNumber * accountPeriod;//Integer

/**
 * 采购商账期
 */
@property (nonatomic,strong) NSNumber * baccountPeriod;//Integer

/**
 * 最大子用户数量
 */
@property (nonatomic,strong) NSNumber * licenseNum;//Integer

/**
 * 是否开启透明工厂
 * 默认为0
 */
@property (nonatomic,strong) NSNumber * hasTrFactory;//Integer

/**
 * 最近使用的工艺（10个）
 * 注:以“.”分割
 */
@property (nonatomic,copy) NSString * recentTechnologys;

/**
 * 是否推荐（用于前端供应商展示）
 * 默认为0；1-推荐
 */
@property (nonatomic,strong) NSNumber * isRecommend;//Integer

/**
 * 供应商税率
 */
@property (nonatomic,strong) NSNumber * supplierTaxRate;//Double

/**
 * 供应商佣金
 * 0.01-0.99
 */
@property (nonatomic,strong) NSNumber * supplierCommision;//Double

/**
 * 非标管家
 * 1-是,0-否
 */
@property (nonatomic,strong) NSNumber * isAtg;//Integer

/**
 * 权重1
 * 报价及时性和配合度
 */
@property (nonatomic,strong) NSNumber * comWeight1;//Double

/**
 * 权重2
 * 报价专业性
 */
@property (nonatomic,strong) NSNumber * comWeight2;//Double

/**
 * 权重3
 * 加急事项的处理能力
 */
@property (nonatomic,strong) NSNumber * comWeight3;//Double

/**
 * 权重4
 * 交货及时率
 */
@property (nonatomic,strong) NSNumber * comWeight4;//Double

/**
 * 权重5
 * 产品质量
 */
@property (nonatomic,strong) NSNumber * comWeight5;//Double

/**
 * 是否最新入驻
 */
@property (nonatomic,strong) NSNumber * isNewest;//Integer

/**
 * 是否开启图纸云
 * 1-是；0-否（暂时默认为1）
 */
@property (nonatomic,strong) NSNumber * isDrawingCloud;//Integer

/**
 * 是否测试账号
 * 默认为0
 */
@property (nonatomic,strong) NSNumber * isTestAccount;//Integer

/**
 * 是否临时企业，默认为0
 */
@property (nonatomic,strong) NSNumber * isTemporary;//Integer

/**
 * 报价模板ＩＤ
 */
@property (nonatomic,copy) NSString * templateId;

/**
 * 是否开启私有化
 * 0-未开启（默认）；1-开启
 */
@property (nonatomic,strong) NSNumber * isPrivate;//Integer

/**
 * 是否开启询盘授盘审核
 * 0-未开启（默认）；1-开启
 */
@property (nonatomic,strong) NSNumber * isInquirySendConfirm;//Integer

/**
 * 企业当前使用的项目模板
 */
@property (nonatomic,copy) NSString * projectTemplateId;

/**
 * 是否开启ERP
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isOpenErp;//Integer

/**
 * 采购商是否开启24小时内供应商自动接盘功能
 */
@property (nonatomic,strong) NSNumber * isAutoSQ;//Integer

/**
 * 企业配置的项目号，以","分割
 */
@property (nonatomic,copy) NSString * ownProjectNames;

/**
 * 企业编号
 */
@property (nonatomic,copy) NSString * serialNo;

@end

NS_ASSUME_NONNULL_END
