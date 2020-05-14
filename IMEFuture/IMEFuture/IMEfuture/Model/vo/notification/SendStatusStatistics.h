//
//  SendStatusStatistics.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/15.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendStatusStatistics : NSObject

@property (nonatomic,strong) NSNumber * all;//Integer
@property (nonatomic,strong) NSNumber * unSend;//Integer
@property (nonatomic,strong) NSNumber * sent;//Integer
@property (nonatomic,strong) NSNumber * sendSuccess;//Integer
@property (nonatomic,strong) NSNumber * reSend;//Integer
@property (nonatomic,strong) NSNumber * sendFail;//Integer

@end
