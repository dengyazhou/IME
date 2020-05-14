//
//  OperationVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/12/5.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OperationVo : NSObject

/**
 * 工厂代码
 */
@property (nonatomic,copy) NSString *siteCode;

/**
 * 工序编号 NVARCHAR(20)
 */
@property (nonatomic,copy) NSString *operationCode;

/**
 * 工序描述 NVARCHAR(60)
 */
@property (nonatomic,copy) NSString *operationText;



@end
