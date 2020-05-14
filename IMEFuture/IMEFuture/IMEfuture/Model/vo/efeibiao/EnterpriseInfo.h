//
//  EnterpriseInfo.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class EnterpriseRelation;


@class QuotationTemplate;

@interface EnterpriseInfo : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString *manufacturerId;

/**
 * 是否是供应商（1-是；0-否）
 * 默认为0
 */
@property (nonatomic,strong) NSNumber *isSupplier;//Integer

/**
 * 是否是采购商（1-是；0-否）
 * 默认为1
 */
@property (nonatomic,strong) NSNumber *isBuyer;//Integer

/**
 * 是否需要推送ERP
 */
@property (nonatomic,strong) NSNumber * needPushErp;//Integer

/**
 * 企业id（ucenter企业ID）
 */
@property (nonatomic,copy) NSString *enterpriseId;

/**
 * 企业编号
 */
@property (nonatomic,copy) NSString *serialNo;

/**
 * 企业名
 */
@property (nonatomic,copy) NSString *enterpriseName;

/**
 * 工艺类型(以‘|’分割)
 */
@property (nonatomic,copy) NSString *technologys;

/**
 * 企业英文名
 */
@property (nonatomic,copy) NSString *enterpriseEngName;

/**
 * 企业logo
 */
@property (nonatomic,copy) NSString *logoImg;

/**
 * 企业性质
 */
@property (nonatomic,copy) NSString *enterpriseNature;

/**
 * 雇员数量(单位: 人)
 */
@property (nonatomic,copy) NSString *employeeNum;

/**
 * 工厂面积(单位: 平方米)
 */
@property (nonatomic,copy) NSString *factorySize;

/**
 * 年产值(单位万元)
 */
@property (nonatomic,copy) NSString *annualProductionValue;

/**
 * 年采购额(单位万元)
 */
@property (nonatomic,copy) NSString *annualProcurement;

/**
 * 企业成立年份
 */
@property (nonatomic,strong) NSNumber *foundTimeY;//Integer

/**
 * 行业类型
 */
@property (nonatomic,copy) NSString *industryType;

/**
 * 是否拥有进出口权(0: 没有, 1: 拥有)
 */
@property (nonatomic,strong) NSNumber *hasIEPower;//Integer

/**
 * 联系邮箱
 */
@property (nonatomic,copy) NSString *emailAddress;

/**
 * 传真
 */
@property (nonatomic,copy) NSString *fax;

/**
 * 企业简介
 */
@property (nonatomic,copy) NSString *introduction;

/**
 * 制造能力
 */
@property (nonatomic,copy) NSString *manufacturingCapacity;

/**
 * 联系手机号
 */
@property (nonatomic,copy) NSString *phoneNumber;

/**
 * 联系座机号
 */
@property (nonatomic,copy) NSString *tel;

/**
 * 认证信息
 */
@property (nonatomic,copy) NSString *renzheng;

/**
 * 省
 */
@property (nonatomic,copy) NSString *province;

/**
 * 市
 */
@property (nonatomic,copy) NSString *city;

/**
 * 区
 */
@property (nonatomic,copy) NSString *district;

/**
 * 三级地区名称组合
 */
@property (nonatomic,copy) NSString *zoneStr;

/**
 * 供应商评分星数1
 */
@property (nonatomic,strong) NSNumber *suStart1;//Double

/**
 * 供应商评分星数2
 */
@property (nonatomic,strong) NSNumber *suStart2;//Double

/**
 * 供应商评分星数3
 */
@property (nonatomic,strong) NSNumber *suStart3;//Double

/**
 * 供应商评分平均星数（（1+2+3）/人数suStarMember）
 * 取整
 */
@property (nonatomic,strong) NSNumber *suStartLevel;//Double

/**
 * 供应商评分人数
 */
@property (nonatomic,strong) NSNumber *suStarMember;//Integer

/**
 * 采购商评分星数1
 */
