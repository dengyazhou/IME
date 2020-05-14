//
//  EmailNotification.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmailNotification : NSObject

/**
 * 邮件标题
 */
@property (nonatomic,copy) NSString * subject;

/**
 * 邮件内容
 */
@property (nonatomic,copy) NSString * content;

@end
