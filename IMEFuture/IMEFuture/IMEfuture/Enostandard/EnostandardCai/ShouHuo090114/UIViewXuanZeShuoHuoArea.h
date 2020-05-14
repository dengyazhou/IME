//
//  UIViewXuanZeShuoHuoArea.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AreaResBean.h"

@interface UIViewXuanZeShuoHuoArea : UIView


@property (nonatomic,copy) void(^buttonBlock)(AreaResBean *model);

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (void)initPickerViewButtonClick:(void (^)(AreaResBean *model1))block with:(NSArray *)dataArray;


@end
