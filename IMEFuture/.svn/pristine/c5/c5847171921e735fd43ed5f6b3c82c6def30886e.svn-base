//
//  Recommend.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/10/19.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"
@class RecommendPosition;

@interface Recommend : BaseEntity

/**
 * 主键
 */
@property (nonatomic,strong) NSNumber * recommendId;//Integer

@property (nonatomic,strong) RecommendPosition * recommendPosition;

/**
 * 推荐位内容
 */
//N("行业资讯"),
//E("会展大厅"),
//T("SAAS工具"),
//TA("标签"),
//C("自定义");
@property (nonatomic,copy) NSString * recommendContent;//RecommendContent

/**
 * 内容Id
 */
@property (nonatomic,copy) NSString * contentId;

/**
 * 标题
 */
@property (nonatomic,copy) NSString * title;

/**
 * 标题Link
 */
@property (nonatomic,copy) NSString * titleLink;

/**
 * 简介
 */
@property (nonatomic,copy) NSString * info;

/**
 * 简介Link
 */
@property (nonatomic,copy) NSString * infoLink;

/**
 * 图片描述
 */
@property (nonatomic,copy) NSString * picDesc;

/**
 * 图片id
 */
@property (nonatomic,strong) NSNumber *  picId;//Integer

/**
 * 图片名称
 */
@property (nonatomic,copy) NSString * picName;

/**
 * 图片Url
 */
@property (nonatomic,copy) NSString * picUrl;

/**
 * 图片Link
 */
@property (nonatomic,copy) NSString * picLink;

/**
 * 图片推荐宽度
 */
@property (nonatomic,strong) NSNumber *  picWidth;//Integer

/**
 * 图片推荐高度
 */
@property (nonatomic,strong) NSNumber *  picHeight;//Integer

/**
 * 对应模式
 */
@property (nonatomic,strong) NSNumber *  showMode;//Integer

/**
 * 优先级
 */
@property (nonatomic,strong) NSNumber *  praise;//Integer

/**
 * 是否启用
 */
@property (nonatomic,strong) NSNumber *  isActive;//Integer

/**
 * 生效时间
 */
@property (nonatomic,copy) NSString * begTm;//Date

/**
 * 失效时间
 */
@property (nonatomic,copy) NSString * endTm;//Date

/**
 * 发表时间
 */
@property (nonatomic,copy) NSString * pubTm;//Date

/**
 * 作者
 */
@property (nonatomic,copy) NSString * author;

/**
 * 标签
 */
@property (nonatomic,copy) NSString * tags;

/**
 * 添加的管理员真名
 */
@property (nonatomic,copy) NSString * addSmName;

/**
 * 添加的管理员Id
 */
@property (nonatomic,strong) NSNumber *  addSmId;//Integer

/**
 * 最后一次修改的管理员真名
 */
@property (nonatomic,copy) NSString * editSmName;

/**
 * 最后一次修改的管理员Id
 */
@property (nonatomic,strong) NSNumber * editSmId;//Integer

/**
 * 是否搜索和当前推荐位显示模式相同的推荐位记录
 */
@property (nonatomic,strong) NSNumber * seModeType;//boolean


//A("首页"),
//B("行业资讯-列表"),
//C("行业资讯-详情"),
//D("在线展览-列表"),
//E("在线展览-展会概览"),
//F("在线展览-详情"),
//G("会展信息-列表"),
//H("会展信息-详情"),
//I("SAAS工具-列表"),
//J("SAAS工具-详情"),
//K("搜索-全部"),
//O("技术问答(共享)"),
//P("最新分享(共享)"),
//Q("热门展品(共享)"),
//R("技术标签(共享)"),
//S("热门标签(共享)"),
//APP_A("APP_首页");
@property (nonatomic,strong) NSMutableArray * sei_p__recommendPage;//RecommendPage[]

@property (nonatomic,copy) NSString * seb_begTm;//Date

@property (nonatomic,copy) NSString * see_begTm;//Date

@property (nonatomic,copy) NSString * seb_endTm;//Date

@property (nonatomic,copy) NSString * see_endTm;//Date

@property (nonatomic,copy) NSString * se_addSmName;

@property (nonatomic,copy) NSString * se_editSmName;

@property (nonatomic,copy) NSString * se_title;

@property (nonatomic,copy) NSString * se_info;

@property (nonatomic,copy) NSString * se_picName;

@property (nonatomic,copy) NSString * se_picDesc;

//A("首页"),
//B("行业资讯-列表"),
//C("行业资讯-详情"),
//D("在线展览-列表"),
//E("在线展览-展会概览"),
//F("在线展览-详情"),
//G("会展信息-列表"),
//H("会展信息-详情"),
//I("SAAS工具-列表"),
//J("SAAS工具-详情"),
//K("搜索-全部"),
//O("技术问答(共享)"),
//P("最新分享(共享)"),
//Q("热门展品(共享)"),
//R("技术标签(共享)"),
//S("热门标签(共享)"),
//APP_A("APP_首页");
@property (nonatomic,copy) NSString * se_p__recommendPage;//RecommendPage

//R("推荐位"),
//A("广告位");
@property (nonatomic,copy) NSString * se_p__recommendType;//RecommendType

@property (nonatomic,copy) NSString * se_p__name;

@end
