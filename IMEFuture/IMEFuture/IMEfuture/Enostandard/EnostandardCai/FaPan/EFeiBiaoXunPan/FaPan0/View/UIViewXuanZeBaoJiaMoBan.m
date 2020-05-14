//
//  UIViewXuanZeWuLiuGongSi.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewXuanZeBaoJiaMoBan.h"
#import "VoHeader.h"

@interface UIViewXuanZeBaoJiaMoBan () <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayData;
    NSInteger _stringTemp;
}

@end

@implementation UIViewXuanZeBaoJiaMoBan

- (void)initPickerViewWithArray:(NSMutableArray *)dataArray ButtonClick:(void(^)(NSInteger index))block {
    self.buttonBlock = block;

    _arrayData = dataArray;
    _stringTemp = 0;
    self.pickerView.delegate = self;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    QuotationTemplate *quotationTemplate = _arrayData[row];
    return quotationTemplate.quotationTemplateName;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayData.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    _stringTemp = _arrayData[row];
    _stringTemp = row;
}

- (IBAction)buttonQuRen:(UIButton *)sender {
    [self removeFromSuperview];
    self.buttonBlock(_stringTemp);
}

- (IBAction)buttonQuXiao:(id)sender {
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
