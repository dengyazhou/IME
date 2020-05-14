//
//  NewsBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BaseBean.h"

@interface NewsBean : BaseBean

/**
 * ID
 */
@property (nonatomic,copy) NSString * newsId;

/**
 * 是否是活动  1 是 0 否
 */
@property (nonatomic,strong) NSNumber * isActivity;//Integer

/**
 * 活动开始时间
 */
@property (nonatomic,strong) NSDate * activityBegTm;

/**
 * 活动结束时间
 */
@property (nonatomic,strong) NSDate * activityEndTm;

@end
