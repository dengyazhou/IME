//
//  EnterpriseRelation.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/30.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

//@class EnterpriseInfo;
@class EnterpriseRelationTag;
@class QuotationTemplate;

#import "EnterpriseInfo.h"
#import "TGSupplierTag.h"
#import "EnterprisePayType.h"

@interface EnterpriseRelation : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString *reId;

/**
 * 企业ID(发起方)
 */
@property (nonatomic,copy) NSString *initiatorId;

/**
 * 主动方关联企业实体
 */
@property (nonatomic,strong) EnterpriseInfo *initiatorEnterprise;

/**
 * 发起方企业类型（采购-0/供应-1/其他2）
 * 当关注/拉黑时，默认为2
 */
@property (nonatomic,strong) NSNumber *type;//Integer

/**
 * 企业ID（被动方）
 */
@property (nonatomic,copy) NSString *passiveId;

/**
 * 关系类型
 */
@property (nonatomic,copy) NSString *relationType;//A("关注"),B("拉黑"),T("交易"),O("订单");

/**
 * 询盘类型(当RelationType为T或O时必填，否则为null)
 */
//COM("普通"),
//DIR("定向"),
//ATG("托管"),
//HTG("半托管");
@property (nonatomic,copy) NSString * inquiryType;//InquiryType

/**
 * 被动方关联企业实体
 */
@property (nonatomic,strong) EnterpriseInfo *passiveEnterprise;

//--------------- 20170524无注册流程 beg ------------------
/**
 * 管家供应商标签关系
 */
@property (nonatomic,strong) NSMutableArray <__kindof EnterpriseRelationTag *> * enterpriseRelationTag;//EnterpriseRelationTag

/**
 * 临时用户的用户ID
 */
@property (nonatomic,copy) NSString * temporaryMemberId;

/**
 * 临时用户的公司名
 */
@property (nonatomic,copy) NSString * temporaryEnterpriseName;

/**
 * 临时用户的联系人
 */
@property (nonatomic,copy) NSString * temporaryContacts;

/**
 * 临时用户的职位
 */
@property (nonatomic,copy) NSString * temporaryPosition;

/**
 * 临时用户的手机号
 */
@property (nonatomic,copy) NSString * temporaryPhoneNumber;

/**
 * 临时用户的邮箱
 */
@property (nonatomic,copy) NSString * temporaryEmailAddress;

/**
 * 临时用户的一级地区名称
 */
@property (nonatomic,copy) NSString * temporaryZoneId1;

/**
 * 临时用户的二级地区名称
 */
@property (nonatomic,copy) NSString * temporaryZoneId2;

/**
 * 临时用户的三级地区名称
 */
@property (nonatomic,copy) NSString * temporaryZoneId3;

/**
 * 临时用户的地区信息
 */
@property (nonatomic,copy) NSString * temporaryZoneStr;

//--------------- 20170524无注册流程 end ------------------

/**
 * 交易次数（RelationType为T或O时累计）
 */
@property (nonatomic,strong) NSNumber *trNum;//Integer

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 评价分值1
 * 报价及时性和配合度（采购类）
 */
@property (nonatomic,strong) NSNumber * puScore;//Double

/**
 * 评价分值2
 * 报价专业性(采购类)
 */
@property (nonatomic,strong) NSNumber * puScore1;//Double

/**
 * 评价分值3
 * 加急事项的处理能力 (采购类)
 */
@property (nonatomic,strong) NSNumber * puScore2;//Double

/**
 * 评价分值4
 * 交货及时率 (采购类)
 */
@property (nonatomic,strong) NSNumber * puScore3;//Double

/**
 * 评价分值5
 * 产品质量(质量类)
 */
@property (nonatomic,strong) NSNumber * quScore1;//Double

/**
 * 平均分值
 * 注：当分值项为null时，则不计入统计((有值)分值项总和/分值项数量)
 */
@property (nonatomic,strong) NSNumber * averageScore;//Double

/**
 * 评价月
 */
