//
//  FileModule.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2016/10/21.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "BaseEntity.h"

@interface FileModule : BaseEntity

/**
 * 主键
 */
@property (nonatomic,strong) NSNumber * mpId;//Integer

/**
 * 模块名称
 */
@property (nonatomic,copy) NSString * moduleName;

/**
 * 文件路径(绝对路径，以“/”结尾)
 */
@property (nonatomic,copy) NSString * filePath;

/**
 * 临时文件路径(绝对路径，以“/”结尾)
 */
@property (nonatomic,copy) NSString * tempFilePath;

/**
 * 允许上传的文件扩展名（.jpg.png.）
 */
@property (nonatomic,copy) NSString * fileExtensions;

/**
 * oss key
 */
@property (nonatomic,copy) NSString * ossKey;

/**
 * oss secret
 */
@property (nonatomic,copy) NSString * ossSecret;

/**
 * OSS存储空间名称
 */
@property (nonatomic,copy) NSString * bucketName;

/**
 * OSS上传节点
 */
@property (nonatomic,copy) NSString * ossEndpoint;

/**
 * OSS图片处理节点
 */
@property (nonatomic,copy) NSString * imgEndpoint;

/**
 * OSS原生路径
 */
@property (nonatomic,copy) NSString * apiEndpoint;

/**
 * 文件模块类型-2017.5.16
 * 0-询盘发布；1-质量报告
 */
@property (nonatomic,strong) NSNumber * moduleType;//Integer

@end
