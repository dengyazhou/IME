//
//  InvitationItem.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/6/12.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import "Invitation.h"

@interface InvitationItem : BaseEntity

@property (nonatomic,copy) NSString * invitationItemId;

/**
 * 事件序号
 * 200-报价；300-接盘；400-发货；100-注册
 */
@property (nonatomic,strong) NSNumber * eventIndex;//Integer

/**
 * 邀请表头ID
 */
@property (nonatomic,copy) NSString * invitationId;

/**
 * 邀请
 */
@property (nonatomic,strong) Invitation * invitation;

/**
 * 邀请类型
 */
@property (nonatomic,copy) NSString * inviteType;//InviteType

/**
 * 邀请模式（暂时都默认为TARGET模式）
 */
@property (nonatomic,copy) NSString * inviteMode;//InviteMode

/**
 * 邀请事件描述（例如：报价）
 */
@property (nonatomic,copy) NSString *  activeDes;

/**
 * 邀请详细描述
 */
@property (nonatomic,copy) NSString * invitationDes;

/**
 * 前端事件URL
 */
@property (nonatomic,copy) NSString * webUrl;

/**
 * 邀请寄语
 */
@property (nonatomic,copy) NSString * inviteContent;

/**
 * 超时时间戳 精确到毫秒(-1:没超时)
 * 若无超时时间，则设为-1
 */
@property (nonatomic,strong) NSNumber * timeOut;//Long

/**
 * 是否需要注册企(如为无注册推荐 则传0)
 */
@property (nonatomic,strong) NSNumber * needEp;//Integer

/**
 * 是否需要注册(如为无注册推荐 则传0)
 */
@property (nonatomic,strong) NSNumber * needReg;//Integer

/**
 * 在用户中心是否需要隐藏（默认为0）
 */
@property (nonatomic,strong) NSNumber * needHide;//Integer

/**
 * 是否特殊target，默认为0
 * 注：申请注册链接时为1
 */
@property (nonatomic,strong) NSNumber * isSpecialTarget;//Integer

/**
 * 用户中心邀请ID(回调更新)
 */
@property (nonatomic,copy) NSString * inviteId;

/**
 * 用户中心手机邀请目标id(回调更新)
 */
@property (nonatomic,copy) NSString * phoneTargetId;

/**
 * 用户中心邮箱邀请目标id(回调更新)
 */
@property (nonatomic,copy) NSString * emailTargetId;

/**
 * 重发邀请过期时间(1天后的时间)
 */
@property (nonatomic,copy) NSString * inviteResendTime;//Date

@end
