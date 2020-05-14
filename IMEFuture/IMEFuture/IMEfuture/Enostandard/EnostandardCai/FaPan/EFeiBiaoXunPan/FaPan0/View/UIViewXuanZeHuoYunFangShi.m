//
//  UIViewXuanZeWuLiuGongSi.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewXuanZeHuoYunFangShi.h"
#import "VoHeader.h"

@interface UIViewXuanZeHuoYunFangShi () <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayData;
    NSString *_stringTemp;
}

@end

@implementation UIViewXuanZeHuoYunFangShi

- (void)initPickerViewButtonClick:(void(^)(NSString *string))block buttonQuXiao:(void(^)(void))block1 {
    self.buttonBlock = block;
    self.buttonBlockQuXiao = block1;
    _arrayData = @[@"A",@"B",@"C",@"D",@"E",@"F"];
    _stringTemp = _arrayData[0];
    self.pickerView.delegate = self;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString DeliveryMethod:_arrayData[row]];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayData.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _stringTemp = _arrayData[row];
}

- (IBAction)buttonQuRen:(UIButton *)sender {
    [self removeFromSuperview];
    self.buttonBlock(_stringTemp);
}

- (IBAction)buttonQuXiao:(id)sender {
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
