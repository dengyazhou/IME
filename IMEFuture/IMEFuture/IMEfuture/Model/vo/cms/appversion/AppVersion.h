//
//  AppVersion.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/10/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@interface AppVersion : BaseEntity

@property (nonatomic,strong) NSNumber * appVersionId;//Integer

/**
 * 应用类型
 */
//IMEFUTURE("智造家");
@property (nonatomic,copy) NSString * appType;//AppType

/**
 * 应用分类
 */
//ANDROID("安卓"),
//IOS("苹果");
@property (nonatomic,copy) NSString * appCategory;//AppCategory

/**
 * 版本
 */
@property (nonatomic,copy) NSString * version;

/**
 * 最低版本
 */
@property (nonatomic,copy) NSString * minVersion;

/**
 * 版本内容
 */
@property (nonatomic,copy) NSString * versionContent;

/**
 * 文件id
 */
@property (nonatomic,strong) NSNumber * fileId;//Integer

/**
 * 文件名称
 */
@property (nonatomic,copy) NSString * fileName;

/**
 * 文件大小（以KB为单位）
 */
@property (nonatomic,strong) NSNumber * fileSize;//Long

/**
 * 是否提示更新
 * 0 不提示
 * 1 提示
 */
@property (nonatomic,strong) NSNumber * isTipUpdate;//Integer

/**
 * 下载版本地址
 */
@property (nonatomic,copy) NSString * url;

/**
 * 发布状态
 */
//P("发布"),
//D("草稿"),
//R("封锁");
@property (nonatomic,copy) NSString * pubType;//PubType

/**
 * 添加的管理员真名
 */
@property (nonatomic,copy) NSString * addSmName;

/**
 * 添加的管理员Id
 */
@property (nonatomic,strong) NSNumber * addSmId;//Integer

/**
 * 最后一次修改的管理员真名
 */
@property (nonatomic,copy) NSString * editSmName;

/**
 * 最后一次修改的管理员Id
 */
@property (nonatomic,strong) NSNumber * editSmId;//Integer

/**
 * 是否升级
 * 0  不升级      1 需要升级     2 强制升级
 */
@property (nonatomic,strong) NSNumber * mustUpgrade;//Integer

@end
