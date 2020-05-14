//
//  Competence.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseTreeEntity.h"

@interface Competence : BaseTreeEntity

@property (nonatomic,strong) NSNumber * competenceId;//Integer

/**
 * 权限类型
 */

//MENU("主菜单"),菜单级权限;
//MENU_F("一级子菜单"),一级子菜单;
//MENU_S("二级子菜单"),二级子菜单;
//MENU_T("三级子菜单"),三级子菜单;
//BUTTON("按钮"),按钮级权限;
//TAB("标签"),标签级权限;
//LINK("右键菜单"),链接级权限;
//STORE("数据列表"),数据级权限;
//DATA("数据内容");数据级权限;
@property (nonatomic,copy) NSString * competenceType;

/**
 * 权限类型
 */

//ND1("给供应商推荐询盘"),给供应商推荐询盘
//ND2("收到报价邀请"),收到报价邀请
//ND3("询价单有人报价"),询价单有人报价
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

@property (nonatomic,copy) NSString * type;

/**
 * 过滤url
 * 非末级menu类型权限不需要url
 */
@property (nonatomic,copy) NSString * url;

/**
 * 前端的过滤url
 * 非末级menu类型权限不需要url，存在多个时以"|"进行分割。
 */
@property (nonatomic,copy) NSString * webUrl;

/**
 * 是否是通知权限
 */
@property (nonatomic,strong) NSNumber * isNotify;//Integer

/**
 * 是否需要判断供应商（1-是）
 */
@property (nonatomic,strong) NSNumber * isSupplier;//Integer

/**
 * 是否需要判断采购商（1-是）
 */
@property (nonatomic,strong) NSNumber * isBuyer;//Integer

/**
 * 是否开启非标管家
 * 1-是
 */
@property (nonatomic,strong) NSNumber * isAtg;//Integer

/**
 * 是否开启私有化
 * 0-未开启（默认）；1-开启
 */
@property (nonatomic,strong) NSNumber * isPrivate;//Integer

/**
 * 是否允许临时用户操作（1-是）
 */
@property (nonatomic,strong) NSNumber * permitTempMember;//Integer

/**
 * 查询WEB的URL，多个查询，中间用 "|"分割
 */
@property (nonatomic,copy) NSString * se_webUrl;

@end
