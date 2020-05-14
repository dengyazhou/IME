//
//  UIViewGYSJiePanJuJueYuanYing.h
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewGYSJiePanJuJueYuanYing : UIView

@property (nonatomic,copy) void(^buttonBlock)(NSString *string);
@property (nonatomic,copy) void(^buttonBlockQuXiao)();

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (void)initPickerViewButtonClick:(void(^)(NSString *string))block buttonQuXiao:(void(^)())block1;


@end
