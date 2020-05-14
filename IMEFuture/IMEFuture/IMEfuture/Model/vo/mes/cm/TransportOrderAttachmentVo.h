//
//  TransportOrderAttachmentVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/9.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJExtension.h>


NS_ASSUME_NONNULL_BEGIN

@interface TransportOrderAttachmentVo : NSObject

/**
 * ID
 */
@property (nonatomic,strong) NSNumber * idDYZ;//long

/**
 * 运输单ID
 */
@property (nonatomic,strong) NSNumber * transportOrderId;//long

/**
 * 附件编号（存储名）
 */
@property (nonatomic,copy) NSString * attachmentCode;

/**
 * 文件名
 */
@property (nonatomic,copy) NSString * fileName;

@end

NS_ASSUME_NONNULL_END
