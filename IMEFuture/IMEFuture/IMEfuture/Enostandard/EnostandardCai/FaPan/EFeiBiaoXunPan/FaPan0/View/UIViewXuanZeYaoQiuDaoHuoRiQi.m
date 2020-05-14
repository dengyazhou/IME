//
//  UIViewXuanZeShiJian.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewXuanZeYaoQiuDaoHuoRiQi.h"
#import "ToolTransition.h"
#import "MyAlertCenter.h"

@interface UIViewXuanZeYaoQiuDaoHuoRiQi ()

@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;

@end

@implementation UIViewXuanZeYaoQiuDaoHuoRiQi

- (void)initDataPickerButtonClick:(void(^)(NSString *string))block buttonQuXiao:(void(^)())block1 {
    self.dataPicker.backgroundColor = [UIColor whiteColor];
    self.buttonBlock = block;
    self.buttonBlockQuXiao = block1;//UIControlEventEditingDidBegin textField只会第一次调用，取消第一相应后，以备下次点击
}

- (IBAction)buttonWanCheng:(UIButton *)sender {
    NSDate *pickerDate = [self.dataPicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSString *dateString = [ToolTransition stringFromDate:pickerDate];
//    NSLog(@"格式化显示时间：%@",dateString);
    
    NSInteger aa = [ToolTransition compareDate:dateString withDate:[ToolTransition stringFromDate:[NSDate dateWithTimeInterval:-23*60*60 sinceDate:[NSDate date]]]];
    if (aa == -1 || aa == 0) {//dateString 大 或 相等(无法相等，UIPickView滑动结束的时间 没法和 点击完成的的时间 相等)
        self.buttonBlock(dateString);
        [self removeFromSuperview];
    } else {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"要求到货日期必须大于当前日期"];
        return;
    }
    
    
}

- (IBAction)buttonQuXiao:(UIButton *)sender {
    self.buttonBlockQuXiao();
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
