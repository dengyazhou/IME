//
//  XuanZeShouHuoDiZhiVC.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/1/31.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnterpriseAddressBean.h"

@interface XuanZeShouHuoDiZhiVC : UIViewController

@property (nonatomic,strong) EnterpriseAddressBean *enterpriseAddressBean;

@property (nonatomic,copy) void(^backBlock)(EnterpriseAddressBean *enterpriseAddressBean);
- (void)backEnterpriseAddressBean:(void(^)(EnterpriseAddressBean *enterpriseAddressBean))block;

@end
