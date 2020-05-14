//
//  MemberCompetence.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

#import "Competence.h"
//#import "Member.h"
@class Member;
@class Role;

@interface MemberCompetence : BaseEntity


@property (nonatomic,strong) NSNumber * memberCompetenceId;//Integer

/**
 * 权限
 */
@property (nonatomic,strong) Competence * competence;

/**
 * 权限ID
 */
@property (nonatomic,copy) NSString * competenceId;

/**
 * 用户
 * 用户分配的权限有值
 */
@property (nonatomic,strong) Member * member;

/**
 * 用户ID
 * 用户分配的权限有值
 */
@property (nonatomic,copy) NSString * memberId;

/**
 * 用户所属企业的企业ID
 * 用户分配的权限有值
 */
@property (nonatomic,copy) NSString * manufacturerId;

/**
 * 角色
 * 角色分配的权限有值
 */
@property (nonatomic,strong) Role * role;

/**
 * 角色ID
 * 角色分配的权限有值
 */
@property (nonatomic,copy) NSString * roleId;

/**
 * 权限权重
 */
@property (nonatomic,strong) NSNumber * weight;//Integer

/**
 * 权限排序
 */
@property (nonatomic,strong) NSNumber * showIndex;//Integer

/**
 * 添加方式
 */
@property (nonatomic,copy) NSString * addType;//M("用户分配"),用户分配;R("角色分配"),角色分配

@property (nonatomic,copy) NSString * co__url;

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
@property (nonatomic,copy) NSString * co__type;

@property (nonatomic,copy) NSString * se_co__webUrl;

@property (nonatomic,strong) NSNumber * co__isNotify;//Integer

@property (nonatomic,copy) NSString * mr__memberId;

@property (nonatomic,copy) NSString * mrm__ucenterId;

@property (nonatomic,strong) NSNumber * sec_searchNotifyTree;//boolean

@property (nonatomic,strong) NSNumber * sec_isDistinct;//boolean

@end