@property (nonatomic,strong) NSNumber * coMonth;//Integer

/**
 * 评价年
 */
@property (nonatomic,strong) NSNumber * coYear;//Integer

/**
 * 企业名称搜索字段
 */
@property (nonatomic,copy) NSString *sec_passiveEnterpriseName;

/**
 * 统计总数
 */
@property (nonatomic,strong) NSNumber * totalNum;//Long

/**
 * 17.5.31-管家供应商标签列表
 */
@property (nonatomic,strong) NSMutableArray <__kindof TGSupplierTag *> * tagList;//TGSupplierTag

/**
 * 搜索被动方企业名称（全匹配）
 */
@property (nonatomic,copy) NSString * pe__enterpriseName;

/**
 * 企业名称模糊查询
 */
@property (nonatomic,copy) NSString * se_temporaryEnterpriseName;

/**
 * 企业地区模糊查询
 */
@property (nonatomic,copy) NSString * se_temporaryZoneStr;

/**
 * 标签查询
 */
@property (nonatomic,copy) NSString * rt__tagId;

/**
 * 企业名、地区查询
 */
@property (nonatomic,copy) NSString * sec_nameOrZone;

/**
 * 搜索多个关系类型
 */
@property (nonatomic,strong) NSMutableArray * sei_relationType;//RelationType

/**
 * 发起方多种类型
 */
@property (nonatomic,strong) NSMutableArray * sei_type;//Integer

/**
 * 被动方企业ID组
 */
@property (nonatomic,strong) NSMutableArray * sei_passiveId;//String

/**
 * 注册邀请过期时间(7天后的时间)
 */
@property (nonatomic,copy) NSString * inviteTime;//Date

/**
 * 被动方企业是否是临时企业
 */
@property (nonatomic,strong) NSNumber * pe__isTemporary;//Integer

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
 * 搜索被动方UC企业ID
 */
@property (nonatomic,copy) NSString *  pe__enterpriseId;

/**
 * 采购商针对管家供应商的付款类型
 */
@property (nonatomic,copy) NSString *payTypeJson;

/**
 * 付款类型信息
 */
@property (nonatomic,strong) EnterprisePayType * sec_enterprisePayType;

//---------------------------------------------管家供应商排序字段BG--2018.7.11---------------------------------
/**
 * 管家供应商合作次数（发布询盘时更新）
 */
@property (nonatomic,strong) NSNumber * coopNums;//Integer

/**
 * 管家供应商合作时间（发布询盘时更新）
 */
@property (nonatomic,copy) NSString * coopTime;//Date
//---------------------------------------------管家供应商排序字段END--2018.7.11-------------------------------

//----------------20180807ERP对接新增字段begin----------------------
/**
 * 管家供应商的部门-ERP对接
 */
@property (nonatomic,copy) NSString * temporaryDepartment;

/**
 * 付款条件-ERP对接
 */
@property (nonatomic,copy) NSString *payTerm;

/**
 * 供应商编码-ERP对接
 */
@property (nonatomic,copy) NSString *erpEnterpriseNo;

/**
 * 供应商地址-ERP对接（街道）
 */
@property (nonatomic,copy) NSString *erpEnterpriseAddress;

/**
 * 自定义标识
 * 注：现用于明珞删除标志，于与非标业务暂时无关
 */
@property (nonatomic,strong) NSNumber * erpCustomerMark;//Integer
//----------------20180807ERP对接新增字段end----------------------


@property (nonatomic,copy) NSString *passiveEnterpriseName;
@property (nonatomic,strong) NSNumber *passiveIsTemporary;


/**
 manufacturerId = passiveId
 memberId = temporaryMemberId
 isTemporary = passiveIsTemporary
 enterpriseName = passiveEnterpriseName
 */
@property (nonatomic,copy) NSString * manufacturerId;
@property (nonatomic,copy) NSString * memberId;
@property (nonatomic,strong) NSNumber * isTemporary;
@property (nonatomic,copy) NSString * enterpriseName;

@end
