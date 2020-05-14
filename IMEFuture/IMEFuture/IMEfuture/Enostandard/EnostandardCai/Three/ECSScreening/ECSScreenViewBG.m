//
//  ECSScreenView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/2.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "ECSScreenViewBG.h"

#import "Header.h"

#import "ECSScreenView.h"
#import "PickerViewBG.h"

@interface ECSScreenViewBG () <UIGestureRecognizerDelegate,ECSScreenViewDelegate> {
    CGFloat _height_NavBar;
}

@property (nonatomic,strong) ECSScreenView *eCSScreenView;
@property (nonatomic,strong) PickerViewBG *pickerViewBG;

@end

@implementation ECSScreenViewBG

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.eCSScreenView]) {
        return NO;
    }
    if ([touch.view isDescendantOfView:self.pickerViewBG]) {
        return NO;
    }
    return YES;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap{
    [self removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame withArrayTGSupplierTag:(NSMutableArray *)arrayTGSupplierTag
{
    self = [super initWithFrame:frame];
    if (self) {
//        _height_NavBar = Height_NavBar;
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        self.eCSScreenView = [[ECSScreenView alloc] initWithFrame:CGRectMake(0, 64, kMainW, 0) withArrayTGSupplierTag:arrayTGSupplierTag];//64没有，里面在layoutSubviews 重新设置了坐标
        self.eCSScreenView.delegate = self;
        [self addSubview:self.eCSScreenView];
        
        self.pickerViewBG = [[PickerViewBG alloc] initWithFrame:self.frame];
        [self addSubview:self.pickerViewBG];
        self.pickerViewBG.hidden = YES;
        
        UITapGestureRecognizer *singleFingerOne  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.numberOfTouchesRequired = 1;
        singleFingerOne.numberOfTapsRequired = 1;
        singleFingerOne.delegate = self;
        [self addGestureRecognizer:singleFingerOne];
        
        
    }
    return self;
}

- (void)eCSScreenViewDelegateShowPickerBG {
    self.pickerViewBG.hidden = NO;
}

//点击ECSScreenView 上的完成 执行
- (void)eCSScreenViewDelegateIndex:(NSInteger)labelTag CompanyName:(NSString *)company Netherlands:(NSString *)district {
    self.hidden = YES;
    
    if ([self.delegate respondsToSelector:@selector(eCSScreenViewBGDelegateIndex:CompanyName:Netherlands:)]) {
        [self.delegate eCSScreenViewBGDelegateIndex:labelTag CompanyName:company Netherlands:district];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
