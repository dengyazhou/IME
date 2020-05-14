//
//  LingJianXiangQingViewController2.h
//  IMEFuture
//
//  Created by 邓亚洲 on 16/9/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>


@class TradeOrderItemFile;

@class AccDrawingInter;

@interface LingJianXiangQingDingDanViewController2 : UIViewController

@property (nonatomic,strong) NSNumber * isMatchDrawingCloud;//Integer

@property (nonatomic,strong) TradeOrderItemFile *tradeOrderItemFile;

@property (nonatomic,strong) AccDrawingInter *accDrawingInter;


@property (weak, nonatomic) IBOutlet UIView *imageViewBG;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@property (weak, nonatomic) IBOutlet UIView *webBG;//以后会去掉
@end
