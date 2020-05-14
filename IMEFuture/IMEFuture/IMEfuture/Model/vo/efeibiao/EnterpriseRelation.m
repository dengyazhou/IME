//
//  EnterpriseRelation.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/30.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EnterpriseRelation.h"
#import "MJExtension.h"
#import "EnterpriseRelationTag.h"

@implementation EnterpriseRelation

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"enterpriseRelationTag":@"EnterpriseRelationTag",@"tagList":@"TGSupplierTag"};
}

@end
