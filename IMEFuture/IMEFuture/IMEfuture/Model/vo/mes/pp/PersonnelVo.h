//
//  PersonnelVo.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/21.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonnelVo : NSObject

/**
 * 工厂编号
 */
@property (nonatomic,copy) NSString * siteCode;
/**
 * 人员编号
 */
@property (nonatomic,copy) NSString * personnelCode;
/**
 * 人员名称
 */
@property (nonatomic,copy) NSString * personnelName;
/**
 * 是否需要密码（0 不需要 1 需要）
 */
@property (nonatomic,strong) NSNumber * needPassword;

@end
