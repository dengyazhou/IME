//
//  TiWenViewController.h
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/5.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InquiryOrder;

@interface TiWenViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextView *textViewTiWen;
@property (nonatomic,strong) InquiryOrder *inquiryOrder;


@property (weak, nonatomic) IBOutlet UILabel *labelXuanZeYaoTiWenDeLingJian;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelXunZeYaoTiWenDeLingJianTrailing;
@property (strong,nonatomic) UIView *viewPickView0;
@property (strong,nonatomic) UIView *viewPickView1;
@property (strong,nonatomic) UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewNext;

@end
