//
//  PurchaseProject.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/1/6.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseCustomField.h"
#import "Member.h"

@class PurchaseProjectInfo;

@interface PurchaseProject : BaseCustomField

/**
 * 主键
 */
@property (nonatomic,copy) NSString * purchaseProjectId;

/**
 * 创建采购项目的用户
 */
@property (nonatomic,strong) Member *member;

/**
 * 创建采购项目的用户Id
 */
@property (nonatomic,copy) NSString * memberId;

/**
 * 创建采购项目的企业Id
 */
@property (nonatomic,copy) NSString * manufacturerId;

/**
 * 采购项目管理明细
 */
@property (nonatomic,strong) NSMutableArray <__kindof PurchaseProjectInfo *> * purchaseProjectInfos;

/**
 * 是否是长期的
 * 如果是长期的，则endTm设置为BaseEntityUtils.makeStrDate(BaseConstant.TIME_OUT_STR, null)
 */
@property (nonatomic,strong) NSNumber * isLongTerm;//Integer

/**
 * 项目截止日期时间
 */
@property (nonatomic,copy) NSString * endTm;//Date

/**
 * 项目状态
 */
@property (nonatomic,copy) NSString * purchasePorjectStatus;//PurchasePorjectStatus NSString
/**
 * 自定义颜色
 */
@property (nonatomic,copy) NSString * colorStyle;//ColorStyle NSString

/**
 * 备注
 */
@property (nonatomic,copy) NSString * remark;

/**
 * 跟进人
 * 7-31 已经废弃
 */
@property(nonatomic,strong) Member * purchaseFollower;
/*-----------ERP对接新增字段begin----------*/
/**
 * 采购申请类型
 */
@property(nonatomic,copy) NSString * applyType;
/**
 * 采购申请类型描述
 */

@property(nonatomic,copy) NSString * applyTypeDescription;
/**
 * 采购申请号
 */
@property(nonatomic,copy) NSString * applyNumber;
/**
 * 采购申请名称
 */
@property(nonatomic,copy) NSString * applyName;

/**
 * 采购申请的id
 */
@property(nonatomic,copy) NSString * bomId;
/**
 * 零件来源
 */
@property(nonatomic,copy) NSString * source;//PartSourceType
/*-----------ERP对接新增字段end----------*/
/**
 * 跟进人ID
 * * 7-31 已经废弃
 */
@property(nonatomic,copy) NSString * purchaseFollowerId;

/**
 * 项目名称查询
 */
@property (nonatomic,copy) NSString * se_projectName;

/**
 * 查询项目所属企业名
 */
@property (nonatomic,copy) NSString * se_proe__enterpriseName;

/**
 * 已交货种类数量
 */
@property (nonatomic,strong) NSNumber * sec_deliveryNum;//Integer

/**
 * 询盘数量
 */
@property (nonatomic,strong) NSNumber *  sec_inquiryNum;//Integer

/**
 *
 */
@property (nonatomic,strong) NSNumber *  sec_kindNum;//Integer
/**
 * 零件是否需要排序
 */
@property (nonatomic,copy) NSString * sec_isNeedOrder;

/**
 * 零件里的询盘是否需要去重
 */
@property (nonatomic,copy) NSString * sec_isNeedDistict;

/**
 * 询盘或订单过期数量
 */
@property (nonatomic,strong) NSNumber *  sec_expiredQuantity;//Integer









@property (nonatomic,copy) NSString *isDelete;
@property (nonatomic,copy) NSString *projectName;
//@property (nonatomic,copy) NSString *endTm;
//@property (nonatomic,copy) NSString *remark;
//@property (nonatomic,copy) NSString *isLongTerm;
@property (nonatomic,copy) NSString *followName;
@property (nonatomic,copy) NSString *followId;
//@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *itemsNum; //清单项数
@property (nonatomic,copy) NSString *receiveItemsNum; //入库项数
@property (nonatomic,copy) NSString *liftDays;
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *statusDesc;
@property (nonatomic,copy) NSString *memberName;
//@property (nonatomic,copy) NSString *seb_createTime;
//@property (nonatomic,copy) NSString *see_createTime;
@property (nonatomic,copy) NSString *seb_endTm;
@property (nonatomic,copy) NSString *see_endTm;

@end
