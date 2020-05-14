//
//  ProjectCell.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/1/4.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseProjectInfo.h"

@interface ProjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label0;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (strong, nonatomic) PurchaseProject *purchaseProject;

@end
