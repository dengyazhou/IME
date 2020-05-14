//
//  TGSupplierTag.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/6/29.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGSupplierTag : NSObject

@property (nonatomic,copy) NSString * tagId;

/**
 * relationId 标签名
 */
@property (nonatomic,copy) NSString * tagName;

/**
 * 企业Id
 */
@property (nonatomic,copy) NSString * manufacturerId;

/**
 * 查询企业关系Id
 */
@property (nonatomic,copy) NSString *sec_relationId;

@property (nonatomic,strong) NSMutableArray * sei_tagName;//String

@end
