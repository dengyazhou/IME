//
//  DrawingMsgBean.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/4/2.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingMsgBean : NSObject

@property (nonatomic, copy) NSString *smallPreviewUrl;
@property (nonatomic, copy) NSString *mediumPreviewUrl;
@property (nonatomic, copy) NSString *bigPreviewUrl;

@end

NS_ASSUME_NONNULL_END
