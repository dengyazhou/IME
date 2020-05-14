//
//  PurchaseProjectFile.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/9/18.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseEntity.h"
#import "UploadFile.h"

@interface PurchaseProjectFile : BaseEntity

/**
 * 主键
 */
@property (nonatomic,copy) NSString * purchaseProjectFileId;

/**
 * 文件别名（上传时的文件名称）
 */
@property (nonatomic,copy) NSString * fileName;

/**
 * 源文件的真名
 */
@property (nonatomic,copy) NSString * fileRealName;

/**
 * 源文件路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString * filePath;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString * fileBucketName;

/**
 * 文件ID
 */
@property (nonatomic,copy) NSString * fileId;

/**
 * 缩略图的真名
 */
@property (nonatomic,copy) NSString * thumbnailName;

/**
 * 文件实体
 */
@property (nonatomic,strong) UploadFile * uploadFile;

/**
 * 缩略图路径（全路径 ModuleFilePath表文件路径+FileExplanation表文件子路径）
 */
@property (nonatomic,copy) NSString * thumbnailPath;

@end
