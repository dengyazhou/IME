//
//  FaBaoPingLunViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TradeOrder;
@interface FaBaoPingLunTuoGuanViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic,strong) TradeOrder *tradeOrder;


@property (weak, nonatomic) IBOutlet UIImageView *thumbnailUrl;

@property (weak, nonatomic) IBOutlet UILabel *enterpriseName;

@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;


@property (weak, nonatomic) IBOutlet UIView *pickerViewBG;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;


@end
