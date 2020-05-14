//
//  Invitation.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/6/12.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class InvitationItem;

@interface Invitation : BaseEntity

@property (nonatomic,copy) NSString * invitationId;

/**
 * 邀请人用户中心ID
 */
@property (nonatomic,copy) NSString * userId;

/**
 * 询盘单ID
 */
@property (nonatomic,copy) NSString * inquiryOrderId;

/**
 * 询盘单编号
 */
@property (nonatomic,copy) NSString * inquiryOrderCode;

/**
 * 订单ID
 */
@property (nonatomic,copy) NSString * tradeOrderId;

/**
 * 订单编号
 */
@property (nonatomic,copy) NSString * tradeOrderCode;

/**
 * 被邀请人ID(临时用户memberID)
 */
@property (nonatomic,copy) NSString * inviteeId;

/**
 * 被邀请人企业ID（非标企业主键）
 */
@property (nonatomic,copy) NSString * inviteeEpId;

/**
 * 被邀请人企业名
 */
@property (nonatomic,copy) NSString * inviteeName;

/**
 * 手机国际码（默认86）
 */
@property (nonatomic,copy) NSString * nationalCode;

/**
 * 被邀请人手机号
 */
@property (nonatomic,copy) NSString * inviteePhone;

/**
 * 被邀请人邮箱
 */
@property (nonatomic,copy) NSString * inviteeEmail;

/**
 * 邀请项
 */
@property (nonatomic,strong) NSMutableArray <__kindof InvitationItem *>* invitationItems;//InvitationItem

/**
 * 用户中心返还URL
 */
@property (nonatomic,copy) NSString * callBackUrl;

/**
 * 根据UC邀请ID查询
 */
@property (nonatomic,copy) NSString * ii__inviteId;

/**
 * 根据itemid查询邀请事件
 */
@property (nonatomic,copy) NSString * ii__invitationItemId;

/**
 * 临时存储数据用
 */
@property (nonatomic,copy) NSString * sec_tempData;

/**
 * 被邀请联系人
 */
@property (nonatomic,copy) NSString * inviteeContacts;

/**
 * 被邀请人职位
 */
@property (nonatomic,copy) NSString * inviteePosition;
@end
