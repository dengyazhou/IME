//
//  DrawingPreviewVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/8/7.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingPreviewVo : NSObject

/**
 * 本条数据在 版本/清单 下的图纸id
 */
@property (nonatomic, copy) NSString * adId;

/**
 * 零件版本ID
 */
@property (nonatomic,copy) NSString * versionId;

/**
 * 清单id
 */
@property (nonatomic,copy) NSString * bomAccId;

/**
 * 小图预览url
 */
@property (nonatomic,copy) NSString * smallPreviewUrl;

/**
 * 中图预览url
 */
@property (nonatomic,copy) NSString * mediumPreviewUrl;

/**
 * 大图预览url
 */
@property (nonatomic,copy) NSString * bigPreviewUrl;

/**
 * 图纸状态
 * 图纸状态 -1:转换失败, 0:等待转换, >=1: 转换成功
 */
@property (nonatomic,copy) NSString * fileStatus;

@end

NS_ASSUME_NONNULL_END
