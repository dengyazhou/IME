//
//  CauseDetailVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/3/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AttachmentVo.h"
#import "UploadImageBean.h"

NS_ASSUME_NONNULL_BEGIN

@interface CauseDetailVo : NSObject

/**
 * 缺陷原因
 */
@property (nonatomic,copy) NSString * causeCode;

/**
 * 缺陷原因 名称，自己创建
 */
@property (nonatomic,copy) NSString * causeText;

/**
 * 数量
 */
@property (nonatomic,strong) NSNumber * quantity;//Double

/**
 * 图片集合
 */
@property (nonatomic,strong) NSMutableArray <__kindof AttachmentVo *>* pictureAttachmentVoList;//AttachmentVo


/**
 * 图片集合，自己创建
 */
@property (nonatomic,strong) NSMutableArray <__kindof UploadImageBean *> *uploadImageBeanList;//UploadImageBean

@end

NS_ASSUME_NONNULL_END
