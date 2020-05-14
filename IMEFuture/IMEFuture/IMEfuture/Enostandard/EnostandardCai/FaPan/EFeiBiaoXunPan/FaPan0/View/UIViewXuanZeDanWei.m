//
//  UIViewXuanZeWuLiuGongSi.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewXuanZeDanWei.h"
#import "VoHeader.h"

@interface UIViewXuanZeDanWei () <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayData;
    NSString *_stringTemp;
}

@end

@implementation UIViewXuanZeDanWei

- (void)initPickerViewButtonClick:(void(^)(NSString *string))block buttonQuXiao:(void(^)())block1 {
    self.buttonBlock = block;
    self.buttonBlockQuXiao = block1;

//    _arrayData = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N"];
    _arrayData = @[@"件",@"张",@"只",@"双",@"台",@"卷",@"辆",@"箱",@"包",@"套",@"桶",@"打",@"袋",@"个"];
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
