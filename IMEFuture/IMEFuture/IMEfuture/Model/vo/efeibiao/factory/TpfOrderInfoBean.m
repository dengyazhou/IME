//
//  TpfOrderInfoBean.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/11.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "TpfOrderInfoBean.h"
#import "MJExtension.h"

@implementation TpfOrderInfoBean

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"confirmInfos":@"TpfConfirmInfo"};
}

@end
