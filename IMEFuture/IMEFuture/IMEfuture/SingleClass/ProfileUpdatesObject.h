//
//  ProfileUpdatesObject.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/2/28.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// APP每次版本升级之后，只会显示一次的页面或功能的配置。对象序列化，然后存储在沙盒中。
/**
 存入
 NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"profileUpdatesObject.data"];
 ProfileUpdatesObject *profileUpdatesObject = [[ProfileUpdatesObject alloc] init];
 [NSKeyedArchiver archiveRootObject:profileUpdatesObject toFile:path];
 
 
 取出
 NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"profileUpdatesObject.data"];
 ProfileUpdatesObject *profileUpdatesObject = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
 
 
 每次修改后必须再次存入，否则修改无效。也就是说不是指针。
 */
@interface ProfileUpdatesObject : NSObject <NSSecureCoding>

@property (nonatomic, assign) Boolean personalPrivacyGuidelines;//个人隐私保护指引

@end

NS_ASSUME_NONNULL_END
