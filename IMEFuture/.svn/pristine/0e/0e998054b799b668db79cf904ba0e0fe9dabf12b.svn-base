//
//  TradeOrderItemFile.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/3.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@class TradeOrder;

@interface TradeOrderItemFile : BaseEntity

/**
 * 主键
 */
@property (nonatomic,strong) NSString * tradeOrderItemFileId;

/**
 * 交易单
 */
@property (nonatomic,strong) TradeOrder * tradeOrder;

/**
 * 文件别名（上传时的文件名称）
 */
@property (nonatomic,strong) NSString * fileName;

/**
 * 文件的真名
 */
@property (nonatomic,strong) NSString * fileRealName;

/**
 * 文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,strong) NSString * filePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,strong) NSString * fileBucketName;

/**
 * 文件ID
 */
@property (nonatomic,strong) NSString * fileId;

/**
 * 缩略图地址
 */
@property (nonatomic,strong) NSString * thumbnailUrl;

/**
 * 展示类型 0-普通；1-列表图
 */
@property (nonatomic,strong) NSNumber * showType;//Integer

/**
 * 实际现在地址
 */
@property (nonatomic,strong) NSString * sec_realUrl;

/**
 * 图纸库图纸ID
 */
@property (nonatomic,strong) NSString * sec_adId;

@end
