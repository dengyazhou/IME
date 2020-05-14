//
//  ECaiTuoGuanSupplierViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/11/11.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoHeader.h"

@interface ECTuoGuanSupplierViewController : UIViewController

@property (nonatomic,strong) EnterpriseRelation * enterpriseRelationSuper;

@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;
@property (weak, nonatomic) IBOutlet UILabel *zoneStr;


@end
