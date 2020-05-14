//
//  PickerViewBG.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/7/2.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "PickerViewBG.h"
#import "VoHeader.h"


@interface PickerViewBG () <UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
    NSMutableArray *_arrayZone0;
    NSMutableArray *_arrayZone1;
    NSInteger _indexArrayZone0;//默认值999
    NSInteger _indexArrayZone1;//默认值999
}

@property (nonatomic,strong) UIView *viewBG;

@property (nonatomic,strong) UIView *view0;//取消 完成
@property (nonatomic,strong) UIPickerView *pickerView;



@end

@implementation PickerViewBG

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _indexArrayZone0 = 999;
        _indexArrayZone1 = 999;
        
        _arrayZone0 = [DatabaseTool t_ZoneSelectArrayWithMyid:[NSNumber numberWithInteger:1]];
        
        Zone *zone0 = _arrayZone0[0];
        _arrayZone1 = [DatabaseTool t_ZoneSelectArrayWithMyid:zone0.Myid];
        
        [self addSubview:self.viewBG];
        [self.viewBG addSubview:self.view0];
        [self.viewBG addSubview:self.pickerView];
        
        
        UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.numberOfTouchesRequired = 1;
        singleFingerOne.numberOfTapsRequired = 1;
        singleFingerOne.delegate = self;
        [self addGestureRecognizer:singleFingerOne];
    }
    return self;
}



- (UIView *)viewBG {
    if (!_viewBG) {
        _viewBG = [[UIView alloc] initWithFrame:CGRectMake(0, kMainH-215, kMainW, 215)];
//        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.backgroundColor = colorRGB(220, 220, 220);
    }
    return _viewBG;
}

- (UIView *)view0 {
    if (!_view0) {
        _view0 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 41)];
//        _view0.backgroundColor = [UIColor whiteColor];
        
        UIButton *button0 = [UIButton buttonWithType:UIButtonTypeSystem];
        button0.frame = CGRectMake(15, 0, (kMainW-15*2)/2, 41);
        [button0 setTitle:@"取消" forState:UIControlStateNormal];
        button0.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button0 addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchUpInside];
        [_view0 addSubview:button0];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        button1.frame = CGRectMake(CGRectGetMaxX(button0.frame), 0, CGRectGetWidth(button0.frame), 41);
        [button1 setTitle:@"完成" forState:UIControlStateNormal];
        button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button1 addTarget:self action:@selector(buttonFinish:) forControlEvents:UIControlEventTouchUpInside];
        [_view0 addSubview:button1];
        
    }
    return _view0;
}
- (void)buttonCancel:(UIButton *)sender {
    self.hidden = YES;
}
- (void)buttonFinish:(UIButton *)sender {
    self.hidden = YES;
    
    Zone *zone0;
    Zone *zone1;
    if (_indexArrayZone1 == 999) {//没有滚动过pickerView
        zone0 = _arrayZone0[0];
        zone1 = _arrayZone1[0];
    } else {
        zone0 = _arrayZone0[_indexArrayZone0];
        zone1 = _arrayZone1[_indexArrayZone1];
    }
    NSString *string = [NSString stringWithFormat:@"%@%@",zone0.name,zone1.name];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pickerViewBGNotificationTextField3" object:string];
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 41, kMainW, CGRectGetHeight(self.viewBG.frame)-41)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _arrayZone0?_arrayZone0.count:0;
    }
    if (component == 1) {
        return _arrayZone1?_arrayZone1.count:0;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        Zone *zone0 = _arrayZone0[row];
        
        _arrayZone1 = [DatabaseTool t_ZoneSelectArrayWithMyid:zone0.Myid];
        [pickerView reloadComponent:1];
    }
    
    _indexArrayZone0 = [pickerView selectedRowInComponent:0];
    _indexArrayZone1 = [pickerView selectedRowInComponent:1];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        Zone *zone0 = _arrayZone0[row];
        return zone0.name;
    }
    if (component == 1) {
        Zone *zone1 = _arrayZone1[row];
        return zone1.name;
    }
    return @"";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        //        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        pickerLabel.textColor = colorRGB(51, 51, 51);
        pickerLabel.numberOfLines = 0;
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.viewBG]) {
        return NO;
    }
    return YES;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap{
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
