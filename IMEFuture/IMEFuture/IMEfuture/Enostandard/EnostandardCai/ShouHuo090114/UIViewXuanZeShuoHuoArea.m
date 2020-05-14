//
//  UIViewXuanZeShuoHuoArea.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/12/21.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "UIViewXuanZeShuoHuoArea.h"
#import "VoHeader.h"

@interface UIViewXuanZeShuoHuoArea () <UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_arrayData;
    AreaResBean *_tempareaResBean;
}

@end

@implementation UIViewXuanZeShuoHuoArea

- (void)initPickerViewButtonClick:(void (^)(AreaResBean *model1))block with:(NSArray *)dataArray {
    self.buttonBlock = block;
    _arrayData = dataArray;
    if (!_arrayData || _arrayData.count == 0) {
        _tempareaResBean = [[AreaResBean alloc] init];
    } else {
        _tempareaResBean = _arrayData[0];
    }
    self.pickerView.delegate = self;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    AreaResBean *model = _arrayData[row];
    return model.attributeName;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _arrayData.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _tempareaResBean = _arrayData[row];
}

- (IBAction)buttonQuRen:(UIButton *)sender {
    [self removeFromSuperview];
    self.buttonBlock(_tempareaResBean);
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
