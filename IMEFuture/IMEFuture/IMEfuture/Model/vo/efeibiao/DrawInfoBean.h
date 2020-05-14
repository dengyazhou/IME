//
//  DrawInfoBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/4/2.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawInfoBean : NSObject

@property (nonatomic, copy) NSString *adId;
@property (nonatomic, copy) NSString *bomAccId;
@property (nonatomic, copy) NSString *versionId;
@property (nonatomic, copy) NSString *smallPreviewUrl;
@property (nonatomic, copy) NSString *mediumPreviewUrl;
@property (nonatomic, copy) NSString *bigPreviewUrl;
@property (nonatomic, strong) NSNumber *fileStatus;//-1:失败, 0:无图纸, 1: 转换成功,  2 :转换中
@property (nonatomic, copy) NSString *fileId;
@property (nonatomic, copy) NSString *fileLocalName;
@property (nonatomic, copy) NSString *fileLastName;


@end

NS_ASSUME_NONNULL_END
