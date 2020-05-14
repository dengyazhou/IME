//
//  RefreshManager.h
//  DemoOC
//
//  Created by 邓亚洲 on 2019/6/27.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RefreshManager : NSObject

+ (instancetype)shareRefreshManager;

/**
 * 刷新ECInquiryViewController，设置eCInquiryVC值，随便设置，KVO
 */
@property (nonatomic,copy) NSString *eCInquiryVC;

/**
 * 刷新ECOrderViewController
 */
@property (nonatomic,copy) NSString *eCOrderVC;

/**
 * 刷新EGInquiryViewController
 */
@property (nonatomic,copy) NSString *eGInquiryVC;

/**
 * 刷新EGOrderViewController
 */
@property (nonatomic,copy) NSString *eGOrderVC;

@end

NS_ASSUME_NONNULL_END
