//
//  Notification.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/19.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class NotificationItem;
@class PcwebNotification;
@class AppNotification;

@interface Notification : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * notificationId;

/**
 * 通知用户
 */
@property (nonatomic,strong) NSMutableArray <__kindof NotificationItem *>* notificationItems;//NotificationItem

/**
 * pc web 内容
 */
@property (nonatomic,copy) NSString * pcwebContent;

/**
 * app 内容
 */
@property (nonatomic,strong) AppNotification * appContent;

/**
 * 微信通知内容
 */
@property (nonatomic,copy) NSString * weixinContent;

/**
 * 短信内容
 */
@property (nonatomic,copy) NSString * smsContent;

/**
 * 邮件内容
 */
@property (nonatomic,copy) NSString * emailContent;

/**
 * 通知类型
 */
@property (nonatomic,copy) NSString * type;//Type

/**
 * 通知渠道
 */
//pcweb("pcweb"),
//app("app"),
//weixin("weixin"),
//sms("sms"),
//email("email"),
//pcweb_app("pcweb_app"),
//pcweb_app_weixin("pcweb_app_weixin");
@property (nonatomic,copy) NSString * channel;

/**
 * 备注信息
 */
@property (nonatomic,copy) NSString * remark;

@property (nonatomic,strong) NSNumber * isSendForMyself;//Boolean

@property (nonatomic,strong) PcwebNotification * pcwebNotification;

@property (nonatomic,strong) NSMutableArray <__kindof NSString *>* sei_type;//private Type[] sei_type;

@end
