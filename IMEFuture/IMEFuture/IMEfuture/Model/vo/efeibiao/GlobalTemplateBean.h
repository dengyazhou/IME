//
//  GlobalTemplateBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/2.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalTemplateBean : NSObject

/**
 全局模板明细ID
 */
@property (nonatomic, assign) NSInteger *globalTemplateFieldId;

/**
 全局模板对应的KEY
 */
@property (nonatomic, copy) NSString *fieldName;

/**
 全局模板默认名称
 */
@property (nonatomic, copy) NSString *showName;

/**
 用户全局模板明细ID
 */
@property (nonatomic, copy) NSString *globalTemplateInfoId;

/**
 用户自定义名称
 */
@property (nonatomic, copy) NSString *epShowName;


@end

NS_ASSUME_NONNULL_END
