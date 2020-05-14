//
//  UIViewXuanZeWuLiuGongSi.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewXuanZeXunPanTianShu.h"
#import "VoHeader.h"

@interface UIViewXuanZeXunPanTianShu () <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayData;
    NSString *_stringTemp;
}

@end

@implementation UIViewXuanZeXunPanTianShu

- (void)initPickerViewButtonClick:(void(^)(NSString *string))block buttonQuXiao:(void(^)())block1 {
    self.buttonBlock = block;
    self.buttonBlockQuXiao = block1;
    _arrayData = @[@"1天",@"3天",@"7天",@"15天",@"30天"];
    _stringTemp = _arrayData[0];
    self.pickerView.delegate = self;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _arrayData[row];
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
