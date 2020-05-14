//
//  NotificationItem.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/18.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class Notification;

@interface NotificationItem : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * notificationItemId;

/**
 * 通知
 */
@property (nonatomic,strong) Notification * notification;

/**
 * 企业id（ucenter企业ID）
 */
@property (nonatomic,copy) NSString * enterpriseId;

/**
 * ucenter ID
 */
@property (nonatomic,copy) NSString * ucenterId;

/**
 * web端发送状态
 */
@property (nonatomic,copy) NSString * sendStatusForWeb;//unSend("未发送"),sent("已发送"),sendSuccess("发送成功"),reSend("已重发"),sendFail("发送失败");

/**
 * web端发送状态更新时间
 */
@property (nonatomic,copy) NSString * updateTimeForWeb;//Date

/**
 * Phone端发送状态
 */
@property (nonatomic,copy) NSString * sendStatusForApp;//unSend("未发送"),sent("已发送"),sendSuccess("发送成功"),reSend("已重发"),sendFail("发送失败");

/**
 * Phone端发送状态更新时间
 */
@property (nonatomic,copy) NSString * updateTimeForApp;//Date

/**
 * weixin端发送状态
 */
@property (nonatomic,copy) NSString * sendStatusForWeixin;//unSend("未发送"),sent("已发送"),sendSuccess("发送成功"),reSend("已重发"),sendFail("发送失败");

/**
 * weixin端发送状态更新时间
 */
@property (nonatomic,copy) NSString * updateTimeForWeixin;//Date

/**
 * 所有渠道发送状态
 */
@property (nonatomic,copy) NSString * sendStatusForResult;//unSend("未发送"),sent("已发送"),sendSuccess("发送成功"),reSend("已重发"),sendFail("发送失败");

/**
 * 所有渠道发送状态更新时间
 */
@property (nonatomic,copy) NSString * updateTimeForResult;//Date

/**
 * 通知类型
 */
//ND1("给供应商推荐询盘"),给供应商推荐询盘
//ND2("收到报价邀请"),收到报价邀请
//ND3("询价单有人报价"),询价单有人报价
//ND4("有人修改报价"),有人修改报价
//ND5("拒绝授盘"),拒绝授盘通知
//ND6("接受授盘，生成订单"),接受授盘，生成订单
//ND7("询盘过期"),询盘过期
//ND8("收到授盘"),收到授盘
//ND9("接受授盘，生成订单"),接受授盘，生成订单
//ND10("报价的询盘已经授盘给其他供应商"),报价的询盘已经授盘给其他供应商
//ND11("订单付款，平台收到付款，通知供应商"),订单付款，平台收到付款，通知供应商
//ND12("平台付款给供应商"),平台付款给供应商
//ND13("确认收货"),确认收货
//ND14("采购商发起纠纷"),采购商发起纠纷
//ND15("仲裁结果通知供应商"),仲裁结果通知供应商
//ND16("订单付款，平台收到付款，通知采购商"),订单付款，平台收到付款，通知采购商
//ND17("供应商已发货"),供应商已发货
//ND18("供应商发起纠纷"),供应商发起纠纷
//ND19("仲裁结果通知采购商"),仲裁结果通知采购商
//ND20("收到退款"),收到退款
//ND21("采购商验货"),采购商验货
//ND22("提醒采购商付款"),提醒采购商付款
//ND23("新询盘咨询")，新询盘咨询
//ND24("询盘咨询被回答")，询盘咨询被回答

//A("发布询盘"),发布询盘
//B("授盘"),授盘
//C("取消授盘"),取消授盘
//D("取消询盘"),取消询盘
//E("提问回复"),提问回复
//F("付款"),付款
//G("收货"),收货
//H("验货"),验货
//I("添加报价"),添加报价
//J("修改报价"),修改报价
//K("报价审核通过"),报价审核通过
//L("接盘"),接盘
//M("拒绝接盘"),拒绝接盘
//N("报价审核失败"),报价审核失败
//O("下载图纸"),下载图纸
//P("确认发货"),确认发货
//Q("填写物流单号"),填写物流单号
//R("员工角色列表"),员工角色列表
//S("添加员工角色"),添加员工角色
//T("回复自己的询盘提问");回复自己的询盘提问
@property (nonatomic,copy) NSString * type;

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

/**
 * 是否已读（目前，只是为移动端使用）
 */
@property (nonatomic,strong) NSNumber * isRead;//Boolean

@property (nonatomic,strong) NSMutableArray <__kindof NSString *> * sei_notificationItemId;//String

@property (nonatomic,strong) NSMutableArray * sei_sendStatusForWeb;//unSend("未发送"),sent("已发送"),sendSuccess("发送成功"),reSend("已重发"),sendFail("发送失败");

@property (nonatomic,copy) NSString * see_updateTimeForApp;//Date

@property (nonatomic,strong) NSMutableArray <__kindof NSString *>* sei_sendStatusForApp;//unSend("未发送"),sent("已发送"),sendSuccess("发送成功"),reSend("已重发"),sendFail("发送失败");

//ND1("给供应商推荐询盘"),给供应商推荐询盘
//ND2("收到报价邀请"),收到报价邀请
//ND3("询价单有人报价"),询价单有人报价
//ND4("有人修改报价"),有人修改报价
//ND5("拒绝授盘"),拒绝授盘通知
//ND6("接受授盘，生成订单"),接受授盘，生成订单
//ND7("询盘过期"),询盘过期
//ND8("收到授盘"),收到授盘
//ND9("接受授盘，生成订单"),接受授盘，生成订单
//ND10("报价的询盘已经授盘给其他供应商"),报价的询盘已经授盘给其他供应商
//ND11("订单付款，平台收到付款，通知供应商"),订单付款，平台收到付款，通知供应商
//ND12("平台付款给供应商"),平台付款给供应商
//ND13("确认收货"),确认收货
//ND14("采购商发起纠纷"),采购商发起纠纷
//ND15("仲裁结果通知供应商"),仲裁结果通知供应商
//ND16("订单付款，平台收到付款，通知采购商"),订单付款，平台收到付款，通知采购商
//ND17("供应商已发货"),供应商已发货
//ND18("供应商发起纠纷"),供应商发起纠纷
//ND19("仲裁结果通知采购商"),仲裁结果通知采购商
//ND20("收到退款"),收到退款
//ND21("采购商验货"),采购商验货
//ND22("提醒采购商付款"),提醒采购商付款
//A("发布询盘"),发布询盘
//B("授盘"),授盘
//C("取消授盘"),取消授盘
//D("取消询盘"),取消询盘
//E("提问回复"),提问回复
//F("付款"),付款
//G("收货"),收货
//H("验货"),验货
//I("添加报价"),添加报价
//J("修改报价"),修改报价
//K("报价审核通过"),报价审核通过
//L("接盘"),接盘
//M("拒绝接盘"),拒绝接盘
//N("报价审核失败"),报价审核失败
//O("下载图纸"),下载图纸
//P("确认发货"),确认发货
//Q("填写物流单号"),填写物流单号
//R("员工角色列表"),员工角色列表
//S("添加员工角色"),添加员工角色
//T("回复自己的询盘提问");回复自己的询盘提问
@property (nonatomic,strong) NSMutableArray * sei_type;

@end
