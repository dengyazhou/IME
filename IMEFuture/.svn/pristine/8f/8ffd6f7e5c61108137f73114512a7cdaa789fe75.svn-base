//
//  RecommendPosition.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/10/19.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@interface RecommendPosition : BaseEntity

/**
 * 主键
 */
@property (nonatomic,strong) NSNumber * rpId;//Integer

/**
 * 页面名称
 */
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
@property (nonatomic,copy) NSString * recommendPage;//RecommendPage

/**
 * 推荐位类型
 */
//R("推荐位"),
//A("广告位");
@property (nonatomic,copy) NSString * recommendType;//RecommendType

/**
 * 推荐位名
 */
@property (nonatomic,copy) NSString * name;

/**
 * 抛到前台获取的数据Key值
 */
@property (nonatomic,copy) NSString * keyName;

/**
 * 图片推荐宽度
 */
@property (nonatomic,strong) NSNumber * picWidth;//Integer

/**
 * 图片推荐高度
 */
@property (nonatomic,strong) NSNumber * picHeight;//Integer

/**
 * 轮换的频率
 * 一个数据组再次出现需要的天数
 * 1无需切换
 */
@property (nonatomic,strong) NSNumber * pageNum;//Integer

/**
 * 轮换的内容数量
 * 一个数据组的数据长度
 */
@property (nonatomic,strong) NSNumber * pageSize;//Integer

/**
 * 当前显示的模式
 */
@property (nonatomic,strong) NSNumber * showMode;//Integer

/**
 * 总共拥有的模式数量
 */
@property (nonatomic,strong) NSNumber * modeType;//Integer

@end
