//
//  AccDrawingInter.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/1/6.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccDrawingInter : NSObject

/**
 * 图纸id
 */
@property (nonatomic,copy) NSString * adId;

/**
 * 是否有预览
 */
@property (nonatomic,assign) Boolean hasPreview;//Boolean

/**
 * 预览图路径(缩略图)
 */
@property (nonatomic,copy) NSString * previewUrl;

@end
