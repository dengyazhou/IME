//
//  AttachmentVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/2.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttachmentVo : NSObject


/**
 存储路径
 */
@property (nonatomic,copy) NSString * savePath;

/**
 文件名
 */
@property (nonatomic,copy) NSString * fileName;

/**
 文件大小（KB）
 */
@property (nonatomic,strong) NSNumber * fileSize;//long

/**
 哈希码
 */
@property (nonatomic,copy) NSString * hashCode;


/*
 自己添加
 */
@property (nonatomic,strong) NSData *data;

@end
