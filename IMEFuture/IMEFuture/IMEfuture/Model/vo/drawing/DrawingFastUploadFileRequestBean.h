//
//  DrawingFastUploadFileRequestBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/17.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawingFastUploadFileRequestBean : NSObject

/** 文件路径 必填*/
@property (nonatomic,copy) NSString * filePath;

/** 文件名 必填*/
@property (nonatomic,copy) NSString * fileName;

/** 真实文件名 必填*/
@property (nonatomic,copy) NSString * fileRealName;

/** 阿里 oss 必填*/
@property (nonatomic,copy) NSString * bucketName;

/** 文件大小 必填*/
@property (nonatomic,strong) NSNumber * fileSize;//Long

@end
