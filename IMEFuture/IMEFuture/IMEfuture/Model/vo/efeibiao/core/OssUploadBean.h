//
//  OssUploadBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/18.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OssUploadBean : NSObject

@property (nonatomic,copy) NSString * fileName;
@property (nonatomic,copy) NSString * filePath;
@property (nonatomic,copy) NSString * realName;
@property (nonatomic, strong) NSNumber * fileSize;//Long
@property (nonatomic,copy) NSString * folderName;
@property (nonatomic,copy) NSString * bucketName;
@property (nonatomic,copy) NSString * md5String;
@property (nonatomic, strong) NSNumber * flag;//int
/**
 * 原图
 */
@property (nonatomic,copy) NSString * fileUrl;
/**
 * 缩略图
 */
@property (nonatomic,copy) NSString * thumbnailUrl;

@property (nonatomic,copy) NSString * folderPath;

@property (nonatomic,copy) NSString * fileSuffix;

@end

NS_ASSUME_NONNULL_END
