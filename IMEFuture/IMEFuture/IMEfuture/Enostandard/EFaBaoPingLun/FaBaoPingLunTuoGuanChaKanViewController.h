//
//  FaBaoPingLunTuoGuanChaKanViewController.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TradeOrder.h"

@interface FaBaoPingLunTuoGuanChaKanViewController : UIViewController

@property (nonatomic,strong) TradeOrder *tradeOrder;

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailUrl;

@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;

@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UIView *viewBGHight;
@end
