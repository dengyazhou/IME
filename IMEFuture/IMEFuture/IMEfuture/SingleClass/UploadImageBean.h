//
//  UploadImageBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/27.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadImageBean : NSObject

@property (nonatomic,strong) NSData *data;

/**
 服务端定义的字段，和服务端保持一致即可
 */
@property (nonatomic,copy) NSString *name;

/**
 文件名    必须有后缀    例如.png
 */
@property (nonatomic,copy) NSString *fileName;

/**
 图片类型  image/png 或 image/jpeg，iOS 传 image/png
 */
@property (nonatomic,copy) NSString *mimeType;

@end

NS_ASSUME_NONNULL_END
