//
//  UIViewXuanZeShiJian.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewXuanZeShiJian.h"

@interface UIViewXuanZeShiJian ()

@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;

@property (copy, nonatomic) NSString *formatter;

@end

@implementation UIViewXuanZeShiJian

//@"yyMMddHHmmss"
- (void)initDataPickerButtonClick:(void(^)(NSString *string))block formatter:(NSString *)formatter {
    self.dataPicker.backgroundColor = [UIColor whiteColor];
//    self.dataPicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.formatter = formatter;
    self.buttonBlock = block;
}

- (IBAction)buttonWanCheng:(UIButton *)sender {
    NSDate *pickerDate = [self.dataPicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:self.formatter];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
//    NSLog(@"格式化显示时间：%@",dateString);
    self.buttonBlock(dateString);
    
    [self removeFromSuperview];
}

- (IBAction)buttonQuXiao:(UIButton *)sender {
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
