//
//  OssUploadResBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/11/5.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>
#import "OssUploadBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface OssUploadResBean : NSObject

/**
 * 文件页数 -- 对应生成的jpg图片数量
 */
@property (nonatomic, strong) NSNumber * filePages;//Integer
/**
 * 上传空间名称
 */
@property (nonatomic, copy) NSString * bucketName;
/**
 * 主文件原名称--不带后缀
 */
@property (nonatomic, copy) NSString * mainFileName;
/**
 * 主文件真实名称--不带后缀
 */
@property (nonatomic, copy) NSString * mainFileRealName;
///**
// * 主文件路径
// */
@property (nonatomic, copy) NSString * mainFolderPath;
///**
// * 主文件后缀
// */
@property (nonatomic, copy) NSString * mainFileSuffix;
/**
 * 关联文件列表
 */
@property (nonatomic, strong) NSMutableArray <OssUploadBean *>* subfiles;//OssUploadBean


@property (nonatomic, strong) NSData *imageData;//自己添加

@end

NS_ASSUME_NONNULL_END
