//
//  ModelGetInformationList.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/8.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ModelGetInformationList.h"
#import "MJExtension.h"

@implementation ModelGetInformationList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"newsList":@"ModelGetInformationListList",
          @"offlineList":@"ModelGetInformationListList",
           @"onlineList":@"ModelGetInformationListList"};
}

@end


@implementation ModelGetInformationListList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"tagRes":@"ModelGetInformationListListTagRes"};
}

@end


@implementation ModelGetInformationListListTagRes


@end
