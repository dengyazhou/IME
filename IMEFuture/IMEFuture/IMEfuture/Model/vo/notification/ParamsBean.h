//
//  ParamsBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/8/17.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParamsBean : NSObject

/**
 * 短信模板参数名
 */
@property (nonatomic,copy) NSString * name;

/**
 * 短信模板参数值
 */
@property (nonatomic,copy) NSString * value;

@end
