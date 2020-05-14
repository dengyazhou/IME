//
//  FaBaoPingLunViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TradeOrder;
@interface FaBaoPingLunGongViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) TradeOrder *tradeOrder;

@property (weak, nonatomic) IBOutlet UIButton *button00;
@property (weak, nonatomic) IBOutlet UIButton *button01;
@property (weak, nonatomic) IBOutlet UIButton *button02;
@property (weak, nonatomic) IBOutlet UIButton *button03;
@property (weak, nonatomic) IBOutlet UIButton *button04;

@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;

@property (weak, nonatomic) IBOutlet UIButton *button20;
@property (weak, nonatomic) IBOutlet UIButton *button21;
@property (weak, nonatomic) IBOutlet UIButton *button22;
@property (weak, nonatomic) IBOutlet UIButton *button23;
@property (weak, nonatomic) IBOutlet UIButton *button24;

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailUrl;
@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;
@property (weak, nonatomic) IBOutlet UILabel *labelZiShu;

@end
