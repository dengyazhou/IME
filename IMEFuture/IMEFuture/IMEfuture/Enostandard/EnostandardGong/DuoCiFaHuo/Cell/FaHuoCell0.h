//
//  FaHuoCell0.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/16.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PurchaseInfo.h"

@interface FaHuoCell0 : UITableViewCell

@property (nonatomic,strong) PurchaseInfo *model;

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;



@end