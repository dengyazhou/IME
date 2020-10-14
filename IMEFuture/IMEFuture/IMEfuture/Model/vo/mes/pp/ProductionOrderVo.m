//
//  ProductionOrderVo.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/4.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ProductionOrderVo.h"

@implementation ProductionOrderVo
+ (NSDictionary *)mj_objectClassInArray {
    return @{
                @"workCenterList":@"WorkCenterVo",
                @"materiaProcessAssignList":@"MateriaProcessAssignVo",
                @"productionControlVoList":@"ProductionControlVo"
    };
}

@end