@property (nonatomic,strong) NSNumber *buStart1;//Double

/**
 * 采购商评分星数2
 */
@property (nonatomic,strong) NSNumber *buStart2;//Double

/**
 * 采购商评分星数3
 */
@property (nonatomic,strong) NSNumber *buStart3;//Double

/**
 * 采购商平均星数
 */
@property (nonatomic,strong) NSNumber *buStartLevel;//Double

/**
 * 采购商评分人数
 */
@property (nonatomic,strong) NSNumber *buStarMember;//Integer

/**
 * 供应商账期
 */
@property (nonatomic,strong) NSNumber *accountPeriod;//Integer

/**
 * 采购商账期
 */
@property (nonatomic,strong) NSNumber *baccountPeriod;//Integer

/**
 * 关联的企业关系信息（关联主动方）
 */
@property (nonatomic,strong) NSMutableArray <__kindof EnterpriseRelation *> *relations;//EnterpriseRelation

/**
 * 企业状态(CONFIRM: 审核通过 , REFUSE: 审核拒绝, DISABLE: 停用)
 */
@property (nonatomic,copy) NSString *enterpriseStatus;

/**
 * 最大子用户数量
 */
@property (nonatomic,strong) NSNumber *licenseNum;//Integer

/**
 * 成功订单数量
 */
@property (nonatomic,strong) NSNumber *orderNum;//Long

/**
 * 采购成功订单（临时字段）
 */
@property (nonatomic,strong) NSNumber *borderNum;//Long

/**
 * 查询标签
 */
@property (nonatomic,strong) NSMutableArray <__kindof NSString *> *sec_technologys;//private List<String> sec_technologys;

/**
 * 是否开启透明工厂
 * 默认为0
 */
@property (nonatomic,strong) NSNumber *hasTrFactory;//Integer

/**
 * 查询是否已认证（资质）
 */
@property (nonatomic,strong) NSNumber *sec_renzheng;//Integer

/**
 * 查询开启的APP
 */
@property (nonatomic,strong) NSMutableArray *sec_specialApp;//private String[] sec_specialApp;

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
 * 0.16,0.03
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

//----------161027----企业评价权重（百分比）------------------
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
//--------------------企业评价权重（百分比）------------------

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
 * 企业名称模糊查询
 */
@property (nonatomic,copy) NSString * se_enterpriseName;

/**
 * 过滤指定企业
 */
@property (nonatomic,copy) NSString * sec_notManufacturerId;

/**
 * 临时字段，为APP兼容保留，后期需删除
 */
@property (nonatomic,strong) NSNumber *  isHtg;//Integer

/**
 * 是否测试账号
 * 默认为0
 */
@property (nonatomic,strong) NSNumber *  isTestAccount;//Integer

//---------------20170524无注册流程------------------
/**
 * 是否临时企业，默认为0
 */
@property (nonatomic,strong) NSNumber *  isTemporary;//Integer

//---------------20170524无注册流程------------------

/**
 * 查询供应商或临时企业
 */
@property (nonatomic,strong) NSNumber *  sec_supplierOrTemporary;//Integer

//------------------------------------报价模板相关2017.9.7--------------------------------------
/**
 * 报价模板ＩＤ
 */
@property (nonatomic,copy) NSString * templateId;

/**
 * 报价模板
 */
@property (nonatomic,strong) QuotationTemplate * quotationTemplate;
//------------------------------------报价模板相关2017.9.7END------------------------------------

/**
 * 订单要求
 */
@property (nonatomic,copy) NSString * tradeOrderRemark;

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
 *
 */
@property (nonatomic,strong) NSNumber * isAutoSQ;//Integer
/**
 * 是否开启ERP
 * 0-否；1-是
 */
@property (nonatomic,strong) NSNumber * isOpenErp;//Integer

/**
 * 企业当前使用的模板
 */
@property (nonatomic,copy) NSString * projectTemplateId;

@end
