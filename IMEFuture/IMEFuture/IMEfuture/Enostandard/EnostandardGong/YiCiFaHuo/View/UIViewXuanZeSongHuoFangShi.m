//
//  UIViewXuanZeSongHuoFangShi.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewXuanZeSongHuoFangShi.h"
#import "VoHeader.h"

@interface UIViewXuanZeSongHuoFangShi () <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayData;
    NSString *_stringTemp;
}

@end

@implementation UIViewXuanZeSongHuoFangShi

- (void)initPickerViewButtonClick:(void (^)(NSString *string))block with:(NSArray *)dataArray {
    self.buttonBlock = block;
    _arrayData = dataArray;
    _stringTemp = _arrayData[0];
    self.pickerView.delegate = self;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([_arrayData containsObject:@"SUPPLIER"]) {
        return [NSString DeliveryMethod:_arrayData[row]];
    } else {
        return _arrayData[row];
    }
    
    
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
    self.buttonBlock(_stringTemp);//[NSString LogisticsEnum:_stringTemp];
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
