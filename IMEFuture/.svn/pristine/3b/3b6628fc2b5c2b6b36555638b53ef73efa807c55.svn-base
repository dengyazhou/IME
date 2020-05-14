//
//  InquiryOrderEnterprise.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2016/10/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import "EnterpriseInfo.h"
#import "InquiryOrder.h"
#import "Member.h"

@interface InquiryOrderEnterprise : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * inquiryOrderEnterpriseId;
/**
 * 企业ID主键
 */
@property (nonatomic,copy) NSString * manufacturerId;
/**
 * 报价状态
 */
@property (nonatomic,copy) NSString * inquiryAndEpStatus;//InquiryAndEpStatus(报价状态)
/**
 * 报价状态
 */
@property (nonatomic,copy) NSString * inquiryAndEpStatusDesc;
/**
 * 企业信息
 */
@property (nonatomic,strong) EnterpriseInfo * enterpriseInfo;
/**
 * 采购是否已报价
 */
@property (nonatomic,strong) NSNumber * purchaseHasQuoed;//Integer
/**
 * 供应商是否已报价
 */
@property (nonatomic,strong) NSNumber * supplierHasQuoed;//Integer
/**
 * 采购商和供应商是否议价一致
 * 只有议价一致才会为1
 */
@property (nonatomic,strong) NSNumber * isTheSamePrice;//Integer
/**
 * 是否可以修改价格
 * 议价询盘特有的字段，指双方价格是否达成一致，有可能审核通过，也可能审核未通过
 */
@property (nonatomic,strong) NSNumber * canEditPrice;//Integer
/**
 * (可以开始)催报价的时间
 */
@property (nonatomic,copy) NSString *callQuoTm;//Date
/**
 * 是否是供应商新报价
 * 0-否；1-是；
 */
@property (nonatomic,strong) NSNumber * isNewQuo;//Integer
/**
 * 询盘是否被指定的企业看过
 */
@property (nonatomic,strong) NSNumber * isRead;//Integer
/**
 * 报价单ID
 */
@property (nonatomic,copy) NSString * quotationOrderId;
/**
 * 是否是临时用户生成的定向关系
 */
@property (nonatomic,strong) NSNumber * isTemporary;//Integer






























/**
 * 用户信息
 */
@property (nonatomic,strong) Member * member;

/**
 * 用户ID主键
 */
@property (nonatomic,copy) NSString * memberId;

/**
 * 询盘订单
 */
@property (nonatomic,strong) InquiryOrder * inquiryOrder;

/**
 * 询盘订单ID
 */
@property (nonatomic,copy) NSString * inquiryOrderId;

/**
 * 是否已报价
 * 0-未报价；1-已报价
 */
@property (nonatomic,strong) NSNumber * hasQuo;//Integer


/**
 * 关联类型
 * 0-邀请；2-定向；4-无需付款的托管；6-需付款的托管；8-关注
 */
@property (nonatomic,strong) NSNumber * recommendType;//Integer


/**
 * 指定关系的合并状态
 * 0-无需合并；2-待合并；1-已合并
 */
@property (nonatomic,strong) NSNumber * mergeStatus;//Integer
//--------------- 20170524无注册流程 end ------------------

@end
