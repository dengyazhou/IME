//
//  OssUploadResBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/11/5.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "OssUploadResBean.h"

@implementation OssUploadResBean

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"subfiles" : @"OssUploadBean"
             };
}

@end
